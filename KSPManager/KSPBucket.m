//
//  SFSObject.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/26/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "KSPBucket.h"

@interface KSPBucket () {
    NSMutableDictionary *_info;
}

@end

@implementation KSPBucket

- (id)init
{
    return [self initWithOptions:nil];
}

- (id)initWithOptions:(NSDictionary *)options
{
    self = [super init];
    if (self) {
        _info = [[NSMutableDictionary alloc] init];
        if( options )
            [self addEntriesFromDictionary:options];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    [_info setValue:value forKey:key];
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return [_info valueForKey:key];
}

- (void)addEntriesFromDictionary:(NSDictionary *)otherDictionary
{
    [_info addEntriesFromDictionary:otherDictionary];
}

- (NSArray *)allKeys
{
    return [_info allKeys];
}

+ (NSString *)keyword
{
    return [[[self className] stringByReplacingOccurrencesOfString:@"SFS" withString:@""] uppercaseString];
}

+ (BOOL)keywordMatch:(NSString *)candidate
{
    return [[self.class keyword] isEqualToString:candidate];
}

@end
