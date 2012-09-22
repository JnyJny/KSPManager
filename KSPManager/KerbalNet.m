//
//  KerbalNet.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/13/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "KerbalNet.h"
#import "Remote.h"

@interface KerbalNet () {
    NSString *_baseURLString;
    NSOperationQueue *_operationQueue;
}
@end

@implementation KerbalNet

@synthesize delegate;
@synthesize applicationId = _applicationId;
@synthesize applicationToken = _applicationToken;
@synthesize username = _username;
@synthesize password = _password;
@synthesize error = _error;

@synthesize remoteAssets = _remoteAssets;

#define kKerbalNetURL @"http://www.kerbal.net/api/api.php"
#define kKerbalNetAppFormat @"?api_application_id=%@&api_application_token=%@"

- (id)initWithApplicationID:(NSString *)identifier andApplicationToken:(NSString *)token
{
    if ( self = [super init] ) {
        self.applicationId = identifier;
        self.applicationToken = token;
        _baseURLString = [kKerbalNetURL stringByAppendingFormat:kKerbalNetAppFormat,self.applicationId,self.applicationToken];
        self.error = nil;
        _operationQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}


#pragma mark -
#pragma mark Properties


- (NSMutableArray *)remoteAssets
{
    if( _remoteAssets == nil ) {
        _remoteAssets = [[NSMutableArray alloc] init];
    }
    return _remoteAssets;
}


#pragma mark -
#pragma mark Private Instance Methods


/*
 * api_function methods build URLs encoding the requestion Kerbal.Net
 * API function and optional arguments string.
 */

- (NSURL *)api_function:(NSString *)fname withArgument:(NSString *)arguments
{
    NSString *urlString = [_baseURLString stringByAppendingFormat:@"&landing=%@",fname];
    
    if( arguments )
        urlString = [urlString stringByAppendingFormat:@"&%@",arguments];
    
    return [NSURL URLWithString:urlString];
}

- (NSURL *)api_function:(NSString *)fname
{
    return [self api_function:fname withArgument:nil];
}


/*
 * Methods with the URL prefix return a URL ready to use for
 * a specific Kerbal.Net API function.
 */

- (NSURL *)URLcompleteList
{
    return [self api_function:kKerbalNetAPIFunctionModListing];
}

- (NSURL *)URLlookUpModByIdentifier:(NSInteger)identifier
{
    return [self api_function:kKerbalNetAPIFunctionModLookup withArgument:[kKerbalNetAPIArgumentModId stringByAppendingFormat:@"=%ld",identifier]];
}

- (NSURL *)URLloginWithUsername:(NSString *)username andPassword:(NSString *)password
{
    NSLog(@"%@ URLLoginWithUserName:%@ andPassword: unimplimented",self.class,username);
    return nil;
}

- (NSURL *)URLuserDataWithUsername:(NSString *)username andSession:(NSString *)session
{
    
    NSLog(@"%@ URLuserDataWithUsername:%@ andSession:%@ unimplemented",self.class,username,session);
    
    return nil;
}

#pragma mark -
#pragma mark KerbalNetDelegate Methods

- (void)informDelegateWillAccessURL:(NSURL *)url
{
    if( self.delegate && [self.delegate respondsToSelector:@selector(willBeginNetworkOperationWith:)] ) {
        [self.delegate performSelector:@selector(willBeginNetworkOperationWith:) withObject:url];
    }
}

- (void)informDelegateDidAccessURL:(NSURL *)url withError:(NSError *)error
{
    if( self.delegate && [self.delegate respondsToSelector:@selector(didFinishNetworkOperaitonWIth:andError:)]) {
        [self.delegate performSelector:@selector(didFinishNetworkOperaitonWIth:andError:) withObject:url withObject:error];
    }
}



- (NSArray *)completeListing
{
    NSError *error = nil;
    NSURL *url = [self URLcompleteList];
    NSStringEncoding encoding;
    NSString *s;
    NSArray *results;
    
    [self informDelegateWillAccessURL:url];
    
    s = [NSString stringWithContentsOfURL:url
                             usedEncoding:&encoding
                                    error:&error];
    
    [self informDelegateDidAccessURL:url withError:error];
    
    self.error = error;
    
    if( error )
        return nil;
    
    NSData *data = [s dataUsingEncoding:encoding];
    
    error = nil;
    
    results = [NSJSONSerialization JSONObjectWithData:data
                                              options:0
                                                error:&error];
    
    self.error = error;
    
    if( error )
        return nil;
    
    return results;
}

- (NSDictionary *)lookUpModById:(NSInteger)identifer
{
    NSStringEncoding encoding;
    NSError *error = nil;
    
    NSURL *url = [self URLlookUpModByIdentifier:identifer];

    
    [self informDelegateWillAccessURL:url];
    NSString *s = [NSString stringWithContentsOfURL:url
                                       usedEncoding:&encoding
                                              error:&error];
    
    [self informDelegateDidAccessURL:url withError:error];
    
    
    self.error = error;
    
    if(error)
        return nil;

    
    NSData *data = [s dataUsingEncoding:encoding];
    
    error = nil ;
    
    NSArray *results = [NSJSONSerialization JSONObjectWithData:data
                                                       options:0
                                                         error:&error];
    
    self.error = error;
    
    if( error )
        return nil;

    if ( results.count == 1 )
        return results.lastObject;
    
    for(NSDictionary *d in results){
        NSString *idString = [d valueForKey:kKerbalNetKeyModId];
        if (idString.integerValue == identifer ) {
            return d;
        }
    }
    
    self.error  = [NSError errorWithDomain:kKerbalNetErrorDomain
                                      code:kKerbalNetErrorCodeModLookupFailed
                                  userInfo:@{ NSLocalizedDescriptionKey : [@"Kerbal.Net was unable to locate mod with ID %ld" stringByAppendingFormat:@"%ld",identifer]}];
                   
    
    return nil;
}

#pragma mark -
#pragma mark Instance Methods

- (BOOL)refresh
{
    
    [_operationQueue addOperationWithBlock:^{
        
        if( self.delegate && [self.delegate respondsToSelector:@selector(willBeginRefresh)]) {
            [(NSObject *)self.delegate performSelectorOnMainThread:@selector(willBeginRefresh) withObject:nil waitUntilDone:NO];
        }
        
        [self.remoteAssets removeAllObjects];
    
        for(NSDictionary *shortInfo in [self completeListing] ) {
        
            NSString *idStr = [shortInfo valueForKey:kKerbalNetKeyModId];
        
            if( idStr == nil ){

            
                self.error = [NSError errorWithDomain:kKerbalNetErrorDomain
                                                 code:kKerbalNetErrorCodeMissingIdKey
                                             userInfo:@{NSLocalizedDescriptionKey : @"Kerbal.Net api_lookup_mod data did not contain mod_id key."}];
                return;
            }
        
            NSDictionary *longInfo = [self lookUpModById:idStr.integerValue];
        
            if( longInfo == nil ) {
                NSLog(@"%@ lookUpModById:%@ failed: %@",self.class,idStr,self.error);
                continue;
            }
        
            Remote *remote = [[Remote alloc] initWithOptions:longInfo];
            if( remote )
                [self.remoteAssets addObject:remote];
        }
        
        if( self.delegate && [self.delegate respondsToSelector:@selector(didEndRefresh)] ) {
            [(NSObject *)self.delegate performSelectorOnMainThread:@selector(didEndRefresh) withObject:nil waitUntilDone:NO];
        }

    }];
    
    return YES;
}

- (BOOL)downloadRemoteAsset:(Remote *)remote toDestination:(NSURL *)destinationURL
{

    // check remote is in self.remoteAssets?
    
    [_operationQueue addOperationWithBlock:^{
        
        [ (NSObject *)self.delegate performSelectorOnMainThread:@selector(willBeginNetworkOperationForRemoteAsset:)
                                                     withObject:remote
                                                  waitUntilDone:NO];
        [remote downloadTo:destinationURL];

        [ (NSObject *)self.delegate performSelectorOnMainThread:@selector(didFinishNetworkOperationForRemoteAsset:)
                                                     withObject:remote
                                                  waitUntilDone:NO];
    }];
    
    return YES;
}


@end
