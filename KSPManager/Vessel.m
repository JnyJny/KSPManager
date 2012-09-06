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


- (id)initWithOptions:(NSDictionary *)options
{
    
    if ( self = [super initWithOptions:options] ) {
        [self.columnHeaders addEntriesFromDictionary:@{ kVesselKeyName : @"Name"}];
    }
    return self;
}

#pragma mark -
#pragma mark Properties

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

- (NSArray *)contentKeys
{
 return @[
    kVesselKeyPid,
    kVesselKeyName,
    kVesselKeySituation,
    kVesselKeyLanded,
    kVesselKeyLandedAt,
    kVesselKeySplashed,
    kVesselKeyMissionElapsedTime,
    kVesselKeyLocation,
    kVesselKeyRoot,
    kVesselKeyLatitude,
    kVesselKeyLongitude,
    kVesselKeyAltitude,
    kVesselKeyHGT,
    kVesselKeyNRM,
    kVesselKeyROT,
    kVesselKeyCenterOfMass,
    kVesselKeyStage,
    kVesselKeyPRST,
    kVesselKeyEVA,
    ];
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
