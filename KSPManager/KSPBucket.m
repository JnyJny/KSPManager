//
//  SFSObject.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/26/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "KSPBucket.h"


@implementation KSPBucket

@synthesize options = _options;

- (id)init
{
    return [super init];
}

- (id)initWithOptions:(NSDictionary *)options
{
    if( self = [super init] ) {
        if( options )
            self.options = [NSMutableDictionary dictionaryWithDictionary:options];
    }
    return self;
}

- (NSMutableDictionary *)options
{
    if( _options == nil ) {
        _options = [[NSMutableDictionary alloc] init];
    }
    return _options;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    [self.options setValue:value forKey:key];
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return [self.options valueForKey:key];
}

- (void)addEntriesFromDictionary:(NSDictionary *)otherDictionary
{
    [self.options addEntriesFromDictionary:otherDictionary];
}

- (NSArray *)allKeys
{
    return [self.options allKeys];
}

- (NSArray *)allValues
{
    return [self.options allValues];
}

+ (NSString *)keyword
{
    return @"KSPBUCKET";
}

+ (BOOL)keywordMatch:(NSString *)candidate
{
    return [[self.class keyword] isEqualToString:candidate];
}

@end
