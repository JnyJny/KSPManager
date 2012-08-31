//
//  InventoryViewController.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/26/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "KSPViewController.h"



@interface InventoryViewController : KSPViewController

@property (strong) IBOutlet NSArrayController *partsArrayController;
@property (strong) IBOutlet NSTableView *tableView;


@end
