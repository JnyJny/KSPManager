//
//  PartsViewController.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/14/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "PartsViewController.h"
#import "KSP.h"
#import "Part.h"
#import "DropView.h"

@interface PartsViewController ()

@end

@implementation PartsViewController

@synthesize installedTableView;
@synthesize availableTableView;
@synthesize installedPartsController;
@synthesize availablePartsController;
@synthesize installedTextView;
@synthesize availableTextView;
@synthesize addButton;
@synthesize removeButton;
@synthesize actionButton;
@synthesize installedDropView;
@synthesize availableDropView;





- (void)awakeFromNib
{
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:
                                        [[NSSortDescriptor alloc] initWithKey:@"category" ascending:YES],
                                [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES], nil];

    [self.installedTableView setSortDescriptors:sortDescriptors];
         
    [self.availableTableView setSortDescriptors:sortDescriptors];
    
    
    [self.installedTableView deselectAll:self];
    [self.installedTableView setTarget:self];
    [self.installedTableView setDoubleAction:@selector(moveSelectedToAvailable:)];
    [self.installedTableView setDelegate:self];
    
    
    [self.availableTableView deselectAll:self];
    [self.availableTableView setTarget:self];
    [self.availableTableView setDoubleAction:@selector(moveSelectedToInstalled:)];
    [self.availableTableView setDelegate:self];
    
    [self.installedPartsController setFilterPredicate:[NSPredicate predicateWithFormat:@"installed == YES"]];
    
    [self.availablePartsController setFilterPredicate:[NSPredicate predicateWithFormat:@"installed == NO"]];
    
    [self.addButton setToolTip:@"Add new part to available list."];
    [self.removeButton setToolTip:@"Remove part from available list (Permanent)."];
    [self.actionButton setToolTip:@"Edit part configuration."];
}

#pragma mark -
#pragma mark Properties
    


#pragma mark -
#pragma mark Instance Methods



#pragma mark -
#pragma mark NSTableViewDelegate Methods

- (void)tableViewSelectionDidChange:(NSNotification *)notification
{

    if( notification.object == self.installedTableView) {
        [self tableViewInstalledAction:notification.object];
        return;
    }
    
    if( notification.object == self.availableTableView ){
        [self tableViewAvailableAction:notification.object];
        return;
    }
}

#pragma mark -
#pragma mark DropViewDelegate optional methods



- (void)handleURL:(NSURL *)url fromDropView:(DropView *)dropView
{
    NSArray *assets;
    
    if( dropView == self.installedDropView ){
        NSLog(@"URL dropped on Installed: %@",url);
        assets = [self.ksp createAssetsWith:url install:YES];
        if( assets && assets.count )
            [self.installedPartsController rearrangeObjects];
        
    }
    
    if( dropView == self.availableDropView ){
        NSLog(@"URL dropped on Available: %@",url);
        assets = [self.ksp createAssetsWith:url install:NO];
        if( assets && assets.count )
            [self.availablePartsController rearrangeObjects];
    }
    
    
}



#pragma mark -
#pragma mark Action Methods

- (void) alertDidEnd:(NSAlert *)alert returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
    
    if( (__bridge NSButton *)contextInfo == self.removeButton){

        NSArray *selected;
    
        switch (returnCode) {
            case NSAlertDefaultReturn:
                selected = [self.availablePartsController selectedObjects];
                for(Part *part in selected) {
                    [self.ksp remove:part];
                }
                [self.availablePartsController rearrangeObjects];
                [self.availableTableView deselectAll:self];
                break;
            
            case NSAlertAlternateReturn:
            default:
                break;
        }
    }
    
    return ;
}

- (IBAction)moveSelectedToAvailable:(id)sender
{
    NSArray *selected = [self.installedPartsController selectedObjects];
    
    for(Part *part in selected) {
        if( [self.ksp uninstall:part] == NO ){
            
            if ( part.error) {
                NSAlert *alert = [NSAlert alertWithError:part.error];
                [alert beginSheetModalForWindow:self.view.window
                                  modalDelegate:self
                                 didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:)
                                    contextInfo:nil];
            }
        }
    }
    [self.installedTableView deselectAll:self];
    [self.availableTableView deselectAll:self];
    [self.installedTextView setString:@""];
    
    [self.availablePartsController rearrangeObjects];
    [self.installedPartsController rearrangeObjects];
}



- (IBAction)moveSelectedToInstalled:(id)sender
{
    NSArray *selected = [self.availablePartsController selectedObjects];
    
    for(Part *part in selected){
        [self.ksp install:part];
        
        if( part.error) {
            NSAlert *alert = [NSAlert alertWithError:part.error];
            [alert beginSheetModalForWindow:self.view.window
                              modalDelegate:self
                             didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:)
                                contextInfo:nil];
        }
    }
    [self.installedTableView deselectAll:self];
    [self.availableTableView deselectAll:self];
    [self.availableTextView setString:@""];

    [self.availablePartsController rearrangeObjects];
    [self.installedPartsController rearrangeObjects];
}


- (IBAction)didPushRemoveButton:(id)sender
{
    NSAlert *alert = [NSAlert alertWithMessageText:@"Are you sure you want to delete the selected parts?"
                                     defaultButton:@"Delete"
                                   alternateButton:@"Cancel"
                                       otherButton:nil
                         informativeTextWithFormat:@"Deleting the parts will remove them permanently."];
    
    [alert beginSheetModalForWindow:self.view.window
                      modalDelegate:self
                     didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:)
                        contextInfo:(__bridge void *)(sender)];
}



- (IBAction)tableViewInstalledAction:(NSTableView *)sender
{
    NSArray * selected = [self.installedPartsController selectedObjects];

    [self.availableTableView deselectAll:self];
    
    [self.actionButton setEnabled:selected.count==1];
    [self.removeButton setEnabled:NO];

    [self.installedTextView setString:selected.count==1?[[selected lastObject] detail]:@""];
}

- (IBAction)tableViewAvailableAction:(NSTableView *)sender
{
    NSArray *selected = [self.availablePartsController selectedObjects];
        
    [self.installedTableView deselectAll:self];
    
    [self.removeButton setEnabled:selected.count?YES:NO];
    [self.actionButton setEnabled:selected.count==1?YES:NO];
    
    [self.availableTextView setString:selected.count==1?[[selected lastObject] detail]:@""];
}

- (IBAction)didPushNewButton:(id)sender
{
    NSLog(@"didPushNewButton");
    
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    
    openPanel.canChooseDirectories = YES;
    openPanel.canChooseFiles = NO;
    openPanel.canCreateDirectories = NO;
    openPanel.canSelectHiddenExtension = NO;
    openPanel.allowsMultipleSelection = YES;
    
    [openPanel beginSheetModalForWindow:self.view.window
                      completionHandler:^(NSInteger result) {
                          if( result == NSFileHandlingPanelOKButton ) {
                              
                              for (NSURL *url in openPanel.URLs ){
                                  NSArray *assets = [self.ksp createAssetsWith:url install:NO];
                                  if( assets && assets.count )
                                      [self.availablePartsController rearrangeObjects];
                              }

                          }
                      }];
    
}

- (IBAction)didPushActionButton:(id)sender
{
    NSLog(@"didPushActionButton");
}





@end
