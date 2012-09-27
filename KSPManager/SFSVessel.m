//
//  SFSVessel.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/26/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "SFSVessel.h"

@interface SFSVessel ()

@property (strong, nonatomic, readwrite) SFSOrbit *orbit;
@property (strong, nonatomic, readwrite) NSMutableArray *parts;

@end

@implementation SFSVessel

@synthesize orbit = _orbit;
@synthesize parts = _parts;

#pragma mark -
#pragma mark Properties

- (NSMutableArray *)parts
{
    if( _parts == nil ) {
        _parts = [[NSMutableArray alloc] init];
    }
    return _parts;
}

#pragma mark -
#pragma mark Instance Methods

- (void)addOrbitWithOptions:(NSDictionary *)options
{
    self.orbit = [[SFSOrbit alloc] initWithOptions:options];
}

- (void)addPartWithOptions:(NSDictionary *)options
{
    [self.parts addObject:[[SFSPart alloc] initWithOptions:options]];
}

- (void)addPart:(SFSPart *)part
{
    [self.parts addObject:part];
}

@end
