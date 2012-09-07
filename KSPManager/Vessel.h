//
//  Vessel.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/5/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "PersistentObject.h"
#import "Orbit.h"
#import "VesselPart.h"


#define kVesselKeyPid                @"pid"
#define kVesselKeyName               @"name"
#define kVesselKeySituation          @"sit"
#define kVesselKeyLanded             @"landed"
#define kVesselKeyLandedAt           @"landedAt"
#define kVesselKeySplashed           @"splashed"
#define kVesselKeyMissionElapsedTime @"met"
#define kVesselKeyLCT                @"lct"
#define kVesselKeyRoot               @"root"
#define kVesselKeyLatitude           @"lat"
#define kVesselKeyLongitude          @"lon"
#define kVesselKeyAltitude           @"alt"
#define kVesselKeyHGT                @"hgt"   // hgt may be height AGL versus altitude (ASL)
#define kVesselKeyNRM                @"nrm"
#define kVesselKeyROT                @"rot"
#define kVesselKeyCenterOfMass       @"CoM"
#define kVesselKeyStage              @"stg"
#define kVesselKeyPRST               @"prst"
#define kVesselKeyEVA                @"eva"

#define kVesselOrbitKeySemiMajorAxis            @"orbit." kOrbitKeySemiMajorAxis
#define kVesselOrbitKeyEccentricity             @"orbit." kOrbitKeyEccentricity
#define kVesselOrbitKeyInclination              @"orbit." kOrbitKeyInclination
#define kVesselOrbitKeyLongitudeOfPeriapsis     @"orbit." kOrbitKeyLongitudeOfPeriapsis
#define kVesselOrbitKeyLongitudeOfAscendingNode @"orbit." kOrbitKeyLongitudeOfAscendingNode
#define kVesselOrbitKeyMeanAnomalyAtEpoch       @"orbit." kOrbitKeyMeanAnomalyAtEpoch
#define kVesselOrbitKeyReferenceBody            @"orbit." kOrbitKeyReferenceBody
#define kVesselOrbitKeyObjectType               @"orbit." kOrbitKeyObjectType



@interface Vessel : PersistentObject

@property (strong, nonatomic) Orbit *orbit;
@property (strong, nonatomic) NSMutableArray *parts;

- (void)addOrbit:(NSDictionary *)orbitInfo;
- (void)addPart:(NSDictionary *)partInfo;
@end
