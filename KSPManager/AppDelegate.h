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
#import "KerbalNetViewController.h"
#import "UtilityViewController.h"
#import "KSP.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, NSTabViewDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (unsafe_unretained) IBOutlet NSTabView *tabView;
@property (unsafe_unretained) IBOutlet NSPathControl *pathControl;

@property (unsafe_unretained) IBOutlet AddonsViewController *addonsViewController;
@property (unsafe_unretained) IBOutlet MissionsViewController *missionsViewController;
@property (unsafe_unretained) IBOutlet CrewViewController *crewViewController;
@property (unsafe_unretained) IBOutlet ShipViewController *shipViewController;
@property (unsafe_unretained) IBOutlet InventoryViewController *inventoryViewController;
@property (unsafe_unretained) IBOutlet SavesViewController *savesViewController;
@property (unsafe_unretained) IBOutlet KerbalNetViewController *kerbalNetViewController;
@property (unsafe_unretained) IBOutlet UtilityViewController *utilityViewController;

@property (unsafe_unretained) IBOutlet NSButton *terminateKSPButton;
@property (unsafe_unretained) IBOutlet NSButton *launchKSPButton;


@property (strong, nonatomic) KSP *ksp;


- (IBAction)chooseInstallationDirectory:(id)sender;

- (IBAction)didPushLaunchButton:(id)sender;
- (IBAction)didPushTerminateButton:(id)sender;
- (IBAction)didChooseOpen:(id)sender;

@end
