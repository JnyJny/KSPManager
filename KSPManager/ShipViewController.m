//
//  ShipViewController.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/28/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "ShipViewController.h"

@interface ShipViewController ()

@end

@implementation ShipViewController
@synthesize shipTableView;
@synthesize partTableView;
@synthesize shipsArrayController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end
