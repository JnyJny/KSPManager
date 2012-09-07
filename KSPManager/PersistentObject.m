//
//  PersistentObject.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/5/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "PersistentObject.h"
#import "Line.h"

@implementation PersistentObject

@synthesize keyword = _keyword;
@synthesize contents = _content;
@synthesize lines = _lines;
@synthesize columnHeaders = _columnHeaders;
@synthesize columnOrder = _columnOrder;

#pragma mark -
#pragma mark LifeCycle


- (id)init
{
    return [self initWithOptions:nil];
}

- (id)initWithOptions:(NSDictionary *)options
{
    if( self = [super init] ) {
        [self setOptions:options];
    }
    return self;
}


#pragma mark -
#pragma mark Properties

- (NSString *)keyword
{
    return [self.class keyword];
}

- (NSMutableDictionary *)contents
{
    if( _content == nil ) {
        _content = [[NSMutableDictionary alloc] init];
    }
    return _content;
}

- (NSMutableDictionary *)columnHeaders
{
    if( _columnHeaders == nil ) {
        _columnHeaders = [[NSMutableDictionary alloc] init];
    }
    return _columnHeaders;
}

- (NSMutableDictionary *)columnOrder
{
    if( _columnOrder == nil ) {
        _columnOrder = [[NSMutableDictionary alloc] init];
    }
    return _columnOrder;
}

- (NSString *)description
{
    NSString *s = self.keyword;
    
    for(NSString *key in self.contentKeys ) {
        id val = [self valueForKey:key];
        s = [s stringByAppendingFormat:@" %@:%@",key,val];
    }
    return s;
}

#pragma mark -
#pragma mark Instance Methods

- (void)setOptions:(NSDictionary *)options
{
    if( !options )
        return ;
    
    for(NSString *key in options.allKeys) {
        id val = [self valueForKey:key];
        [self setValue:val forKey:key];
    }
}

#pragma mark -
#pragma mark Undefined Key/Value Methods


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    [self.contents setValue:value forKey:key];
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return [self.contents valueForKey:key];
}


#pragma mark -
#pragma mark Class Methods

+ (NSString *)keyword
{
    return [[self className] uppercaseString];
}

+ (BOOL)keywordMatch:(NSString *)candidate
{
    return [[self.class keyword] isEqualToString:candidate];
}

@end
