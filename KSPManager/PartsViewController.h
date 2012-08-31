//
//  PartsViewController.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/14/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "KSPViewController.h"
#import "DropViewDelegate.h"


@interface PartsViewController : KSPViewController <NSTableViewDelegate,DropViewDelegate>


@property (strong) IBOutlet NSArrayController *installedPartsController;
@property (strong) IBOutlet NSArrayController *availablePartsController;

@property (strong) IBOutlet NSTableView *installedTableView;
@property (strong) IBOutlet NSTableView *availableTableView;

@property (unsafe_unretained) IBOutlet NSTextView *installedTextView;
@property (unsafe_unretained) IBOutlet NSTextView *availableTextView;

@property (weak) IBOutlet NSButton *addButton;
@property (weak) IBOutlet NSButton *removeButton;
@property (weak) IBOutlet NSButton *actionButton;

@property (weak) IBOutlet DropView *installedDropView;
@property (weak) IBOutlet DropView *availableDropView;

- (IBAction)moveSelectedToAvailable:(id)sender;
- (IBAction)moveSelectedToInstalled:(id)sender;

- (IBAction)didPushRemoveButton:(id)sender;
- (IBAction)didPushNewButton:(id)sender;
- (IBAction)didPushActionButton:(id)sender;

@end
