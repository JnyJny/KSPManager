//
//  PluginViewController.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/14/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "PluginViewController.h"
#import "Plugin.h"
#import "DropView.h"

@interface PluginViewController ()

@end

@implementation PluginViewController

@synthesize installedPluginController;
@synthesize availablePluginController;
@synthesize installedTableView;
@synthesize availableTableView;
@synthesize installedDropView;
@synthesize availableDropView;


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
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:
                                [[NSSortDescriptor alloc] initWithKey:@"version" ascending:YES],
                                [[NSSortDescriptor alloc] initWithKey:@"fileName" ascending:YES],
                                nil];
 
    [self.installedTableView deselectAll:self];
    [self.installedTableView setSortDescriptors:sortDescriptors];
    [self.installedTableView setDoubleAction:@selector(moveSelectedToAvailable:)];
    [self.installedTableView setTarget:self];
    [self.installedTableView setDelegate:self];
    

    [self.availableTableView deselectAll:self];
    [self.availableTableView setSortDescriptors:sortDescriptors];
    [self.availableTableView setDoubleAction:@selector(moveSelectedToInstalled:)];
    [self.availableTableView setTarget:self];
    [self.availableTableView setDelegate:self];
    
    self.availableDropView.delegate = self;
    self.installedDropView.delegate = self;
    
    [self.addButton setToolTip:@"Add new plugin to available list."];
    [self.removeButton setToolTip:@"Remove plugin from available list (Permanent)."];
    [self.actionButton setToolTip:@"Action button, it's action-y!"];
    
    [self.installedPluginController setFilterPredicate:[NSPredicate predicateWithFormat:@"installed == YES"]];
    [self.availablePluginController setFilterPredicate:[NSPredicate predicateWithFormat:@"installed == NO"]];
    
}

#pragma mark -
#pragma mark Properties


#pragma mark -
#pragma mark NSTableViewDelegateMethods

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
#pragma mark DropViewDelegate optional method

- (void)handleURL:(NSURL *)url fromDropView:(DropView *)dropView
{
    NSArray *assets;
    
    if( dropView == self.installedDropView ){
        NSLog(@"URL dropped on Installed: %@",url);
        assets = [self.ksp createAssetsWith:url install:YES];
        if( assets && assets.count )
            [self.installedPluginController rearrangeObjects];
        
    }
    
    if( dropView == self.availableDropView ){
        NSLog(@"URL dropped on Available: %@",url);
        assets = [self.ksp createAssetsWith:url install:NO];
        if( assets && assets.count )
            [self.availablePluginController rearrangeObjects];
    }
}

#pragma mark -
#pragma mark Action Methods


- (IBAction)moveSelectedToAvailable:(id)sender
{
    NSLog(@"moveSelectedToAvailable:");
}

- (IBAction)moveSelectedToInstalled:(id)sender
{
    NSLog(@"moveSelectedToInstalled:");
}

- (IBAction)tableViewInstalledAction:(NSTableView *)sender
{
    NSArray * selected = [self.installedPluginController selectedObjects];
    
    [self.availableTableView deselectAll:self];
    
    [self.actionButton setEnabled:selected.count==1];
    [self.removeButton setEnabled:NO];
    

}

- (IBAction)tableViewAvailableAction:(NSTableView *)sender
{
    NSArray *selected = [self.availablePluginController selectedObjects];
    
    [self.installedTableView deselectAll:self];
    
    [self.removeButton setEnabled:selected.count?YES:NO];
    [self.actionButton setEnabled:selected.count==1?YES:NO];

}


- (IBAction)didPushAdd:(id)sender
{
    
}

- (IBAction)didPushRemove:(id)sender
{
    
}

- (IBAction)didPushAction:(id)sender
{
    
}
@end
