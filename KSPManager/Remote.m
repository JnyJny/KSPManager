//
//  Remote.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/13/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Remote.h"
#import "KerbalNet.h"

@implementation Remote

- (id)initWithOptions:(NSDictionary *)options
{
    
    NSURL *url = [options valueForKey:@"mod_direct_download"];
    
    if( self = [super initWithURL:url] ) {
        [self addEntriesFromDictionary:options];
    }
    return self;
}

- (NSString *)assetTitle
{
    return [self valueForKey:@"mod_name"];
}

- (NSString *)assetCategory
{
    return [self valueForKey:@"mod_latestversion"];
}

- (BOOL)isInstalled
{
    return NO;
}

- (BOOL)isAvailable
{
    return YES;
}

- (BOOL)moveTo:(NSURL *)destinationDirURL
{
    
    return NO;
}

- (BOOL)copyTo:(NSURL *)destinationDirURL
{
 
    return NO;
}

- (BOOL)rename:(NSURL *)newName
{
    return NO;
}

- (BOOL)remove
{
    return NO;
}


@end
