//
//  Training.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/22/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Training.h"
#import "SFS.h"

@interface Training ()

@property (strong, nonatomic) SFSGame *game;

@end

@implementation Training

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
    return @"Training";
}

#pragma mark -
#pragma mark Instance Methods


#pragma mark -
#pragma mark Class Methods
+ (NSArray *)inventory:(NSURL *)baseURL
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    NSArray *sfsPaths = [self assetSearch:baseURL usingBlock:^BOOL(NSString *path) {
        return [[path pathExtension] isEqualToString:kSFS_EXT];
    }];
    
    for(NSString *sfsPath in sfsPaths) {
        Training *training = [[Training alloc] initWithURL:[baseURL URLByAppendingPathComponent:sfsPath]];
        if( training )
            [results addObject:training];
    }
 
    return results;
}

@end
