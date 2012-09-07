//
//  Orbit.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/5/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Orbit.h"

@implementation Orbit

@synthesize pilotable;
@synthesize debris;

- (id)initWithOptions:(NSDictionary *)options
{
    if( self = [super initWithOptions:options] ) {
        // orbit doesn't have any column info yet
        // but if it did, it would go here.
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

-(void)setReferenceBodyName:(NSString *)referenceBodyName
{
    // check to see if new name is known and get value for newName
    
    // update value for key kOrbitKeyReferenceBody
}

- (NSString *)referenceBodyName
{
    NSString *val = [self valueForKey:kOrbitKeyReferenceBody];
    
    return [[Orbit referenceBodies] valueForKey:val];
}

- (BOOL)isPilotable
{
    NSString *val = [self valueForKey:kOrbitKeyObjectType];
    return val.integerValue == kOrbitObjectTypePilotable;
}

- (void)setPilotable:(BOOL)p
{
    NSString *val = [NSString stringWithFormat:@"%d",p?kOrbitObjectTypePilotable:kOrbitObjectTypeDebris];
    [self setValue:val forKey:kOrbitKeyObjectType];
}

- (BOOL)isDebris
{
    return ![self isPilotable];
}

- (void)setDebris:(BOOL)p
{
    [self setPilotable:!p];
}


+ (NSDictionary *)referenceBodies
{
    return @{ @"0":@"Kerbol", @"1":@"Kerbin", @"2":@"Mün", @"3":@"Minmus" };
}


@end
