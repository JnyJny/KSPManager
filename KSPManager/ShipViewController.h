//
//  ShipViewController.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/28/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "KSPViewController.h"

@interface ShipViewController : KSPViewController
@property (strong) IBOutlet NSTableView *shipTableView;
@property (strong) IBOutlet NSTableView *partTableView;
@property (strong) IBOutlet NSArrayController *shipsArrayController;

@end
