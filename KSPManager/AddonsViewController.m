//
//  AddonsViewController.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/11/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "AddonsViewController.h"
#import "Part.h"
#import "Plugin.h"
#import "Ship.h"
#import "KerbalNet.h"


#define kKeyContentArray    @"contentArray"
#define kKeySortDescriptors @"sortDescriptors"
#define kAssetDragData      @"AssetDragData"

#define kKSP_APP_ID @"000000000004"
#define kKSP_APP_TK @"BB1044ULL1O0NUN7TR"



@implementation AddonsViewController

@synthesize installedArrayController;
@synthesize availableArrayController;
@synthesize installedTableView;
@synthesize availableTableView;
@synthesize addButton;
@synthesize removeButton;
@synthesize actionButton;
@synthesize categoryControl;

@synthesize partSortDescriptors = _partSortDescriptors;
@synthesize pluginSortDescriptors = _pluginSortDescriptors;
@synthesize shipSortDescriptors = _shipSortDescriptors;
@synthesize kerbalNet = _kerbalNet;


- (void)awakeFromNib
{
    NSArray *validDragTypes = @[ NSURLPboardType,NSFilenamesPboardType,kAssetDragData ];
    
    [self.installedTableView registerForDraggedTypes:validDragTypes];
    [self.availableTableView registerForDraggedTypes:validDragTypes];
    
    [self.installedTableView setDoubleAction:@selector(moveSelectedToAvailable:)];
    [self.installedTableView setTarget:self];

    [self.availableTableView setDoubleAction:@selector(moveSelectedToInstalled:)];
    [self.availableTableView setTarget:self];
    
    [self.installedTableView setDraggingDestinationFeedbackStyle:NSTableViewDraggingDestinationFeedbackStyleNone];
    [self.availableTableView setDraggingDestinationFeedbackStyle:NSTableViewDraggingDestinationFeedbackStyleNone];
    
    self.installedArrayController.filterPredicate = [NSPredicate predicateWithBlock:^BOOL(Asset * evaluatedObject, NSDictionary *bindings) {
        return evaluatedObject.isInstalled;
    }];
    
    self.availableArrayController.filterPredicate = [NSPredicate predicateWithBlock:^BOOL(Asset *evaluatedObject, NSDictionary *bindings) {
        return evaluatedObject.isAvailable;
    }];
    

    [self controlDidChange:self.categoryControl];
}

- (void)refresh:(BOOL)reset
{
    [self.installedTableView deselectAll:self];
    [self.installedArrayController rearrangeObjects];
    [self.availableTableView deselectAll:self];
    [self.availableArrayController rearrangeObjects];
    [self.removeButton setEnabled:NO];
    [self.actionButton setEnabled:NO];

    if( reset == YES ) {
        [self.categoryControl setLabel:@"Parts" forSegment:0];
        [self.categoryControl setLabel:@"Plugins" forSegment:1];
        [self.categoryControl setLabel:@"Ships" forSegment:2];
    }
}



- (void)setBadgesForAssets:(NSArray *)assets
{
    NSInteger partCount = 0;
    NSInteger pluginCount = 0;
    NSInteger shipCount = 0;

    for(Asset *asset in assets) {
     
        if( [asset isMemberOfClass:[Part class]] ) {
            partCount ++;
            continue;
        }
        
        if( [asset isMemberOfClass:[Plugin class]] ) {
            pluginCount ++;
            continue;
        }
            
        if( [asset isMemberOfClass:[Ship class]] ) {
            shipCount ++;
            continue;
        }
    }
    
    if( partCount )
        [self.categoryControl setLabel:[@"Parts" stringByAppendingFormat:@" (%ld)",partCount] forSegment:0];
    
    if( pluginCount )
        [self.categoryControl setLabel:[@"Plugins" stringByAppendingFormat:@" (%ld)",pluginCount] forSegment:1];

    if( shipCount )
        [self.categoryControl setLabel:[@"Ships" stringByAppendingFormat:@" (%ld)",shipCount] forSegment:2];


}


#pragma mark -
#pragma mark Drag & Drop Support


- (BOOL)tableView:(NSTableView *)aTableView writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard *)pboard
{
    // it's possible to drag without causing a selection
    // because we are using the selectedObjects property
    // we need to make sure the drag targets are selected
    [aTableView selectRowIndexes:rowIndexes byExtendingSelection:NO];
    
    // this data is ignored by the drop site, but we need to send something
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:rowIndexes];
    
    [pboard clearContents];
    [pboard setData:data forType:kAssetDragData];
    
    return YES;
}

- (NSDragOperation)tableView:(NSTableView *)tableView validateDrop:(id<NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation
{
    return NSDragOperationEvery;
}


- (BOOL)tableView:(NSTableView *)aTableView acceptDrop:(id <NSDraggingInfo>)info
              row:(NSInteger)row dropOperation:(NSTableViewDropOperation)operation
{
    NSPasteboard *pboard = [info draggingPasteboard];
    

    
    if( [[pboard types] containsObject:NSURLPboardType] ) {
        NSURL *url = [NSURL URLFromPasteboard:pboard];
        NSArray *assets = [self.ksp createAssetsWith:url install:(aTableView==self.installedTableView)];
        [self setBadgesForAssets:assets];
        [self refresh:NO];
        return YES;
    }
    
#if 0
    if( [[pboard types] containsObject:NSFilenamesPboardType]){
        NSArray *filenames = [pboard propertyListForType:NSFilenamesPboardType];
        for(NSString *filename in filenames) {
            NSURL *url = [NSURL fileURLWithPath:filename];
            NSLog(@"filename %@ url %@",filename,url);
            NSArray *assets = [self.ksp createAssetsWith:url install:(aTableView==self.installedTableView)];
            [self setBadgesForAssets:assets];
        }
        [self refresh:NO];
        return YES;
    }
#endif
    
    if( [[pboard types] containsObject:kAssetDragData] ) {
        // the data isn't important, so we ignore it
        if( aTableView == self.installedTableView ) {
            // moving from available to installed
            [self moveSelectedToInstalled:aTableView];
            return YES;
        }
        
        if( aTableView == self.availableTableView ) {
            // moving from installed to available
            [self moveSelectedToAvailable:aTableView];
            return YES;
        }
    }
    
    return NO;
}



#pragma mark -
#pragma mark Properties


- (NSArray *)partSortDescriptors
{
    if( _partSortDescriptors == nil ) {
        _partSortDescriptors = [NSArray arrayWithObjects:
                                [NSSortDescriptor sortDescriptorWithKey:@"category"
                                                              ascending:YES],

                                [NSSortDescriptor sortDescriptorWithKey:@"assetTitle"
                                                              ascending:YES],
                                nil];
        
    }
    return _partSortDescriptors;
}

- (NSArray *)pluginSortDescriptors
{
    if( _pluginSortDescriptors == nil ) {
        _pluginSortDescriptors = [NSArray arrayWithObjects:
                                  [NSSortDescriptor sortDescriptorWithKey:@"assetTitle"
                                                                ascending:YES],
                                  [NSSortDescriptor sortDescriptorWithKey:@"assetCategory"
                                                                ascending:YES],
                                  nil];

    }
    return _pluginSortDescriptors;
}

- (NSArray *)shipSortDescriptors
{
    if( _shipSortDescriptors == nil ) {
        _shipSortDescriptors = [NSArray arrayWithObjects:
                                    [NSSortDescriptor sortDescriptorWithKey:@"assetTitle"
                                                                  ascending:YES],
                                    [NSSortDescriptor sortDescriptorWithKey:@"assetCategory"
                                                                  ascending:YES],
                                    nil];
    }
    
    return _shipSortDescriptors;
}

- (KerbalNet *)kerbalNet
{
    if( _kerbalNet == nil ) {
        _kerbalNet = [[KerbalNet alloc] initWithApplicationID:kKSP_APP_ID andApplicationToken:kKSP_APP_TK];
    }
    return _kerbalNet;
}

#pragma mark -
#pragma mark Private Instance Methods

- (void) alertDidEnd:(NSAlert *)alert returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
    
    if( (__bridge NSButton *)contextInfo == self.removeButton){

        NSArray *selected;
        
        switch (returnCode) {
            case NSAlertDefaultReturn:
                selected = [self.availableArrayController selectedObjects];
                for(Part *part in selected) {
                    [self.ksp unmanage:part];
                }
                [self.availableArrayController rearrangeObjects];
                [self.availableTableView deselectAll:self];
                break;
                
            case NSAlertAlternateReturn:
            default:
                break;
        }
        [self refresh:YES];
    }
    
    return ;
}

- (void)rebindArrayController:(NSArrayController *)arrayController key:(NSString *)key toNewKeypath:(NSString *)keypath
{
    [arrayController unbind:key];
    
    [arrayController bind:key
                 toObject:self
              withKeyPath:keypath
                  options:nil];
}

- (IBAction)moveSelectedToAvailable:(id)sender
{
    for(Asset *asset in self.installedArrayController.selectedObjects) {
        
        if( [self.ksp uninstall:asset] == NO ){
            // modal alert to tell user why the uninstall failed
            NSAlert *alert = [NSAlert alertWithError:asset.error];
            [alert beginSheetModalForWindow:self.view.window
                              modalDelegate:self
                             didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:)
                                contextInfo:nil];
        }
    }
    [self refresh:YES];
}

- (IBAction)moveSelectedToInstalled:(id)sender
{
    for(Asset *asset in self.availableArrayController.selectedObjects) {
        if( [self.ksp install:asset] == NO ){
            // modal alert to tell user why the uninstall failed
            NSAlert *alert = [NSAlert alertWithError:asset.error];
            [alert beginSheetModalForWindow:self.view.window
                              modalDelegate:self
                             didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:)
                                contextInfo:nil];
        }
    }
    [self refresh:YES];
}



#pragma mark -
#pragma mark Actions

- (IBAction)didPushAddButton:(NSButton *)sender
{
    
}

- (IBAction)didPushRemoveButton:(NSButton *)sender
{
    NSAlert *alert = [NSAlert alertWithMessageText:@"Delete Item"
                                     defaultButton:@"Remove"
                                   alternateButton:@"Cancel"
                                       otherButton:nil
                         informativeTextWithFormat:@"Removing this item will delete it permanently from the system. Cancel will abort."];
    
    if( self.availableArrayController.selectedObjects.count > 1 )
                      [alert setInformativeText:@"Removing these items will delete them permanently from the system. Cancel will abort."];
    
    
    [alert beginSheetModalForWindow:self.view.window
                      modalDelegate:self
                     didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:)
                        contextInfo:(__bridge void *)(sender)];
    
    
}

- (IBAction)didPushActionButton:(NSButton *)sender
{
    
}

- (IBAction)controlDidChange:(NSSegmentedControl *)sender
{
 
    NSString *contentKeypath = nil;
    NSString *sortKeypath = nil;

    switch (sender.selectedSegment) {
        case 0:
            contentKeypath = @"ksp.parts";
            sortKeypath = @"partSortDescriptors";

            break;
        case 1:
            contentKeypath = @"ksp.plugins";
            sortKeypath = @"pluginSortDescriptors";
            break;
        case 2:
            contentKeypath = @"ksp.ships";
            sortKeypath = @"shipSortDescriptors";
            break;
            
        case 3:
            contentKeypath = @"kerbalNet.remoteAssets";
            sortKeypath = @"pluginShortDescriptors";
            break;
            
        default:
            NSLog(@"%@ unanticipated control value: %ld",self,sender.selectedSegment);
            return ;
    }
    
    [sender setImage:nil forSegment:sender.selectedSegment];

    [self rebindArrayController:self.availableArrayController
                            key:kKeyContentArray
                   toNewKeypath:contentKeypath];
    
    [self rebindArrayController:self.availableArrayController
                            key:kKeySortDescriptors
                   toNewKeypath:sortKeypath];
    

    [self rebindArrayController:self.installedArrayController
                            key:kKeyContentArray
                   toNewKeypath:contentKeypath];
    
    [self rebindArrayController:self.installedArrayController
                            key:kKeySortDescriptors
                   toNewKeypath:sortKeypath];
    
    [self refresh:YES];
}

- (IBAction)installedTableViewAction:(NSTableView *)sender
{
    [self.availableTableView deselectAll:self];
    
    [self.removeButton setEnabled:NO];
    [self.actionButton setEnabled:self.installedArrayController.selectedObjects.count?YES:NO];
    
}

- (IBAction)availableTableViewAction:(NSTableView *)sender
{
    [self.installedTableView deselectAll:self];
    
    [self.removeButton setEnabled:self.availableArrayController.selectedObjects.count?YES:NO];
    [self.actionButton setEnabled:self.availableArrayController.selectedObjects.count?YES:NO];
    
}
@end
