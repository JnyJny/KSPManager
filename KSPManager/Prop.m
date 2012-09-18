//
//  Prop.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/17/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Prop.h"

@implementation Prop

@synthesize configURL = _configURL;

- (id)initWithURL:(NSURL *)baseURL
{
    if( self = [super initWithURL:[baseURL URLByDeletingLastPathComponent]] ) {

        _configURL = baseURL;
        
        // XXX parse it when the file parser is really done
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
    return @"Prop";
}

- (BOOL)isInstalled
{
    return [self.baseURL.path rangeOfString:kKSP_PROPS].location != NSNotFound;
    
    return NO;
}

- (BOOL)isAvailable
{
    return [self.baseURL.path rangeOfString:kKSP_MODS_PROPS].location != NSNotFound;
}

#pragma mark -
#pragma mark Overridden Instance Methods

- (BOOL)moveTo:(NSURL *)destinationDirURL
{

    NSURL *targetURL = [destinationDirURL URLByAppendingPathComponent:self.baseURL.lastPathComponent isDirectory:YES];
    
    NSError *error = nil;
    
    [self.fileManager moveItemAtURL:self.baseURL toURL:targetURL error:&error];
    
    if( error ){
        self.error = error;
        return NO;
    }
    
    self.baseURL = targetURL;
    _configURL = [targetURL URLByAppendingPathComponent:self.configURL.lastPathComponent];
    self.error = nil;
    
    return YES;
}

- (BOOL)copyTo:(NSURL *)destinationDirURL
{
    
    NSURL *targetURL = [destinationDirURL URLByAppendingPathComponent:self.baseURL.lastPathComponent isDirectory:YES];
    
    NSError *error = nil;
    
    [self.fileManager copyItemAtURL:self.baseURL toURL:targetURL error:&error];
    
    if( error ) {
        self.error = error;
        return NO;
    }
    
    self.baseURL = targetURL;
    
    self.error = nil;
    
    return YES;
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
    NSLog(@"%@ rename unimplemented",self.class);
    return NO;
}

#pragma mark -
#pragma mark Class Methods

+ (NSArray *)inventory:(NSURL *)targetDir
{
    NSMutableArray *results =  [[NSMutableArray alloc] init];
    
    NSArray *propCfgPaths = [self assetSearch:targetDir usingBlock:^BOOL(NSString *path) {
        BOOL f = [path.lastPathComponent isEqualToString:kPROP_CONFIG];
        return f;
    }];
    
    for(NSString *cfgPath in propCfgPaths) {
        
        Prop *prop = [[Prop alloc] initWithURL:[targetDir URLByAppendingPathComponent:cfgPath]];
        if( prop )
            [results addObject:prop];
    }
    
    return results;
}

@end

