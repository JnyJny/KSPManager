//
//  CRAFTVessel.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/26/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "CRAFTVessel.h"

@interface CRAFTVessel ()
@property (strong, nonatomic, readwrite) NSMutableArray *parts;
@end

@implementation CRAFTVessel
@synthesize parts = _parts;


- (NSMutableArray *)parts
{
    if( _parts == nil ) {
        _parts = [[NSMutableArray alloc] init];
    }
    return _parts;
}


- (void)addPartWithOptions:(NSDictionary *)options
{
    CRAFTPart *part = [[CRAFTPart alloc] initWithOptions:options];
    [self addPart:part];
}

- (void)addPart:(id)part
{
    [self.parts addObject:part];
}

@end
