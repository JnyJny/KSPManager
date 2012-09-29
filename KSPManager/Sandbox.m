//
//  Sandbox.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/22/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Sandbox.h"
#import "SFS.h"
#import "Ship.h"

@interface Sandbox ()
@property (strong, nonatomic) SFSGame *game;
@property (strong, nonatomic, readwrite) NSMutableArray *ships;
@end


@implementation Sandbox
@synthesize game = _game;
@synthesize ships = _ships;

#pragma mark -
#pragma mark Lifecycle


#pragma mark -
#pragma mark Properties

- (SFSGame *)game
{
    if( _game == nil ) {
        _game = [SFS gameFromContentsOfURL:self.url];
    }
    return _game;
}

- (NSMutableArray *)ships
{
    if( _ships == nil ) {
        _ships = [[NSMutableArray alloc] init];
        [_ships addObjectsFromArray:[Ship inventory:[self.url URLByDeletingLastPathComponent]]];
    }
    return _ships;
}

- (BOOL)isInstalled
{
    return [self.url.path rangeOfString:kKSPManagedRoot].location == NSNotFound;
}

- (BOOL)isAvailable
{
    return [self.url.path rangeOfString:kKSPManagedRoot].location != NSNotFound;
}

- (NSString *)assetTitle
{
    return @"sandbox";
}

- (NSString *)assetCategory
{
    return @"Sandbox";
}



#pragma mark -
#pragma mark Instance Methods


#pragma mark -
#pragma mark Class Methods
+ (NSArray *)inventory:(NSURL *)url
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    NSArray *sfsPaths = [self assetSearch:url usingBlock:^BOOL(NSString *path) {
        return [path.lastPathComponent isEqualToString:kKSP_PERSISTENT];
    }];
    
    for(NSString *sfsPath in sfsPaths) {
        Sandbox *sandbox = [[Sandbox alloc] initWithURL:[url URLByAppendingPathComponent:sfsPath]];
        if( sandbox )
            [results addObject:sandbox];
    }
    
    return results;
}


@end
