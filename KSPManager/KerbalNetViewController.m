//
//  KerbalNetViewController.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/14/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "KerbalNetViewController.h"
#import "KerbalNet.h"
#import "KSP_Constants.h"
#import "Remote.h"


@interface KerbalNetViewController ()

@end

@implementation KerbalNetViewController
@synthesize tableView;
@synthesize kerbalNetArrayController;
@synthesize progressIndicator;
@synthesize overwriteCheckBox;
@synthesize installCheckBox;

@synthesize kerbalNet = _kerbalNet;

- (void)awakeFromNib
{
    self.kerbalNet.delegate = self;
    
    [self.addButton setToolTip:@"Download & Add Selections to the Available List"];
    [self.removeButton setToolTip:@"This Button Does Nothing"];
    [self.actionButton setToolTip:@"Refresh list of addons available from Kerbal.Net"];
    
    [self.kerbalNetArrayController setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:kKerbalNetKeyModName ascending:YES]]];
}

#pragma mark -
#pragma mark Properties

- (KerbalNet *)kerbalNet
{
    if( _kerbalNet == nil ) {
     
        _kerbalNet = [[KerbalNet alloc] initWithApplicationID:kKSPManagerApplicationID
                                          andApplicationToken:kKSPManagerApplicationToken];
        
    }
    return _kerbalNet;
}

- (IBAction)installCheckBoxDidChange:(NSButton *)sender
{
    
}

- (IBAction)overwriteCheckBoxDidChange:(NSButton *)sender
{
    
}

#pragma mark -
#pragma mark KerbalNetDelegate Methods



- (void)willBeginRefresh
{
    [self.progressIndicator startAnimation:self];
}

- (void)didEndRefresh
{
    [self.progressIndicator stopAnimation:self];
    [self.kerbalNetArrayController rearrangeObjects];
    [self.actionButton setEnabled:YES];
}

- (void)willBeginNetworkOperationForRemoteAsset:(Remote *)remote
{
    [self.progressIndicator startAnimation:self];
    
}

- (void)didFinishNetworkOperationForRemoteAsset:(Remote *)remote
{
    [self.progressIndicator stopAnimation:self];
    
    if( remote.error == nil ) {
        [self.ksp createAssetsWith:remote.localURL install:NO];
        [self.kerbalNetArrayController rearrangeObjects];
    }
}


#pragma mark -
#pragma mark Private Instance Methods

#pragma mark -
#pragma mark Instance Methods

- (void)refresh
{
    if( [self.kerbalNetArrayController.arrangedObjects count] == 0 ) {
        [self actionAction:self];
    }
    
}

- (IBAction)actionAction:(id)sender
{
    [self.actionButton setEnabled:NO];
    [self.kerbalNet.remoteAssets removeAllObjects];
    [self.kerbalNetArrayController rearrangeObjects];
    [self.kerbalNet refresh];
}

- (IBAction)addAction:(id)sender
{
    for( Remote *remote in self.kerbalNetArrayController.selectedObjects ) {
        
        NSURL *localURL = [self.ksp downloadCacheURLforPath:remote.url.lastPathComponent];

        [self.kerbalNet downloadRemoteAsset:remote toDestination:localURL];
            

    }
}


@end
