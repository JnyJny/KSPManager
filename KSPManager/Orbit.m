//
//  Orbit.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/5/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Orbit.h"

@implementation Orbit


- (id)initWithOptions:(NSDictionary *)options
{
    if( self = [super initWithOptions:options] ) {
        
    }
    return self;
}

- (NSArray *)contentKeys
{
 return @[
    kOrbitKeySemiMajorAxis,
    kOrbitKeyEccentricity,
    kOrbitKeyInclination,
    kOrbitKeyLongitudeOfPeriapsis,
    kOrbitKeyLongitudeOfAscendingNode,
    kOrbitKeyMeanAnomalyAtEpoch,
    kOrbitKeyEpoch,
    kOrbitKeyReferenceBody,
    kOrbitKeyObjectType
    ];
}

+ (NSArray *)referenceBodies
{
    return @[ @"Kerbol", @"Kerbin", @"Mün", @"Minmus" ];
}


@end
