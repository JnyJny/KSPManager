//
//  AddonsViewController.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/11/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "KSPViewController.h"

@interface AddonsViewController : KSPViewController <NSTableViewDataSource>

@property (strong) IBOutlet NSArrayController *installedArrayController;
@property (strong) IBOutlet NSArrayController *availableArrayController;
@property (strong) IBOutlet NSTableView *installedTableView;
@property (strong) IBOutlet NSTableView *availableTableView;
@property (strong) IBOutlet NSButton *addButton;
@property (strong) IBOutlet NSButton *removeButton;
@property (strong) IBOutlet NSButton *actionButton;
@property (strong) IBOutlet NSSegmentedControl *categoryControl;

@property (strong, nonatomic) NSArray *partSortDescriptors;
@property (strong, nonatomic) NSArray *pluginSortDescriptors;
@property (strong, nonatomic) NSArray *shipSortDescriptors;

- (IBAction)didPushAddButton:(NSButton *)sender;
- (IBAction)didPushRemoveButton:(NSButton *)sender;
- (IBAction)didPushActionButton:(NSButton *)sender;
- (IBAction)controlDidChange:(NSSegmentedControl *)sender;

@end
