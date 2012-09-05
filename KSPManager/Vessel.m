//
//  Vessel.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/5/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Vessel.h"

@implementation Vessel

@synthesize orbit = _orbit;
@synthesize parts = _parts;

#pragma mark -
#pragma mark Properties

@synthesize pid = _pid;
@synthesize name = _name;
@synthesize sit = _sit;
@synthesize landed = _landed;
@synthesize landedAt = _landedAt;
@synthesize splashed = _splashed;
@synthesize met = _met;
@synthesize lct = _lct;
@synthesize root = _root;
@synthesize lat = _lat;
@synthesize lon = _lon;
@synthesize alt = _alt;
@synthesize hgt = _hgt;
@synthesize nrm = _nrm;
@synthesize rot = _rot;
@synthesize CoM = _CoM;
@synthesize stg = _stg;
@synthesize prst = _prst;
@synthesize eva = _eva;

- (Orbit *)orbit
{
    return _orbit;
}

- (NSMutableArray *)parts
{
    if( _parts == nil ) {
        _parts = [[NSMutableArray alloc] init];
    }
    return _parts;
}

#pragma mark -
#pragma mark Overridden Properties

#pragma mark -
#pragma mark Instance Methods

- (void)addOrbit:(NSDictionary *)orbitInfo
{
    _orbit = [[Orbit alloc] initWithOptions:orbitInfo];
}

- (void)addPart:(NSDictionary *)partInfo
{
    VesselPart *vPart = [[VesselPart alloc] initWithOptions:partInfo];
    [self.parts addObject:vPart];
}

#pragma mark -
#pragma mark Overridden Instance Methods

#pragma mark -
#pragma mark Class Methods

#pragma mark -
#pragma mark Overridden Class Methods


@end
