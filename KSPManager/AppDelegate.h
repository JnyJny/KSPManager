//
//  AppDelegate.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/14/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "BadgeTabView.h"
#import "AddonsViewController.h"
#import "MissionsViewController.h"
#import "CrewViewController.h"
#import "ShipViewController.h"
#import "InventoryViewController.h"
#import "SavesViewController.h"
#import "KSP.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (weak) IBOutlet BadgeTabView *tabView;
@property (weak) IBOutlet NSPathControl *pathControl;

@property (weak) IBOutlet AddonsViewController *addonsViewController;
@property (weak) IBOutlet MissionsViewController *missionsViewController;
@property (weak) IBOutlet CrewViewController *crewViewController;
@property (weak) IBOutlet ShipViewController *shipViewController;
@property (weak) IBOutlet InventoryViewController *inventoryViewController;
@property (weak) IBOutlet SavesViewController *savesViewController;

@property (weak) IBOutlet NSButton *terminateKSPButton;
@property (weak) IBOutlet NSButton *launchKSPButton;


@property (strong, nonatomic) KSP *ksp;


- (IBAction)chooseInstallationDirectory:(id)sender;

- (IBAction)didPushLaunchButton:(id)sender;
- (IBAction)didPushTerminateButton:(id)sender;
- (IBAction)didChooseOpen:(id)sender;

@end
