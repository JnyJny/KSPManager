//
//  AppDelegate.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/14/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "AppDelegate.h"
#import "KSP_Constants.h"

@implementation AppDelegate
@synthesize tabView;
@synthesize partsViewController;
@synthesize missionsViewController;
@synthesize pluginViewController;
@synthesize inventoryViewController;
@synthesize shipViewController;
@synthesize terminateKSPButton;
@synthesize launchKSPButton;

@synthesize pathControl;


@synthesize ksp = _ksp;
@synthesize viewControllers = _viewControllers;


#pragma mark -
#pragma mark NSApplicationDelegate Methods

- (void)setupToolTips
{
 
    [self.launchKSPButton setToolTip:@"Start this installation of KSP."];
    [self.terminateKSPButton setToolTip:@"Terminate ALL running instances of KSP."];
    [self.pathControl setToolTip:@"Path for current KSP, double click to select another installation directory."];
    
}

- (void)setupTabControllers
{
    
    [self.tabView.tabViewItems enumerateObjectsUsingBlock:^(NSTabViewItem *item,NSUInteger idx,BOOL *stop ){
        if( idx > self.viewControllers.count ) {
            *stop = YES;
            NSLog(@"setupTabControllers: more tabViewItems than viewControllers.");
            return;
        }
        
        item.view = [[self.viewControllers objectAtIndex:idx] view];
     }];
    
    [self.tabView selectFirstTabViewItem:nil];
    
}

- (void)chooseAnInstallation
{
    // user defaults check here

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *defaultKspPath = [userDefaults valueForKey:kKSP_DEFAULT_INSTALLATION_KEY];
    if( defaultKspPath ) {
        NSURL *defaultURL = [NSURL fileURLWithPath:defaultKspPath];
        KSP *tmp = [[KSP alloc] initWithURL:defaultURL];
        if( tmp.isValidInstallation ) {
            self.ksp = tmp;
            return ;
        }
        // if the save user default path is bogus, remove it from userDefaults
        
        [userDefaults removeObjectForKey:kKSP_DEFAULT_INSTALLATION_KEY];
    }

    // if no user default value found, search in the ususal places

    NSArray *ksps = [KSP locateInstallationDirectories];
    
    if( ksps && ksps.count ) {
        // XXX should probably let the user pick if there are multiple
        self.ksp = [ksps objectAtIndex:0];
        return;
    }
    
    // otherwise ask the user to locate it for us, will terminiate if the user fails to pick a valid installation

    [self chooseInstallationDirectory:self];
}

- (void)setupPathControl
{
    [self.pathControl setTarget:self];
    [self.pathControl setDoubleAction:@selector(chooseInstallationDirectory:)];
}



- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    [self chooseAnInstallation];
    
    [self setupPathControl];
    
    [self setupTabControllers];
    
    [self setupToolTips];

}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

#pragma mark -
#pragma mark Properties

- (void)setKsp:(KSP *)ksp
{
    if( _ksp == ksp )
        return;
        
    _ksp = ksp;
    
    // the following walks the list of known viewControllers and uses Key/Value to set their ksp property
    
    [self.viewControllers enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop ){
            [object setValue:_ksp forKey:@"ksp"];
        }];

    
    // next, if _ksp is not nil, save it's baseURL.path to the persistent user defaults key store.
    // on next start, this ksp installation will be chosen first if it exists. 
    
    if( _ksp ) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setValue:_ksp.baseURL.path forKey:kKSP_DEFAULT_INSTALLATION_KEY];
    }
    [self.pathControl setURL:_ksp.baseURL];
}

- (NSArray *)viewControllers
{
    
    // When adding view controllers for the TabController, add them to this list
    
    if( _viewControllers == nil ) {
        _viewControllers = [NSArray arrayWithObjects:
                            self.partsViewController,
                            self.pluginViewController,
                            self.missionsViewController,
                            self.shipViewController,
                            self.inventoryViewController,
                            nil];
    }
    return _viewControllers;
}


#pragma mark -
#pragma mark Instance Methods

- (IBAction)chooseInstallationDirectory:(id)sender
{
 
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    
    openPanel.canChooseDirectories = YES;
    openPanel.canChooseFiles = NO;
    openPanel.canCreateDirectories = NO;
    openPanel.canSelectHiddenExtension = NO;
    openPanel.allowsMultipleSelection = NO;
    
    [openPanel beginSheetModalForWindow:self.window
                      completionHandler:^(NSInteger result) {
                          if( result == NSFileHandlingPanelOKButton ) {
                              KSP *tmp = [[KSP alloc] initWithURL:[openPanel.URL URLByStandardizingPath]];
                              if( tmp.isValidInstallation ) {
                                  self.ksp = tmp;
                                  return;
                              }
                              [[NSApplication sharedApplication] terminate:self];
                          }

                          if( result == NSFileHandlingPanelCancelButton ) {
                              
                              [[NSApplication sharedApplication] terminate:self];
                          } 
                      }];
    
}


- (IBAction)didPushLaunchButton:(id)sender
{
    [self.ksp launchKSP];
}

- (IBAction)didPushTerminateButton:(id)sender
{
    [KSP terminateRunningKSP];
}




@end
