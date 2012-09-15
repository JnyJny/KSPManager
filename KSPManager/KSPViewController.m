//
//  KSPViewController.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/26/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "KSPViewController.h"
#import "KSP.h"

@interface KSPViewController ()

@end

@implementation KSPViewController

@synthesize mainMenu = _mainMenu;
@synthesize ksp = _ksp;


- (void)refresh
{
    NSLog(@"%@ refresh",[self class]);
}

- (IBAction)addAction:(id)sender
{
    NSLog(@"%@ addAction:%@",[self class], [sender class]);
}

- (IBAction)removeAction:(id)sender
{
    NSLog(@"%@ removeAction:%@",[self class], [sender class]);
}

- (IBAction)actionAction:(id)sender
{
    NSLog(@"%@ actionAction:%@",[self class], [sender class]);
}

- (IBAction)saveAction:(id)sender
{
    NSLog(@"%@ saveAction:%@",[self class], [sender class]);
}

@end
