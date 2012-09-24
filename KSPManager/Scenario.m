//
//  Scenario.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/22/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Scenario.h"

@implementation Scenario

#pragma mark -
#pragma mark Lifecycle

- (id)initWithURL:(NSURL *)baseURL
{
    if( self = [super initWithURL:baseURL] ) {
        
        
    }
    return self;
}

#pragma mark -
#pragma mark Properties

- (BOOL)isInstalled
{
    return [self.baseURL.path rangeOfString:kKSPManagedRoot].location == NSNotFound;
}

- (BOOL)isAvailable
{
    return [self.baseURL.path rangeOfString:kKSPManagedRoot].location != NSNotFound;
}

- (NSString *)assetTitle
{
    return @"scenario";
}

- (NSString *)assetCategory
{
    return @"Scenario";
}



#pragma mark -
#pragma mark Instance Methods

- (BOOL)moveTo:(NSURL *)destinationDirURL
{
    return NO;
}

- (BOOL)copyTo:(NSURL *)destinationDirURL
{
    return NO;
}

- (BOOL)remove
{
    return NO;
}

- (BOOL)rename:(NSURL *)newName
{
    return NO;
}

#pragma mark -
#pragma mark Class Methods
+ (NSArray *)inventory:(NSURL *)baseURL
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    NSArray *sfsPaths = [self assetSearch:baseURL usingBlock:^BOOL(NSString *path) {
        return [[path pathExtension] isEqualToString:kSFS_EXT];
    }];
    
    for(NSString *sfsPath in sfsPaths) {
        Scenario *scenario = [[Scenario alloc] initWithURL:[baseURL URLByAppendingPathComponent:sfsPath]];
        if( scenario )
            [results addObject:scenario];
    }
    
    return results;
}


@end
