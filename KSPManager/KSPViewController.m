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
        NSSize sz = {12,12};
        _redBadge = [NSImage imageNamed:@"badge-red-24x24"];
        [_redBadge setSize:sz];
        
    }
    return _redBadge;
}

@end
