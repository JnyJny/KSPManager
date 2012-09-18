//
//  Space.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/17/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Space.h"

@implementation Space

@synthesize configFile = _configFile;

- (id)initWithURL:(NSURL *)baseURL
{
    if ( self = [super initWithURL:[baseURL URLByDeletingLastPathComponent]] ) {
        _configFile = baseURL;
        // parse the config file later
    }
    return self;

}

#pragma mark -
#pragma mark Overridden Properties

- (NSString *)assetTitle
{
    return self.baseURL.lastPathComponent;
}

- (NSString *)assetCategory
{
    return @"Internal Space";
}

- (BOOL)isInstalled
{
    return [self.baseURL.path rangeOfString:kKSP_SPACES].location != NSNotFound;
}

- (BOOL)isAvailable
{
    return [self.baseURL.path rangeOfString:kKSP_MODS_SPACES].location != NSNotFound;
}


#pragma mark -
#pragma mark Overridden Instance Methods

- (BOOL)moveTo:(NSURL *)destinationDirURL
{
    NSURL *targetURL = [destinationDirURL URLByAppendingPathComponent:self.baseURL.lastPathComponent];
    
    NSError *error = nil;
    
    [self.fileManager moveItemAtURL:self.baseURL
                              toURL:targetURL
                              error:&error];
    
    self.error = error;
    if( error )
        return NO;
    
    self.baseURL = targetURL;
    _configFile = [self.baseURL URLByAppendingPathComponent:self.configFile.lastPathComponent];

    return YES;
}

- (BOOL)copyTo:(NSURL *)destinationDirURL
{
    return NO;
}

- (BOOL)remove
{
    NSError *error = nil;
    
    [self.fileManager removeItemAtURL:self.baseURL error:&error];
    
    self.error = error;
    
    if( error )
        return NO;
    
    return YES;
}

- (BOOL)rename:(NSURL *)newName
{
    NSLog(@"%@ rename unimplimented",self.class);
    return NO;
}


+ (NSArray *)inventory:(NSURL *)baseURL
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    
    NSArray *spaceCfgPaths = [self assetSearch:baseURL usingBlock:^BOOL(NSString *path) {
        return [path.lastPathComponent isEqualToString:kINTERNAL_CONFG];
    }];
    
    for(NSString *path in spaceCfgPaths) {
        Space *space = [[Space alloc] initWithURL:[baseURL URLByAppendingPathComponent:path]];
        if( space )
            [results addObject:space];
    }
    
    return results;
}

@end
