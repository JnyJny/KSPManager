//
//  Crew.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/5/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Crew.h"

@implementation Crew

@synthesize firstName = _firstName;
@synthesize lastName = _lastName;


- (id)initWithOptions:(NSDictionary *)options
{
    if( self = [super initWithOptions:options] ) {
        [self addColumnHeader:@"Kerbalnaut" forKey:kCrewKeyName];
        [self addColumnHeader:@"Brave" forKey:kCrewKeyBrave];
        [self addColumnHeader:@"Dumb" forKey:kCrewKeyDumb];
        [self addColumnHeader:@"BadAss" forKey:kCrewKeyBadAzz];
        [self addColumnHeader:@"Flight Status" forKey:@"flightStatus"];
        [self addColumnHeader:@"ToD" forKey:kCrewKeyTimeOfDeath];
        [self addColumnHeader:@"Index" forKey:kCrewKeyIdx];
    }
    return self;
}

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Overridden Properties


- (NSString *)firstName
{
    if( _firstName == nil ){
        NSString *name = [self.contents valueForKey:kCrewKeyName];
        _firstName = [[name componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] objectAtIndex:0];
    }
    return _firstName;
}

- (NSString *)lastName
{
    if( _lastName == nil ) {
        NSString *name = [self.contents valueForKey:kCrewKeyName];
        _lastName = [[name componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] lastObject];
    }
    return _lastName;
}

- (NSString *)flightStatus
{
    NSString *v = [self valueForKey:kCrewKeyState];
    
    return [[Crew crewStatus] valueForKey:v];
}

+ (NSDictionary *)crewStatus
{
    return @{ @"0":@"Available",@"1":@"Assigned",@"2":@"Dead",@"3":@"Respawning" };
}


#pragma mark -
#pragma mark Instance Methods

#pragma mark -
#pragma mark Overridden Instance Methods

#if 0
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"CREW setValue:%@ (%@) forUndefinedKey: %@",value,[value class],key);
    [super setValue:value forUndefinedKey:key];
}


- (id)valueForUndefinedKey:(NSString *)key
{
    id val = [super valueForUndefinedKey:key];
    
    NSLog(@"CREW valueForUndefinedKey:%@ = %@ %@",key,val,[val class]);
    
    return val;
}
#endif


#pragma mark -
#pragma mark Class Methods

#pragma mark -
#pragma mark Overridden Class Methods

@end
