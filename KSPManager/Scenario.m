//
//  Scenario.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/22/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Scenario.h"
#import "SFS.h"

@interface Scenario ()

@property (strong, nonatomic) SFSGame *game;

@end

@implementation Scenario

@synthesize game = _game;

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
    return self.game.title;
}

- (NSString *)assetCategory
{
    return @"Scenario";
}



#pragma mark -
#pragma mark Instance Methods




#pragma mark -
#pragma mark Class Methods
+ (NSArray *)inventory:(NSURL *)url
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    NSArray *sfsPaths = [self assetSearch:url usingBlock:^BOOL(NSString *path) {
        return [[path pathExtension] isEqualToString:kSFS_EXT];
    }];
    
    for(NSString *sfsPath in sfsPaths) {
        Scenario *scenario = [[Scenario alloc] initWithURL:[url URLByAppendingPathComponent:sfsPath]];
        if( scenario )
            [results addObject:scenario];
    }
    
    return results;
}


@end
