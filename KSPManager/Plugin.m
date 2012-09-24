//
//  Plugin.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/27/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Plugin.h"
#import "PortableExecutableFormat.h"

@interface Plugin () {
    PortableExecutableFormat *_pef;
}
@end

@implementation Plugin

@synthesize installedFileName = _installedFileName;
@synthesize availableFileName = _availableFileName;
@synthesize version = _version;



/* A Plugin can be found in one of three locations
 *
 * 1. in KSP_ROOT/kKSP_MODS/Plugins/OriginalFileName.dll-versionstring
 *
 *    Plugins here are in the Available state
 *    May be multiple files starting with OriginalFileName, append version to the end
 *    of the OriginalFileName to differenetiate
 *
 * 2. in KSP_ROOT/Plugins/OriginalFileName.dll
 * 
 *    Plugins here are in the Installed state
 *    Only one Plugin version installed at one time, remove version string
 *
 * 3. in a distribution folder  PARTDIR/OTHER/DIR/Plugins/OriginalFileName.dll
 *
 *    Pre-install state, need to be copied into either Installed or Available
 *
 */

#define kDLL_EXT @".dll"

#define kKSP_PLUGIN_VERSEP @"-KSPMPV-"

- (id)initWithURL:(NSURL *)pluginFileURL
{

    if( self = [super initWithURL:pluginFileURL] ) {

        _pef = [[PortableExecutableFormat alloc] initWithContentsOfURL:self.baseURL];
        
        NSString *fname = self.baseURL.lastPathComponent;
        
        NSArray *components = [fname componentsSeparatedByString:kKSP_PLUGIN_VERSEP];
        
        switch(components.count){
            case 1:
                _installedFileName = _pef.originalFileName;
                _availableFileName = [fname stringByAppendingFormat:@"%@%@",kKSP_PLUGIN_VERSEP,self.version];
                break;
                
            case 2:
                _installedFileName = [components objectAtIndex:0];
                _availableFileName = fname;
                break;
            default:
                NSLog(@"Plugin:initWithURL failed with weird name: %@",fname);
                self = nil;
        }
    }
    
    return self;
}



#pragma mark -
#pragma mark Properties


- (NSString *)description
{
    return [NSString stringWithFormat:@"PLUGIN %@, %@ pef:%@",self.installedFileName,self.version,_pef];
}

- (NSString *)version
{
    return _pef.productVersion;
}

- (NSString *)productName
{
    return _pef.productName;
}

- (NSString *)companyName
{
    return _pef.companyName;
}

#pragma mark -
#pragma mark Asset Overridden Methods

- (BOOL)isInstalled
{
    return [self.baseURL.path rangeOfString:kKSPManagedPlugins].location == NSNotFound;
}

- (BOOL)isAvailable
{
    return [self.baseURL.path rangeOfString:kKSPManagedPlugins].location != NSNotFound;
}

- (NSString *)assetTitle
{
    if( self.productName.length > 0 )
        return self.productName;
    
    return self.installedFileName;
}

- (NSString *)assetCategory
{
    return self.version;
}

#pragma mark -
#pragma mark Instance Methods

- (NSString *)filenameForPath:(NSString *)path
{
 
    NSRange range = [path rangeOfString:kKSP_MODS_PLUGINS];
    
    if( range.location == NSNotFound )
        return self.installedFileName;
    return self.availableFileName;
}

- (BOOL)moveTo:(NSURL *)destinationDirURL
{
    NSError *error = nil;
    NSURL *targetURL;
    
    targetURL = [destinationDirURL URLByAppendingPathComponent:[self filenameForPath:destinationDirURL.path]];
    
    //xxx need to handle overwriting and file exists conditions
    
    [self.fileManager moveItemAtURL:self.baseURL toURL:targetURL error:&error];
    
    self.error = error;
    if( error )
        return NO;

    self.baseURL = targetURL;

    return YES;
}

- (BOOL)copyTo:(NSURL *)destinationDirURL
{
    NSError *error = nil;

    NSURL *targetURL = [destinationDirURL URLByAppendingPathComponent:[self filenameForPath:destinationDirURL.path]];

    //xxx need to handle overwriting and file exists conditions
    
    [self.fileManager copyItemAtURL:self.baseURL toURL:targetURL error:&error];
    
    self.error = error;
    if( error )
        return NO;
    
    self.baseURL = targetURL;

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
    NSLog(@"plugin rename unimplimented");
    return NO;
}



#pragma mark -
#pragma mark Class Methods

+ (NSArray *)inventory:(NSURL *)baseURL
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    
    NSArray *paths = [self assetSearch:baseURL usingBlock:^BOOL(NSString *path){
        NSRange range = [path rangeOfString:kPLUGIN_EXT];
        return range.location==NSNotFound?NO:YES;
    }];
                
    for(NSString *path in paths){
        Plugin *plugin = [[Plugin alloc] initWithURL:[baseURL URLByAppendingPathComponent:path isDirectory:NO]];
        
        if( plugin )
            [results addObject:plugin];
    }
    
    return results;
}

@end
