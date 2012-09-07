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
        
        [self addColumnHeader:@"Mission" forKey:kVesselKeyName];
        [self addColumnHeader:@"M.E.T." forKey:kVesselKeyMissionElapsedTime ];
        [self addColumnHeader:@"Situation" forKey:kVesselKeySituation ];
        [self addColumnHeader:@"Altitude (m)" forKey:kVesselKeyAltitude ];
        [self addColumnHeader:@"Body" forKey:kVesselOrbitKeyReferenceBodyName ];
        //[self addColumnHeader:@"Is Debris" forKey:kVesselOrbitKeyObjectType];
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
    kVesselKeyLCT,
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

- (BOOL)isPilotable
{
    return self.orbit.isPilotable;
}

- (BOOL)isDebris
{
    return self.orbit.isDebris;
}


#pragma mark -
#pragma mark Overridden Properties

#pragma mark -
#pragma mark Instance Methods


#pragma mark -
#pragma mark Overridden Instance Methods

#pragma mark -
#pragma mark Class Methods

#pragma mark -
#pragma mark Overridden Class Methods


@end
