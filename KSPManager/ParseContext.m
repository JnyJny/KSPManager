//
//  ParseContext.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/10/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "ParseContext.h"

@implementation ParseContext

@synthesize name = _name;

- (id)initWithName:(NSString *)name
{
    if( self = [super init] ) {
     
        self.name = name;
    }
    return self;
}

@end
