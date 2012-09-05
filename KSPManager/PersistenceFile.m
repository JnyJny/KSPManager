//
//  Mission.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/5/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "PersistenceFile.h"
#import "Line.h"
#import "Crew.h"
#import "Vessel.h"

@implementation PersistenceFile

@synthesize url = _url;
@synthesize options = _options;
@synthesize crew = _crew;
@synthesize vessels = _vessels;

- (id)initWithURL:(NSURL *)url
{
    if ( self = [super init]) {
        _url = url;
        _lines = [NSMutableArray arrayWithArray:[Line linesFromURL:url]];
    }
    return self;
}

#pragma mark -
#pragma mark Properties

- (NSMutableDictionary *)options
{
    if( _options == nil ) {
        _options = [[NSMutableDictionary alloc] init];
    }
    return _options;
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

#define kBarewordInvalid @"INVALID"
#define kBarewordGlobal  @"GLOBAL"
#define kBarewordCrew    @"CREW"
#define kBarewordVessel  @"VESSEL"
#define kBarewordOrbit   @"ORBIT"
#define kBarewordPart    @"PART"

- (NSArray *)keywords
{
    return @[kBarewordInvalid,
                kBarewordGlobal,
                kBarewordCrew,
                kBarewordVessel,
                kBarewordOrbit,
                kBarewordPart];
}

- (void)parseLines
{

    Crew   *crew;
    Vessel *vessel;
    NSMutableDictionary *dict;
    int curState;
    int lastState;

    lastState = kWorkingOnInvalid;
    
    NSMutableArray *state = [[NSMutableArray alloc] init];

    [state addObject:[NSNumber numberWithInt:kWorkingOnInvalid]];
    
    curState = kWorkingOnGlobal;
    
    for(Line *line in _lines){
        NSLog(@"state %@ for %@",[[self keywords] objectAtIndex:curState],line);
        
        if ( line.isEmpty || !line.hasContent )
            continue ;
        
        if ( line.hasBareword ) {

            if( [line.bareword caseInsensitiveCompare:kBarewordCrew] == NSOrderedSame ){
                [state addObject:[NSNumber numberWithInt:curState]];
                curState = kWorkingOnCrew;
                continue;
            }
            
            if( [line.bareword caseInsensitiveCompare:kBarewordVessel] == NSOrderedSame ){
                [state addObject:[NSNumber numberWithInt:curState]];
                curState = kWorkingOnVessel;
                continue;
            }
            
            if( [line.bareword caseInsensitiveCompare:kBarewordOrbit] == NSOrderedSame ){
                [state addObject:[NSNumber numberWithInt:curState]];
                curState = kWorkingOnOrbit;
                continue;
            }
        
            if( [line.bareword caseInsensitiveCompare:kBarewordPart] == NSOrderedSame ){
                [state addObject:[NSNumber numberWithInt:curState]];
                curState = kWorkingOnPart;
                continue;
            }
            NSLog(@"Unknown bareword: %@",line.bareword);
            continue;
        }
        
        if ( line.hasDictBegin ) {
            dict = [[NSMutableDictionary alloc] init];
            
            switch(curState) {
                case kWorkingOnVessel:
                    vessel = [[Vessel alloc] initWithOptions:nil];
                    [self.vessels addObject:vessel];
                    break;
                default:
                    break;
            }
            
            continue;
        }
        
        if( line.hasDictEnd ) {
            
            switch(curState) {
                case kWorkingOnGlobal:
                    // whut?
                    break;
                case kWorkingOnCrew:
                    crew = [[Crew alloc] initWithOptions:dict];
                    [self.crew addObject:crew];
                    break;
                case kWorkingOnVessel:
                    vessel = nil; // retained in self.vessels
                    break;
                case kWorkingOnOrbit:
                    [vessel addOrbit:dict];
                    break;
                case kWorkingOnPart:
                    [vessel addPart:dict];
                    break;
                default:
                    break;
            }
            //            curState = [state pop];
            NSNumber *n = [state lastObject];
            curState = [n intValue];
            [state removeLastObject];
            continue;
        }
        
        if ( line.hasKeyValue ) {
            switch (curState) {
                case kWorkingOnGlobal:
                    [self.options setValue:line.value forKey:line.key];
                    break;
                default:
                    [dict setValue:line.value forKey:line.key];
                    break;
            }
            continue;
        }
        
        NSLog(@"unprocessed line: %@",line);
    }
}

#pragma mark -
#pragma mark Instance Methods

- (BOOL)writeToURL:(NSURL *)url
{
 
    return NO;
}

#pragma mark -
#pragma mark Class Methods

@end
