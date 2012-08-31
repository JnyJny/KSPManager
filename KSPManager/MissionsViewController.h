//
//  MissionsViewController.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/14/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "KSPViewController.h"


@interface MissionsViewController : KSPViewController

@property (weak) IBOutlet NSTableView *tableView;

- (IBAction)didPushAdd:(id)sender;
- (IBAction)didPushRemove:(id)sender;
- (IBAction)didPushAction:(id)sender;



@end
