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
        
        [self.columnHeaders addEntriesFromDictionary:
                                     @{ kCrewKeyName:@"Kerbalnaut",
                                       kCrewKeyBrave:@"Brave",
                                        kCrewKeyDumb:@"Dumb",
                                      kCrewKeyBadAzz:@"BadAzz",
                                       kCrewKeyState:@"Flight Status",
                                 kCrewKeyTimeOfDeath:@"ToD",
                                         kCrewKeyIdx:@"Index" }];
        
        [self.columnOrder addEntriesFromDictionary:@{@"0":kCrewKeyName,
                                                     @"1":kCrewKeyBrave,
                                                     @"2":kCrewKeyDumb,
                                                     @"3":kCrewKeyBadAzz,
                                                     @"4":kCrewKeyState,
                                                     @"5":kCrewKeyTimeOfDeath,
                                                     @"6":kCrewKeyIdx}];
        

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

- (NSArray *)contentKeys
{
    return @[ kCrewKeyName,
              kCrewKeyBrave,
              kCrewKeyDumb,
              kCrewKeyBadAzz,
              kCrewKeyState,
              kCrewKeyTimeOfDeath,
              kCrewKeyIdx];
}




#pragma mark -
#pragma mark Instance Methods

#pragma mark -
#pragma mark Overridden Instance Methods

#pragma mark -
#pragma mark Class Methods

#pragma mark -
#pragma mark Overridden Class Methods

@end
