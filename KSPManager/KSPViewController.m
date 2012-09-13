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



@synthesize ksp = _ksp;
@synthesize redBadge = _redBadge;


- (NSImage *)redBadge
{
    if( _redBadge == nil ) {
        
        _redBadge = [[NSImage alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForImageResource:@"badge-red-24x42"]];
        
    }
    return _redBadge;
}

@end
