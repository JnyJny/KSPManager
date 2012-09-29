//
//  Ship.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/10/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Ship.h"
#import "CRAFT.h"

@interface Ship ()
@property (strong,nonatomic, readwrite) NSString *hangerName;
@property (strong,nonatomic) CRAFTVessel *vessel;
@end

@implementation Ship

@synthesize vessel = _vessel;
@synthesize hangerName = _hangerName;
@synthesize isInSpacePlaneHanger = _isInSpacePlaneHanger;
@synthesize isInVehicleAssemblyBuilding = _isInVehicleAssemblyBuilding;
@synthesize isSandboxed = _isSandboxed;

#pragma mark -
#pragma mark Overriden Properties

- (id)valueForUndefinedKey:(NSString *)key
{
    return [self.vessel valueForKey:key];
}

#define kShipKeyShipName @"ship"
#define kShipFilenameAutoSaved @"Auto-Saved Ship"

- (NSString *)assetTitle
{
    if( [self.url.lastPathComponent rangeOfString:kShipFilenameAutoSaved].location != NSNotFound    )
        return [NSString stringWithFormat:@"Auto-Saved %@",[self valueForKey:kShipKeyShipName]];
    
    return [self.vessel valueForKey:kShipKeyShipName];
}

- (NSString *)assetCategory
{
    return self.hangerName;
}

- (BOOL)isInstalled
{
    return [self.url.path rangeOfString:kKSPManagedShips].location == NSNotFound;
}

- (BOOL)isAvailable
{
    return [self.url.path rangeOfString:kKSPManagedShips].location != NSNotFound;
}

- (BOOL)isSandboxed
{
    return ([self.url.path rangeOfString:kKSPManagedSandboxes].location != NSNotFound) ||
        ([self.url.path rangeOfString:kKSP_SANDBOXES].location != NSNotFound) ;
}

#pragma mark -
#pragma mark Properties

- (CRAFTVessel *)vessel
{
    if( _vessel == nil ) {
        _vessel = [CRAFT vesselForContentsOfURL:self.url];
    }
    return _vessel;
}

- (NSString *)hangerName
{
    if( _hangerName == nil ){
        _hangerName = kKSP_VAB; // Default to being in the VAB
        if( self.isInSpacePlaneHanger )
            _hangerName = kKSP_SPH;
    }
    return _hangerName;
}

- (void)setHangerName:(NSString *)hanger
{
    if( [_hangerName isEqualToString:hanger] )
        return ;
    
    _hangerName = hanger;
    
    // XXX not sure this right,  Ships/[VAB|SPH]/ship.craft -> Ships/_hangerName? and moveTo: appends the ship name back on
    
    NSURL *dst = [[[self.url URLByDeletingLastPathComponent] URLByDeletingLastPathComponent] URLByAppendingPathComponent:_hangerName];
    
    [self moveTo:dst];
}

- (BOOL)isInVehicleAssemblyBuilding
{
    return [self.url.path rangeOfString:kKSP_VAB].location != NSNotFound;
}

- (BOOL)isInSpacePlaneHanger
{
    return [self.url.path rangeOfString:kKSP_SPH].location != NSNotFound;
}

- (NSString *)description
{
    return [self.url.path stringByAppendingFormat:@": %@, %@",self.assetTitle,self.assetCategory];
}

- (NSMutableArray *)parts
{
    return _vessel.parts;
}

#pragma mark -
#pragma mark Instance Methods

- (BOOL)moveTo:(NSURL *)destinationDirURL
{
    NSError *error = nil;
    NSURL *targetURL = nil;
    
    [self.fileManager createDirectoryAtURL:destinationDirURL
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:&error];
    
    self.error = error;
    
    if( error )
        return NO;
    
    error = nil;
    
    targetURL = [destinationDirURL URLByAppendingPathComponent:self.url.lastPathComponent];

    [self.fileManager moveItemAtURL:self.url toURL:targetURL error:&error];
    
    self.error = error;
    
    if( self.error )
        return NO;
    
    self.url = targetURL;
    
    return YES;
}

- (BOOL)copyTo:(NSURL *)destinationDirURL
{
    NSError *error = nil;
    
    NSURL *targetURL = [destinationDirURL URLByAppendingPathComponent:self.url.lastPathComponent];
    
    [self.fileManager copyItemAtURL:self.url toURL:targetURL error:&error];
    
    self.error = error;
    if( self.error )
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

+ (NSArray *)inventory:(NSURL *)baseUrl
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    NSArray *paths = [self assetSearch:baseUrl usingBlock:^BOOL(NSString *path) {
        return [path.pathExtension caseInsensitiveCompare:kCRAFT_EXT] == NSOrderedSame;
    }];
    
    for(NSString *path in paths) {
        Ship *ship = [[Ship alloc] initWithURL:[baseUrl URLByAppendingPathComponent:path isDirectory:NO]];
        if( ship )
            [results addObject:ship];
    }
    
    return results;
}

@end
