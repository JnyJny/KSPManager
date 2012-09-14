//
//  AppDelegate.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/14/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "AddonsViewController.h"
#import "MissionsViewController.h"
#import "CrewViewController.h"
#import "ShipViewController.h"
#import "InventoryViewController.h"
#import "SavesViewController.h"
#import "KSP.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (strong) IBOutlet NSTabView *tabView;
@property (strong) IBOutlet NSPathControl *pathControl;

@property (strong) IBOutlet AddonsViewController *addonsViewController;
@property (strong) IBOutlet MissionsViewController *missionsViewController;
@property (strong) IBOutlet CrewViewController *crewViewController;
@property (strong) IBOutlet ShipViewController *shipViewController;
@property (strong) IBOutlet InventoryViewController *inventoryViewController;
@property (strong) IBOutlet SavesViewController *savesViewController;

@property (strong) IBOutlet NSButton *terminateKSPButton;
@property (strong) IBOutlet NSButton *launchKSPButton;


@property (strong, nonatomic) KSP *ksp;


- (IBAction)chooseInstallationDirectory:(id)sender;

- (IBAction)didPushLaunchButton:(id)sender;
- (IBAction)didPushTerminateButton:(id)sender;
- (IBAction)didChooseOpen:(id)sender;

@end
