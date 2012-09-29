//
//  Remote.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/13/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Remote.h"
#import "KerbalNet.h"

@interface Remote ()

@property (strong, nonatomic, readwrite) NSURL *localURL;
@property (assign, nonatomic, readwrite) BOOL isDownloaded;
@property (strong, nonatomic, readwrite) NSString *cleanDescription;

@end

@implementation Remote

// 1. download to temporary dir
// 2. unpack archive
// 3. create a new managed asset from the unpacked gorp
// 4. 

@synthesize url = _url;
@synthesize localURL = _localURL;
@synthesize cleanDescription = _cleanDescription;

- (id)initWithOptions:(NSDictionary *)options
{
    if( self = [super initWithURL:nil] ) {
        [self addEntriesFromDictionary:options];
    }
    
    self.isDownloaded = NO;
    
    return self;
}

- (NSString *)assetTitle
{


    return [self valueForKey:kKerbalNetKeyModName];
}

- (NSString *)assetCategory
{
    return [self valueForKey:kKerbalNetKeyModLatestversion];
}

- (NSString *)cleanDescription
{
    if ( _cleanDescription == nil ) {
        _cleanDescription = [[self valueForKey:kKerbalNetKeyModDescription] stringByReplacingOccurrencesOfString:@"rn" withString:@" "];
    }
    return _cleanDescription;
}

- (BOOL)isInstalled
{
    // remote assets don't get installed, assets created from remotes do
    return NO;
}

- (BOOL)isAvailable
{
    // remote assets aren't available, assets created from remotes are
    return NO;
}

- (BOOL)isDownloaded
{
    return [self.localURL checkResourceIsReachableAndReturnError:nil];
}

- (BOOL)moveTo:(NSURL *)destinationDirURL
{
    [self downloadTo:destinationDirURL];
    return NO;
}

- (BOOL)copyTo:(NSURL *)destinationDirURL
{
    // xxx should be something we can do here.
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
    
        _url = [NSURL URLWithString:[@"http://" stringByAppendingString:directDL]];;
    }
    return _url;
}

- (BOOL)downloadTo:(NSURL *)localURL
{
    NSError *error = nil;
    
    self.localURL = nil;

    //NSLog(@"%@ downloadTo:%@ toLocalURL: %@",self.class,self.url,localURL);
    
    NSData *modFile = [NSData dataWithContentsOfURL:self.url
                                            options:0
                                              error:&error];
    
    self.error = error;
    
    if( error ) {
        return NO;
    }
    
    [modFile writeToURL:localURL
                options:0
                  error:&error];
    
    self.error = error;
    if( error ) {
        return NO;
    }
    
    self.localURL = localURL;
    return YES;
}

@end
