//
//  Orbit.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/5/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Orbit.h"

@implementation Orbit


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


@end
