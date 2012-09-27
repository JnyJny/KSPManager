//
//  SFS.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/26/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "SFS.h"
#import "LineToken.h"
#import "SFSGame.h"

@interface SFS () {
    NSMutableDictionary *_options;
    SFSVessel *_vessel;
    SFSPart *_part;
}

@property (strong,nonatomic,readwrite) NSURL *url; // XXX is this kosher?
@property (strong,nonatomic,readwrite) SFSGame *sfsGame;

@end

@implementation SFS

@synthesize sfsGame = _sfsGame;

#pragma mark -
#pragma mark Lifecycle



#pragma mark -
#pragma mark Properties

- (SFSGame *)sfsGame
{
    if( _sfsGame == nil ) {
        _sfsGame = [[SFSGame alloc] init];
    }
    return _sfsGame;
}

#pragma mark -
#pragma mark ConfigurationParserDelegate Methods

- (BOOL)handleNewContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    
    if( [SFSGame keywordMatch:tokenizer.currentContext]  ||
        [tokenizer.currentContext isEqualToString:@"PARAMETERS"] ||
        [SFSFlight keywordMatch:tokenizer.currentContext] ||
        [SFSEditor keywordMatch:tokenizer.currentContext] ||
        [SFSTrackingStation keywordMatch:tokenizer.currentContext] ||
        [SFSSpaceCenter keywordMatch:tokenizer.currentContext]  ||
        [tokenizer.currentContext isEqualToString:@"FLIGHTSTATE"] ||
        [SFSCrew keywordMatch:tokenizer.currentContext] ||
        [SFSOrbit keywordMatch:tokenizer.currentContext] )
        return YES;
    
    if( [SFSVessel keywordMatch:tokenizer.currentContext] ) {
        _vessel = [[SFSVessel alloc] init];
        return YES;
    }
    
    if( [SFSPart keywordMatch:tokenizer.currentContext] ) {
        _part = [[SFSPart alloc] init];
        return YES;
    }
    
    if( [SFSModule keywordMatch:tokenizer.currentContext] ) {
        // module is nested in a part
        
        return YES;
    }
    
    if( [SFSScenario keywordMatch:tokenizer.currentContext] )
        return YES;
    
    return NO; // didn't handle the keyword
}

- (BOOL)handleBeginContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    _options = [[NSMutableDictionary alloc] init];
    
    return YES;
}

- (BOOL)handleKeyValue:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    
    if( [SFSGame keywordMatch:tokenizer.currentContext] ) {
        [self.sfsGame addEntriesFromDictionary:line.keyValue];
        return YES;
    }
    
    if( [SFSVessel keywordMatch:tokenizer.currentContext] ) {
        [_vessel addEntriesFromDictionary:line.keyValue];
        return YES;
    }
    
    if( [SFSPart keywordMatch:tokenizer.currentContext] ) {
        [_part addEntriesFromDictionary:line.keyValue];
        return YES;
    }
    
    [_options addEntriesFromDictionary:line.keyValue];
    
    return YES;
}

- (BOOL)handleEndContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    
    if( [SFSGame keywordMatch:tokenizer.currentContext] ||
        [tokenizer.currentContext isEqualToString:@"PARAMETERS"] ||
        [tokenizer.currentContext isEqualToString:@"FLIGHTSTATE"] ) {
        //        _options = nil;
        return YES;
    }
    
    if( [SFSFlight keywordMatch:tokenizer.currentContext] ||
        [SFSEditor keywordMatch:tokenizer.currentContext] ||
        [SFSTrackingStation keywordMatch:tokenizer.currentContext] ||
        [SFSSpaceCenter keywordMatch:tokenizer.currentContext] ) {
        
        [self.sfsGame addParameterForKeyword:tokenizer.currentContext
                                 withOptions:_options];
        _options = nil;
        return YES;
    }
    
    if( [SFSCrew keywordMatch:tokenizer.currentContext] ) {
        [self.sfsGame addCrewWithOptions:_options];
        _options = nil;
        return YES;
    }
    
    if( [SFSVessel keywordMatch:tokenizer.currentContext] ) {
        [self.sfsGame addVessel:_vessel];
        _vessel = nil;
        return YES;
    }
    
    if( [SFSOrbit keywordMatch:tokenizer.currentContext] ) {
        [_vessel addOrbitWithOptions:_options];
        _options = nil;
        return YES;
    }
    
    if( [SFSPart keywordMatch:tokenizer.currentContext] ) {
        [_vessel addPart:_part];
        _part = nil;
        return YES;
    }
    
    if( [SFSModule keywordMatch:tokenizer.currentContext] ) {
        // module is nested in a part
        [_part addModuleWithOptions:_options];
        _options = nil;
        return YES;
    }
    
    if( [SFSScenario keywordMatch:tokenizer.currentContext] ) {
        [self.sfsGame addScenarioWithOptions:_options];
        _options = nil;
        return YES;
    }
    
    return NO;
}







#pragma mark -
#pragma mark Instance Methods


#pragma mark -
#pragma mark Class Methods

+ (SFSGame *)gameFromContentsOfURL:(NSURL *)url
{
    SFS *sfs = [[SFS alloc] initWithContentsOfURL:url];

    return sfs.sfsGame;
}

@end
