//
//  PersistenceFile.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/5/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "PersistenceFile.h"
#import "PersistentObject.h"
#import "Orbit.h"

@implementation PersistenceFile

@synthesize url = _url;
@synthesize global = _global;
@synthesize crew = _crew;
@synthesize vessels = _vessels;
@synthesize encoding = _encoding;

@synthesize currentCrew   = _currentCrew;
@synthesize currentVessel = _currentVessel;
@synthesize currentPart   = _currentPart;


- (id)initWithURL:(NSURL *)url
{
    if ( self = [super init]) {
        _url = url;
        
        _parser = [ConfigurationParser parserWithURL:_url];
        
        _parser.delegate = self;
        
        [_parser beginParsing];
    }
    return self;
}

#pragma mark -
#pragma mark Properties
- (NSMutableDictionary *)global
{
    if( _global == nil ) {
        _global = [[NSMutableDictionary alloc] init];
    }
    return _global;
}

- (NSMutableArray *)crew
{
    if( _crew == nil ) {
        _crew = [[NSMutableArray alloc] init];
    }
    return _crew;
}

- (NSMutableArray *)vessels
{
    if( _vessels == nil ) {
        _vessels = [[NSMutableArray alloc] init];
    }
    return _vessels;
}

#pragma mark -
#pragma mark ConfigurationTokenizerDelegate Methods

- (void)willBeginParsingWithConfiguration:(ConfigurationParser *)tokenizer
{
    [self.vessels removeAllObjects];
    [self.crew removeAllObjects];
    [self.global removeAllObjects];
    
    self.currentCrew = nil;
    self.currentVessel = nil;
    self.currentPart = nil;
}

- (BOOL)handleEmptyContent:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    return YES; // no further processing on empty lines or lines that are all comment
}

- (BOOL)handleNewContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    //NSLog(@"NewContext: %@",tokenizer.currentContext);
    
    if( [Crew keywordMatch:tokenizer.currentContext] ) {
        self.currentCrew = [[Crew alloc] init];
        return YES;
    }

    if( [Vessel keywordMatch:tokenizer.currentContext] ) {
        self.currentVessel = [[Vessel alloc] init];
        return YES;
    }

    if( [Orbit keywordMatch:tokenizer.currentContext] ) {
        self.currentVessel.orbit = [[Orbit alloc] init];
        return YES;
    }
    
    if( [VesselPart keywordMatch:tokenizer.currentContext] ) {
        self.currentPart =[[VesselPart alloc] init];
        return YES;
    }

    return NO;
}

- (BOOL)handleBeginContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    
    //NSLog(@"BeginContext: %@",tokenizer.currentContext);
    return YES;
}

- (BOOL)handleKeyValue:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{

    //NSLog(@"%@ keyValue: %@  - >  %@",tokenizer.currentContext,line.key,line.value);
    
    if( tokenizer.isGlobal ) {
        [self.global addEntriesFromDictionary:line.keyValue];
        return YES;
    }
    
    if( [Crew keywordMatch:tokenizer.currentContext] ) {
        [self.currentCrew setValue:line.value forKey:line.key];
        return YES;
    }
    
    if( [Vessel keywordMatch:tokenizer.currentContext] ) {
        [self.currentVessel setValue:line.value forKey:line.key];
        return YES;
    }
    
    if( [Orbit keywordMatch:tokenizer.currentContext] ) {
        [self.currentVessel.orbit setValue:line.value forKey:line.key];
        return YES;
    }
    
    if( [VesselPart keywordMatch:tokenizer.currentContext] ) {
        [self.currentPart setValue:line.value forKey:line.key];
        return YES;
    }
    
    return YES;
}

- (BOOL)handleEndContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    //NSLog(@"EndContext: %@",tokenizer.currentContext);
    
    if( [Crew keywordMatch:tokenizer.currentContext] ) {
        [self.crew addObject:self.currentCrew];
        self.currentCrew = nil;
        return YES;
    }
    
    if( [Vessel keywordMatch:tokenizer.currentContext] ) {
        [self.vessels addObject:self.currentVessel];
        self.currentVessel = nil;
        return YES;
    }
    
    if( [Orbit keywordMatch:tokenizer.currentContext] ) {
        return YES;
    }
    
    if( [VesselPart keywordMatch:tokenizer.currentContext] ) {
        [self.currentVessel.parts addObject:self.currentPart];
        self.currentPart = nil;
        return YES;
    }
    
    return NO;
}

- (BOOL)handleUnknownContent:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    NSLog(@"UnknownContent: line[%ld] %@",[tokenizer.lines indexOfObject:line],tokenizer.currentContext);
    
    return NO;
}



#pragma mark -
#pragma mark Overridden Properties


#pragma mark -
#pragma mark Instance Methods

- (BOOL)writeToURL:(NSURL *)url
{

    return NO;
}

#pragma mark -
#pragma mark Class Methods

@end
