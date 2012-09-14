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
}
@end

@implementation KerbalNet

@synthesize applicationId = _applicationId;
@synthesize applicationToken = _applicationToken;
@synthesize username = _username;
@synthesize password = _password;

@synthesize remoteAssets = _remoteAssets;

#define kKerbalNetURL @"http://www.kerbal.net/api/api.php"
#define kKerbalNetAppFormat @"?api_application_id=%@&api_application_token=%@"

- (id)initWithApplicationID:(NSString *)identifier andApplicationToken:(NSString *)token
{
    if ( self = [super init] ) {
        self.applicationId = identifier;
        self.applicationToken = token;
        _baseURLString = [kKerbalNetURL stringByAppendingFormat:kKerbalNetAppFormat,self.applicationId,self.applicationToken];
    }
    return self;
}

#pragma mark -
#pragma mark Properties


- (NSArray *)remoteAssets
{

    if( _remoteAssets == nil ) {
        
        NSMutableArray *tmp = [[NSMutableArray alloc] init];
        
        for(NSDictionary *shortInfo in [self completeModListing] ) {
            NSString *idStr = [shortInfo valueForKey:kKerbalNetKeyModId];
    
            NSDictionary *longInfo = [self modLookupById:idStr.integerValue];
            
            if( longInfo == nil ) {
                NSLog(@"modLookupById:%@ failed",idStr);
                continue;
            }

            Remote *remote = [[Remote alloc] initWithOptions:longInfo];
            if( remote )
                [tmp addObject:remote];
        
        }
        _remoteAssets = tmp;
    }
    return _remoteAssets;
}

#define kKerbalNetAPIModListing @"api_mod_listing"
#define kKerbalNetAPIModLookup  @"api_mod_lookup"
#define kKerbalNetAPIModId      @"api_mod_id"

#pragma mark -
#pragma mark Private Instance Methods

- (NSURL *)api_function:(NSString *)fname
{
    return [NSURL URLWithString:[_baseURLString stringByAppendingFormat:@"&landing=%@",fname]];
}

- (NSURL *)api_function:(NSString *)fname withArgument:(NSString *)argument
{
    return [NSURL URLWithString:[_baseURLString stringByAppendingFormat:@"&landing=%@&%@",fname,argument]];
}

- (NSURL *)URLcompleteList
{
    return [self api_function:kKerbalNetAPIModListing];
}

- (NSURL *)URLlookupModByIdentifier:(NSInteger)identifier
{
    return [self api_function:kKerbalNetAPIModLookup withArgument:[kKerbalNetAPIModId stringByAppendingFormat:@"=%ld",identifier]];
}

- (NSURL *)URLloginWithUsername:(NSString *)username andPassword:(NSString *)password
{
    return nil;
}

- (NSURL *)URLuserDataWithUsername:(NSString *)username andSession:(NSString *)session
{
    return nil;
}

- (NSArray *)completeModListing
{
    NSError *error = nil;
    NSURL *url = [self URLcompleteList];
    NSStringEncoding encoding;
    NSString *s;
    
    s = [NSString stringWithContentsOfURL:url
                             usedEncoding:&encoding
                                    error:&error];
    
    NSData *data = [s dataUsingEncoding:encoding];
    
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
}

- (NSDictionary *)modLookupById:(NSInteger)identifer
{
    NSStringEncoding encoding;
    NSError *error;
    
    NSURL *url = [self URLlookupModByIdentifier:identifer];
    
    NSString *s = [NSString stringWithContentsOfURL:url usedEncoding:&encoding error:&error];
    
    if(error) {
        NSLog(@"stringWithContentsOfURL:%@ failed %@",url,error);
        return nil;
    }
    
    NSLog(@"S = %@",s);
    
    NSData *data = [s dataUsingEncoding:encoding];
    
    error = nil ;
    
    NSArray *results = [NSJSONSerialization JSONObjectWithData:data
                                                       options:0
                                                         error:&error];
    
    if( error ) {
        NSLog(@"NSJSONSerialization failed %@",error);
        return nil;
    }
    
    return results.lastObject;
}


    

@end
