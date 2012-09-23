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
        [self addColumnHeader:@"Eccentricity" forKey:kOrbitKeyEccentricity];
        [self addColumnHeader:@"Epoch" forKey:kOrbitKeyEpoch ];
        [self addColumnHeader:@"Inclination" forKey:kOrbitKeyInclination ];
        [self addColumnHeader:@"Longitude Of Ascending Node" forKey:kOrbitKeyLongitudeOfAscendingNode ];
        [self addColumnHeader:@"Longitude of Periapsis" forKey:kOrbitKeyLongitudeOfPeriapsis];
        [self addColumnHeader:@"Mean Anomaly At Epoch" forKey:kOrbitKeyMeanAnomalyAtEpoch ];
        [self addColumnHeader:@"Object Type" forKey:kOrbitKeyObjectType];
        [self addColumnHeader:@"Reference Body" forKey:kOrbitKeyReferenceBody];
    }
    return self;
}

#pragma mark -
#pragma mark Properties

-(void)setReferenceBodyName:(NSString *)referenceBodyName
{
    // check to see if new name is known and get value for newName
    
    // update value for key kOrbitKeyReferenceBody
}

- (NSString *)referenceBodyName
{
    NSString *val = [self valueForKey:kOrbitKeyReferenceBody];
    
    if( (val.integerValue > [Orbit referenceBodies].count ) ||
       (val.integerValue < 0) )
        return [@"Unknown Body:" stringByAppendingString:val];
    
    return [[Orbit referenceBodies] objectAtIndex:val.integerValue];
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


+ (NSArray *)referenceBodies
{
    return @[ @"Kerbol",@"Kerbin",@"Mün",@"Minmus", @"Moho", @"Eve", @"Duna", @"Ike", @"Jool", @"Laythe",@"Vall",@"Bop", @"Tylo", @"Gilly" ];

}


@end
