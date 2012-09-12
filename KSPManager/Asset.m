//
//  Asset.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/27/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Asset.h"

@implementation Asset

@synthesize global = _global;
@synthesize contexts = _contexts;
@synthesize baseURL = _baseURL;
@synthesize error = _error;



- (id)initWithURL:(NSURL *)baseURL
{
    self = [super init];
    if (self) {
        _baseURL = baseURL;
        _error = nil;
     }
    return self;
}




#pragma mark -
#pragma mark Properties

- (NSMutableDictionary *)global
{
    if( _global == nil ) {
        _global = [[NSMutableDictionary alloc] init];
    }
    return _global;
}

- (NSMutableArray *)contexts
{
    if ( _contexts == nil ) {
        _contexts = [[NSMutableArray alloc] init];
    }
    return _contexts;
}

- (BOOL)isInstalled
{
    NSLog(@"%@ isInstalled falling back to Asset implementation",self.class);
    return NO;
}

- (BOOL)isAvailable
{
    NSLog(@"%@ isAvailable falling back to Asset implementation",self.class);
    return NO;
}

- (NSString *)assetTitle
{
    NSLog(@"%@ assetTitle falling back to Asset implementation",self.class);
    return @"assetTitle";
}

- (NSString *)assetCategory
{
    NSLog(@"%@ assetCategory falling back to Asset implementation",self.class);
    return @"assetCategory";
}

#pragma mark -
#pragma mark Instance Private Methods

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    [self.global setValue:value forKey:key];
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return [self.global valueForKey:key];
}

- (void)addEntriesFromDictionary:(NSDictionary *)newEntries
{
    [self.global addEntriesFromDictionary:newEntries];
}

- (NSMutableDictionary *)contextNamed:(NSString *)name withIdentifer:(NSString *)identifier
{
    return nil;
}

#pragma mark -
#pragma mark Instance Methods

- (BOOL)moveTo:(NSURL *)destinationDirURL
{
    assert(0);
    return NO;
}

- (BOOL)copyTo:(NSURL *)destinationDirURL
{
    assert(0);
    return NO;
}

- (BOOL)remove
{
    assert(0);
    return NO;
}

- (BOOL)rename:(NSURL *)newName
{
    assert(0);
    return NO;
}




#pragma mark -
#pragma mark Class Methods

+ (NSArray *)assetSearch:(NSURL *)baseURL usingBlock:(BOOL (^)(NSString *path))pathTest
{
   return [self assetSearch:baseURL usingBlock:pathTest error:nil];
}

+ (NSArray *)assetSearch:(NSURL *)baseURL usingBlock:(BOOL (^)(NSString *path))pathTest error:(NSError **)error
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    NSArray *paths = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:baseURL.path
                                                                         error:error];
    
    if( error && (*error != nil))
        return nil;
    
    [paths enumerateObjectsUsingBlock:^(NSString *object,NSUInteger idx, BOOL *stop ){
            if( pathTest(object) == YES)
                [results addObject:object];
     }];

    return results;
}

@end
