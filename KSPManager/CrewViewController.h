//
//  CrewViewController.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/7/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "KSPViewController.h"

@interface CrewViewController : KSPViewController

@property (strong) IBOutlet NSTableView *tableView;
@property (strong) IBOutlet NSArrayController *crewArrayController;

@end
