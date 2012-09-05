//
//  Crew.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/5/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Crew.h"

@implementation Crew


@synthesize name = _name;
@synthesize brave = _brave;
@synthesize dumb = _dumb;
@synthesize badS = _badS;
@synthesize ToD = _ToD;
@synthesize idx = _idx;

- (id)initWithOptions:(NSDictionary *)options
{
    if( self = [super init] ) {
        if( options ) {
            for(NSString *key in options.allKeys){
                id val = [options valueForKey:key];
                [self setValue:val forKey:key];
            }
        }
    }
    return self;
}

#pragma mark -
#pragma mark Properties

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
