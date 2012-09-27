//
//  Ship.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/10/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Ship.h"
#import "CRAFT.h"

@interface Ship () {
    SFSVessel *_vessel;
}


@end

@implementation Ship


@synthesize hanger = _hanger;
@synthesize isInSpacePlaneHanger = _isInSpacePlaneHanger;
@synthesize isInVehicleAssemblyBuilding = _isInVehicleAssemblyBuilding;

- (id)initWithURL:(NSURL *)url
{
    if ( self = [super initWithURL:url] ) {
        
        if( [self.baseURL.pathExtension isNotEqualTo:kCRAFT_EXT])
            return nil;
        _vessel = [CRAFT vesselForContentsOfURL:self.baseURL];
    }
    return self;
}

#pragma mark -
#pragma mark Overriden Properties

#define kShipKeyShipName @"ship"
#define kShipFilenameAutoSaved @"Auto-Saved Ship"

- (NSString *)assetTitle
{
    if( [self.baseURL.lastPathComponent rangeOfString:kShipFilenameAutoSaved].location != NSNotFound    )
        return [NSString stringWithFormat:@"Auto-Saved %@",[self valueForKey:kShipKeyShipName]];
    
    return [_vessel valueForKey:kShipKeyShipName];
}

- (NSString *)assetCategory
{
    return self.hanger;
}

- (BOOL)isInstalled
{
    return [self.baseURL.path rangeOfString:kKSPManagedShips].location == NSNotFound;
}

- (BOOL)isAvailable
{
    return [self.baseURL.path rangeOfString:kKSPManagedShips].location != NSNotFound;
}

#pragma mark -
#pragma mark Properties

- (NSString *)hanger
{
    if( _hanger == nil ){
        _hanger = kKSP_VAB; // Default to being in the VAB
        if( self.isInSpacePlaneHanger )
            _hanger = kKSP_SPH;
    }
    return _hanger;
}

- (void)setHanger:(NSString *)hanger
{
    if( [_hanger isEqualToString:hanger] )
        return ;
    
    _hanger = hanger;
    
    NSURL *url = [[[self.baseURL URLByDeletingLastPathComponent] URLByDeletingLastPathComponent] URLByAppendingPathComponent:_hanger];;
    
    [self moveTo:url];
}

- (BOOL)isInVehicleAssemblyBuilding
{
    return [self.baseURL.path rangeOfString:kKSP_VAB].location != NSNotFound;
}

- (BOOL)isInSpacePlaneHanger
{
    return [self.baseURL.path rangeOfString:kKSP_SPH].location != NSNotFound;
}

- (NSString *)description
{
    return [self.baseURL.path stringByAppendingFormat:@": %@, %@",self.assetTitle,self.assetCategory];
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
    
    targetURL = [destinationDirURL URLByAppendingPathComponent:self.baseURL.lastPathComponent];

    [self.fileManager moveItemAtURL:self.baseURL toURL:targetURL error:&error];
    
    self.error = error;
    
    if( self.error )
        return NO;
    
    self.baseURL = targetURL;
    
    return YES;
}

- (BOOL)copyTo:(NSURL *)destinationDirURL
{
    NSError *error = nil;
    
    NSURL *targetURL = [destinationDirURL URLByAppendingPathComponent:self.baseURL.lastPathComponent];
    
    [self.fileManager copyItemAtURL:self.baseURL toURL:targetURL error:&error];
    
    self.error = error;
    if( self.error )
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
    NSLog(@"ship rename unimplimented");
    return NO;
}

#pragma mark -
#pragma mark Class Methods




#pragma mark -
#pragma mark Class methods



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
