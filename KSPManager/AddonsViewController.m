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
#import "DropView.h"

#define kKeyContentArray    @"contentArray"
#define kKeySortDescriptors @"sortDescriptors"


@implementation AddonsViewController

@synthesize installedArrayController;
@synthesize availableArrayController;
@synthesize installedDropView;
@synthesize availableDropView;
@synthesize installedTableView;
@synthesize availableTableView;
@synthesize addButton;
@synthesize removeButton;
@synthesize actionButton;
@synthesize categoryControl;

@synthesize partSortDescriptors = _partSortDescriptors;
@synthesize pluginSortDescriptors = _pluginSortDescriptors;
@synthesize shipSortDescriptors = _shipSortDescriptors;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }

    return self;
}

- (void)awakeFromNib
{

    self.installedArrayController.filterPredicate = [NSPredicate predicateWithBlock:^BOOL(Asset * evaluatedObject, NSDictionary *bindings) {
        return evaluatedObject.isInstalled;
    }];
    
    self.availableArrayController.filterPredicate = [NSPredicate predicateWithBlock:^BOOL(Asset *evaluatedObject, NSDictionary *bindings) {
        return evaluatedObject.isAvailable;
    }];
    
    [self controlDidChange:self.categoryControl];
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
    

#pragma mark -
#pragma mark Private Instance Methods

- (void)rebindArrayController:(NSArrayController *)arrayController key:(NSString *)key toNewKeypath:(NSString *)keypath
{
    [arrayController unbind:key];
    
    [arrayController bind:key
                 toObject:self
              withKeyPath:keypath
                  options:nil];
    [arrayController rearrangeObjects];
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
    
    [self.installedTableView deselectAll:self];
    [self.availableTableView deselectAll:self];
    [self.installedArrayController rearrangeObjects];
    [self.availableArrayController rearrangeObjects];
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
    
    [self.installedTableView deselectAll:self];
    [self.availableTableView deselectAll:self];
    [self.installedArrayController rearrangeObjects];
    [self.availableArrayController rearrangeObjects];
}


#pragma mark -
#pragma mark DropViewDelegate Methods

- (void)handleURL:(NSURL *)url fromDropView:(DropView *)dropView
{
    BOOL install = (dropView == self.installedDropView );

    NSArray *assets = [self.ksp createAssetsWith:url install:install];
    
    NSLog(@"assets = %@",assets);
    
    [self.installedTableView deselectAll:self];
    [self.availableTableView deselectAll:self];
    
    [self.installedArrayController rearrangeObjects];
    [self.availableArrayController rearrangeObjects];
}



#pragma mark -
#pragma mark Actions

- (IBAction)didPushAddButton:(NSButton *)sender
{
    
}

- (IBAction)didPushRemoveButton:(NSButton *)sender
{
    
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
            
        default:
            NSLog(@"%@ unanticipated control value: %ld",self,sender.selectedSegment);
            return ;
    }

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
    
}
@end
