//
//  Plugin.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/27/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Plugin.h"
#import "PortableExecutableFormat.h"

@implementation Plugin

@synthesize fileName = _fileName;

- (id)initWithPluginFileURL:(NSURL *)pluginFileURL
{
    self = [super initWithURL:pluginFileURL];
    
    _fileName = self.baseURL.lastPathComponent;

    if (self) {
        _pfe = [[PortableExecutableFormat alloc] initWithContentsOfURL:self.baseURL];
    }
    
    return self;
}

#pragma mark -
#pragma mark Properties

- (NSString *)description
{
    return [NSString stringWithFormat:@"PLUGIN %@, %@",self.fileName,self.version];
    
}

- (void)setBaseURL:(NSURL *)baseURL
{
    [super setBaseURL:baseURL];
    _fileName = [self.baseURL lastPathComponent];
}

- (NSString *)version
{
    return [_pfe version];
}

- (BOOL)isInstalled
{
    NSRange range = [self.baseURL.path rangeOfString:kKSP_MODS];
    return (range.location == NSNotFound);
}


#pragma mark -
#pragma mark Instance Methods

- (BOOL)movePluginTo:(NSURL *)destinationDirectoryURL
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSURL *targetURL = [destinationDirectoryURL URLByAppendingPathComponent:self.fileName];
    
    [fileManager moveItemAtURL:self.baseURL toURL:targetURL error:&error];
    
    self.error = error;
    if( error )
        return NO;

    self.baseURL = targetURL;
 
    return YES;
}

- (BOOL)copyPluginTo:(NSURL *)destinationDirectoryURL
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSURL *targetURL = [destinationDirectoryURL URLByAppendingPathComponent:self.fileName];
    
    [fileManager copyItemAtURL:self.baseURL toURL:targetURL error:&error];
    
    self.error = error;
    if( error )
        return NO;
    
    self.baseURL = targetURL;
    
    return YES;
}

#pragma mark -
#pragma mark Class Methods

+ (NSArray *)inventory:(NSURL *)baseURL
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    NSArray *paths = [self assetSearch:baseURL usingBlock:^BOOL(NSString *path){
        return [path.pathExtension isEqualToString:kPLUGIN_EXT];
    }];
                
    for(NSString *path in paths){
        Plugin *plugin = [[Plugin alloc] initWithPluginFileURL:[baseURL URLByAppendingPathComponent:path isDirectory:NO]];
        
        if( plugin )
            [results addObject:plugin];
    }
    
    return results;
}

@end
