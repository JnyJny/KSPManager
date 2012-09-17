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

@synthesize url = _url;

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

- (NSURL *)url
{
    if( _url == nil ) {
    
        NSString *directDL = [self valueForKey:kKerbalNetKeyModDirect_download];
    
        // XXX move error generation into valueForKey, fix error domain here
        if( directDL == nil ) {
            self.error = [NSError errorWithDomain:kKerbalNetErrorDomain
                                             code:kKerbalNetErrorCodeMissingDirectDownloadKey
                                         userInfo:@{NSLocalizedDescriptionKey : @"Kerbal.Net api_lookup_mod data did not contain mod_direct_download key."}];
            return nil;
        }
    
        _url = [NSURL URLWithString:[@"http://" stringByAppendingString:directDL]];
    }
    return _url;
}

- (BOOL)downloadTo:(NSURL *)localURL
{
    NSError *error = nil;
    
    // XXX needs a protocol and an operation queue so this can't hang the
    //     main thread.
    NSLog(@"%@ downloadTo:%@ toLocalURL: %@",self.class,self.url,localURL);
    
    NSData *modFile = [NSData dataWithContentsOfURL:self.url
                                            options:0
                                              error:&error];
    
    self.error = error;
    
    if( error )
        return NO;
    
    if( modFile ) {
        
        [modFile writeToURL:localURL
                    options:0
                      error:&error];
        self.error = error;
        if( error )
            return NO;
    }
    
    return YES;
    
}

@end
