//
//  Plugin.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/27/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Plugin.h"
#import "PortableExecutableFormat.h"

@interface Plugin ()
@property (strong, nonatomic) PortableExecutableFormat *pef;
@property (strong, nonatomic) NSString *baseFilename;
@property (strong, nonatomic, readwrite) NSString *installedFileName;
@property (strong, nonatomic, readwrite) NSString *availableFileName;
@end

@implementation Plugin

@synthesize pef = _pef;
@synthesize baseFilename = _baseFilename;
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


#pragma mark -
#pragma mark Properties


- (PortableExecutableFormat *)pef
{
    if( _pef == nil ) {
        _pef = [[PortableExecutableFormat alloc] initWithContentsOfURL:self.url];
    }
    return _pef;
}


// installedFileName == originalFile;

- (NSString *)installedFileName
{
    if( _installedFileName == nil ) {
        _installedFileName = self.pef.originalFileName;
    }
    return _installedFileName;
}

- (NSString *)availableFileName
{
    if( _availableFileName == nil ) {
        _availableFileName = [self.pef.originalFileName stringByAppendingFormat:@"%@%@",kKSP_PLUGIN_VERSEP,self.version];
    }
    return _availableFileName;
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"PLUGIN %@, %@ pef:%@",self.installedFileName,self.version,self.pef];
}

- (NSString *)version
{
    return self.pef.productVersion;
}

- (NSString *)productName
{
    return self.pef.productName;
}

- (NSString *)companyName
{
    return self.pef.companyName;
}

#pragma mark -
#pragma mark Asset Overridden Methods

- (BOOL)isInstalled
{
    return [self.url.path rangeOfString:kKSPManagedPlugins].location == NSNotFound;
}

- (BOOL)isAvailable
{
    return [self.url.path rangeOfString:kKSPManagedPlugins].location != NSNotFound;
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
    NSRange range = [path rangeOfString:kKSPManagedPlugins];
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
    
    [self.fileManager moveItemAtURL:self.url toURL:targetURL error:&error];
    
    self.error = error;
    if( error )
        return NO;

    self.pef = nil;
    self.url = targetURL;

    return YES;
}

- (BOOL)copyTo:(NSURL *)destinationDirURL
{
    NSError *error = nil;

    NSURL *targetURL = [destinationDirURL URLByAppendingPathComponent:[self filenameForPath:destinationDirURL.path]];

    //xxx need to handle overwriting and file exists conditions
    
    [self.fileManager copyItemAtURL:self.url toURL:targetURL error:&error];
    
    self.error = error;
    if( error )
        return NO;
    
    self.url = targetURL;

    return YES;
}

- (BOOL)remove
{
    NSError *error = nil;
    
    [self.fileManager removeItemAtURL:self.url error:&error];
    
    self.error = error;
    
    if( error )
        return NO;
    
    self.url = nil;
    
    
    return YES;
}


#pragma mark -
#pragma mark Class Methods

+ (NSArray *)inventory:(NSURL *)url
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    NSArray *paths = [self assetSearch:url usingBlock:^BOOL(NSString *path){
        NSRange range = [path rangeOfString:kPLUGIN_EXT];
        return range.location==NSNotFound?NO:YES;
    }];
                
    for(NSString *path in paths){
        Plugin *plugin = [[Plugin alloc] initWithURL:[url URLByAppendingPathComponent:path isDirectory:NO]];
        if( plugin )
            [results addObject:plugin];
    }
    
    return results;
}

@end
