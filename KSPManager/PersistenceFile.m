//
//  Mission.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/5/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "PersistenceFile.h"
#import "PersistentObject.h"
#import "Line.h"
#import "Crew.h"
#import "Vessel.h"
#import "Orbit.h"
#import "VesselPart.h"

@implementation PersistenceFile

@synthesize url = _url;
@synthesize global = _global;
@synthesize crew = _crew;
@synthesize vessels = _vessels;
@synthesize encoding = _encoding;

- (id)initWithURL:(NSURL *)url
{
    if ( self = [super init]) {
        _url = url;

        _lines = [NSMutableArray arrayWithArray:[Line linesFromURL:url withEncoding:&_encoding]];
        
        [self parseLines];
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
#pragma mark Overridden Properties

- (NSString *)description
{
    return _lines.description;
}

#pragma mark -
#pragma mark Implemenation Private Instance Methods

#define kWorkingOnInvalid 0
#define kWorkingOnGlobal  1
#define kWorkingOnCrew    2
#define kWorkingOnVessel  3
#define kWorkingOnOrbit   4
#define kWorkingOnPart    5


- (void)parseLines
{
    PersistentObject *parent = nil;
    PersistentObject *child = nil;
    
    int curState;
    int lastState;

    lastState = kWorkingOnInvalid;
    
    NSMutableArray *state = [[NSMutableArray alloc] init];

    [state addObject:[NSNumber numberWithInt:kWorkingOnInvalid]];
    
    curState = kWorkingOnGlobal;
    
    parent = nil;
    
    for(Line *line in _lines){
        //NSLog(@"line = %@",line);
              
              
        if ( line.isEmpty || !line.hasContent )
            continue ;
        
        if ( line.hasKeyword ) {

            if( [Crew keywordMatch:line.keyword] ) {
                [state addObject:[NSNumber numberWithInt:curState]];
                curState = kWorkingOnCrew;
                parent = [[Crew alloc] init];
                continue;
            }
            
            if( [Vessel keywordMatch:line.keyword] ) {
                [state addObject:[NSNumber numberWithInt:curState]];
                curState = kWorkingOnVessel;
                parent = [[Vessel alloc] init];
                continue;
            }
            
            if( [Orbit keywordMatch:line.keyword] ) {
                [state addObject:[NSNumber numberWithInt:curState]];
                curState = kWorkingOnOrbit;
                child = [[Orbit alloc] init];
                continue;
            }
        
            if( [VesselPart keywordMatch:line.keyword] ) {
                [state addObject:[NSNumber numberWithInt:curState]];
                curState = kWorkingOnPart;
                child = [[VesselPart alloc] init];
                continue;
            }
            NSLog(@"Unknown keyword: %@",line.keyword);
            continue;
        }
        
        if ( line.hasDictBegin ) {
            continue;
        }
        
        if( line.hasDictEnd ) {
            
            switch(curState) {
                case kWorkingOnGlobal:
                    // whut?
                    break;
                case kWorkingOnCrew:
                    [self.crew addObject:parent];
                    parent = nil;
                    break;
                case kWorkingOnVessel:
                    [self.vessels addObject:parent];
                    parent = nil;
                    break;
                case kWorkingOnOrbit:
                    ((Vessel *)parent).orbit = (Orbit *)child;
                    child = nil;
                    break;
                    
                case kWorkingOnPart:
                    [((Vessel *)parent).parts addObject:child];
                    child = nil;
                    break;
                default:
                    break;
            }

            NSNumber *n = [state lastObject];
            curState = [n intValue];
            [state removeLastObject];
            continue;
        }
        
        if ( line.hasKeyValue ) {
            
            switch(curState) {
                case kWorkingOnGlobal:
                    [self.global addEntriesFromDictionary:line.keyValue];
                    break;
                case kWorkingOnCrew:
                case kWorkingOnVessel:
                    [parent setValue:line.value forKey:line.key];
                    break;
                case kWorkingOnOrbit:
                case kWorkingOnPart:
                    [child setValue:line.value forKey:line.key];
                    break;
            }
            
            continue;
        }
        
        //NSLog(@"unprocessed line: %@",line);
    }
}

#pragma mark -
#pragma mark Instance Methods

- (BOOL)writeToURL:(NSURL *)url
{
    NSError *error = nil;
    NSString *newContents = @"";
    
    for(Crew *crew in self.crew)
        newContents = [newContents stringByAppendingString:crew.description];
    
    for(Vessel *vessel in self.vessels)
        newContents = [newContents stringByAppendingString:vessel.description];
    
    [newContents writeToURL:url atomically:YES encoding:self.encoding error:&error];
    
    // write lines to url
    
    return NO;
}

#pragma mark -
#pragma mark Class Methods

@end
