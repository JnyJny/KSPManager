//
//  KSPViewController.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/26/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "KSP.h"

@interface KSPViewController : NSViewController
@property (weak) IBOutlet NSMenu *mainMenu;

@property (weak) IBOutlet NSButton *addButton;
@property (weak) IBOutlet NSButton *removeButton;
@property (weak) IBOutlet NSButton *actionButton;

@property (strong, nonatomic) KSP *ksp;


- (IBAction)addAction:(id)sender;
- (IBAction)removeAction:(id)sender;
- (IBAction)actionAction:(id)sender;
- (IBAction)saveAction:(id)sender;

@end
