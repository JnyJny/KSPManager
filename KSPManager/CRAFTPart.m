//
//  CRAFTPart.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/26/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "CRAFTPart.h"
#import "Part.h"

@interface CRAFTPart ()

@property (strong, nonatomic, readwrite) CRAFTModule *module;

@end



@implementation CRAFTPart

@synthesize definition = _definition;
@synthesize name = _name;
@synthesize pid = _pid;



#define kCRAFTKeyPart @"part"

- (NSString *)name
{
    if( _name == nil ) {
        NSArray *results = [[self valueForKey:kCRAFTKeyPart] componentsSeparatedByString:@"_"];
        _name = [results objectAtIndex:0];
        _pid = [[results lastObject] integerValue];
    }
    return _name;
}

- (NSInteger)pid
{
    if( _pid < 0 ) {
        NSArray *results = [[self valueForKey:kCRAFTKeyPart]  componentsSeparatedByString:@"_"];
        _name = [results objectAtIndex:0];
        _pid = [[results lastObject] integerValue];

    }
    return _pid;
}

- (void)addModuleWithOptions:(NSDictionary *)options
{
    self.module = [[CRAFTModule alloc] initWithOptions:options];
}

@end
