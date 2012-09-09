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
        [self addColumnHeader:@"M.E.T." forKey:@"missionElapsedTime" ];
        [self addColumnHeader:@"Situation" forKey:kVesselKeySituation ];
        [self addColumnHeader:@"Altitude" forKey:@"altitude" ];
        [self addColumnHeader:@"Sphere Of Influence" forKey:kVesselOrbitKeyReferenceBodyName ];

        
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

- (BOOL)isPilotable
{
    return self.orbit.isPilotable;
}

- (BOOL)isDebris
{
    return self.orbit.isDebris;
}

#define kSecPerMinute 60
#define kSecPerHour   3600
#define kSecPerDay    86400
#define kSecPerYear   31536000

- (NSString *)missionElapsedTime
{

    NSString *metStr = [self valueForKey:kVesselKeyMissionElapsedTime];
    
    NSInteger t,years,days,hours,minutes,seconds;
    
    t = metStr.integerValue;
    
    ldiv_t result;
    
    result = ldiv(t, kSecPerYear);
    
    years = result.quot;
    
    result = ldiv(result.rem, kSecPerDay);
    
    days = result.quot;
    
    result = ldiv(result.rem, kSecPerHour);
    
    hours = result.quot;
    
    result = ldiv(result.rem, kSecPerMinute);
    
    minutes = result.quot;
    seconds = result.rem;
    

    return [NSString  stringWithFormat:@"%03ld:%03ld %02ld:%02ld:%02ld",years,days,hours,minutes,seconds];
}

- (NSString *)altitude
{
    NSString *altStr = [self valueForKey:kVesselKeyAltitude];

    
    if( altStr.doubleValue > 1000.0)
        return [NSString stringWithFormat:@"%.2f km",altStr.doubleValue / 1000.0];
    
    return [NSString stringWithFormat:@"%.2f m",altStr.doubleValue];
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
