//
//  AppDelegate.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/14/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PartsViewController.h"
#import "MissionsViewController.h"
#import "PluginViewController.h"
#import "InventoryViewController.h"
#import "ShipViewController.h"
#import "KSP.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTabView *tabView;
@property (weak) IBOutlet NSPathControl *pathControl;

@property (weak) IBOutlet PartsViewController *partsViewController;
@property (weak) IBOutlet MissionsViewController *missionsViewController;
@property (weak) IBOutlet PluginViewController *pluginViewController;
@property (weak) IBOutlet InventoryViewController *inventoryViewController;
@property (weak) IBOutlet ShipViewController *shipViewController;
@property (weak) IBOutlet NSButton *terminateKSPButton;
@property (weak) IBOutlet NSButton *launchKSPButton;


@property (strong, nonatomic) KSP *ksp;
@property (strong, nonatomic) NSArray *viewControllers;

- (IBAction)chooseInstallationDirectory:(id)sender;

- (IBAction)didPushLaunchButton:(id)sender;
- (IBAction)didPushTerminateButton:(id)sender;

@end
