//
//  MissionsViewController.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/14/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "MissionsViewController.h"

@interface MissionsViewController ()

@end

@implementation MissionsViewController

@synthesize vesselArrayController;
@synthesize crewArrayController;
@synthesize tableView;


- (void)awakeFromNib
{
    
    [self.ksp.persistenceFile parseLines];
}

- (IBAction)didPushAdd:(id)sender {
}

- (IBAction)didPushRemove:(id)sender {
}

- (IBAction)didPushAction:(id)sender {
}
@end
