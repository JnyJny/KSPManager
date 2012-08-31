//
//  PluginViewController.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/14/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "KSPViewController.h"
#import "DropViewDelegate.h"

@class DropView;

@interface PluginViewController : KSPViewController <NSTableViewDelegate,DropViewDelegate>

@property (weak) IBOutlet NSArrayController *installedPluginController;
@property (weak) IBOutlet NSArrayController *availablePluginController;

@property (weak) IBOutlet NSTableView *installedTableView;
@property (weak) IBOutlet NSTableView *availableTableView;

@property (weak) IBOutlet DropView *installedDropView;
@property (weak) IBOutlet DropView *availableDropView;

@property (weak) IBOutlet NSButton *addButton;
@property (weak) IBOutlet NSButton *removeButton;
@property (weak) IBOutlet NSButton *actionButton;

- (IBAction)moveSelectedToAvailable:(id)sender;
- (IBAction)moveSelectedToInstalled:(id)sender;

- (IBAction)didPushAdd:(id)sender;
- (IBAction)didPushRemove:(id)sender;
- (IBAction)didPushAction:(id)sender;

@end
