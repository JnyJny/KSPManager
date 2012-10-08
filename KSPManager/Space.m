//
//  Space.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/17/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

// XXX Space & Internal need to be resolved

#import "Space.h"
#import "CFGInternal.h"

@interface Space ()
@property (strong, nonatomic) NSURL *configFile;
@property (strong, nonatomic) CFGInternal *cfgInternal;
@end

@implementation Space

@synthesize cfgInternal = _cfgInternal;
@synthesize configFile = _configFile;

- (id)initWithURL:(NSURL *)url
{
    if( self = [super initWithURL:[url URLByDeletingLastPathComponent]] ) {

    }
    return self;
}

- (CFGInternal *)cfgInternal
{
    if( _cfgInternal == nil ) {
        //_cfgInternal = [CFGInternal propForContentsOfURL:self.configFile];
    }
    return _cfgInternal;
}

- (NSURL *)configFile
{
    return [self.url URLByAppendingPathComponent:kINTERNAL_CONFG];
}

#pragma mark -
#pragma mark Overridden Properties

- (NSString *)assetTitle
{
    return self.url.lastPathComponent;
}

- (NSString *)assetCategory
{
    return @"Internal Space";
}

- (BOOL)isInstalled
{
    return [self.url.path rangeOfString:kKSP_SPACES].location != NSNotFound;
}

- (BOOL)isAvailable
{
    return [self.url.path rangeOfString:kKSPManagedSpaces].location != NSNotFound;
}


#pragma mark -
#pragma mark Overridden Instance Methods

- (BOOL)moveTo:(NSURL *)destinationDirURL
{
    NSURL *targetURL = [destinationDirURL URLByAppendingPathComponent:self.url.lastPathComponent];
    
    NSError *error = nil;
    
    [self.fileManager moveItemAtURL:self.url
                              toURL:targetURL
                              error:&error];
    
    self.error = error;
    if( error )
        return NO;
    
    self.url = targetURL;

    return YES;
}

- (BOOL)copyTo:(NSURL *)destinationDirURL
{
    return NO;
}

- (BOOL)remove
{
    NSError *error = nil;
    
    [self.fileManager removeItemAtURL:self.url error:&error];
    
    self.error = error;
    
    if( error )
        return NO;
    
    return YES;
}

+ (NSArray *)inventory:(NSURL *)url
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    NSArray *spaceCfgPaths = [self assetSearch:url usingBlock:^BOOL(NSString *path) {
        return [path.lastPathComponent isEqualToString:kINTERNAL_CONFG];
    }];
    
    for(NSString *path in spaceCfgPaths) {
        Space *space = [[Space alloc] initWithURL:[url URLByAppendingPathComponent:path]];
        if( space )
            [results addObject:space];
    }
    
    return results;
}

@end
