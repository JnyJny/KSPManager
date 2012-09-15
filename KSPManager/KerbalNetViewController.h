//
//  KerbalNetViewController.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/14/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "KSPViewController.h"
#import "KerbalNet.h"


@interface KerbalNetViewController : KSPViewController <KerbalNetDelegate>

@property (strong) IBOutlet NSTableView *tableView;
@property (strong) IBOutlet NSArrayController *kerbalNetArrayController;
@property (strong) IBOutlet NSProgressIndicator *progressIndicator;

@property (strong, nonatomic) KerbalNet *kerbalNet;


@end
