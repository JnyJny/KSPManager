//
//  Asset.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/27/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Asset.h"

@implementation Asset

@synthesize baseURL = _baseURL;
@synthesize error = _error;


- (id)initWithURL:(NSURL *)baseURL
{
    self = [super init];
    if (self) {
        _baseURL = baseURL;
    }
    return self;
}


- (BOOL)isInstalled
{
    return NO;
}


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
