//
//  Prop.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/17/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Prop.h"
#import "CFGProp.h"

@interface Prop ()
@property (strong,nonatomic, readwrite) NSString *propFileName;
@property (strong,nonatomic) CFGProp *cfgProp;
@end

@implementation Prop

@synthesize cfgProp = _cfgProp;

- (id)initWithURL:(NSURL *)url
{
    if( self = [super initWithURL:[url URLByDeletingLastPathComponent]] ) {
        self.propFileName = url.lastPathComponent;
    }
    return self;
}

- (CFGProp *)cfgProp
{
    if( _cfgProp == nil ) {
        // _cfgProp = [PropCFG propForContentsOfURL:self.url];
    }
    return _cfgProp;
}

#pragma mark -
#pragma mark Overridden Properties

- (NSString *)assetTitle
{
    return self.url.lastPathComponent;
}

- (NSString *)assetCategory
{
    return @"Prop";
}

- (BOOL)isInstalled
{
    return [self.url.path rangeOfString:kKSP_PROPS].location != NSNotFound;
}

- (BOOL)isAvailable
{
    return [self.url.path rangeOfString:kKSPManagedProps].location != NSNotFound;
}

#pragma mark -
#pragma mark Overridden Instance Methods

- (BOOL)moveTo:(NSURL *)destinationDirURL
{

    NSURL *targetURL = [destinationDirURL URLByAppendingPathComponent:self.url.lastPathComponent isDirectory:YES];
    
    NSError *error = nil;
    
    [self.fileManager moveItemAtURL:self.url toURL:targetURL error:&error];
    
    if( error ){
        self.error = error;
        return NO;
    }
    
    self.url = targetURL;

    self.error = nil;
    
    return YES;
}

- (BOOL)copyTo:(NSURL *)destinationDirURL
{
    
    NSURL *targetURL = [destinationDirURL URLByAppendingPathComponent:self.url.lastPathComponent isDirectory:YES];
    
    NSError *error = nil;
    
    [self.fileManager copyItemAtURL:self.url toURL:targetURL error:&error];
    
    if( error ) {
        self.error = error;
        return NO;
    }
    
    self.url = targetURL;
    self.error = nil;
    return YES;
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

