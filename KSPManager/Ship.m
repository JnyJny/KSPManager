//
//  Ship.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/10/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Ship.h"

@implementation Ship

@synthesize url = _url;
@synthesize isInSpacePlaneHanger = _isInSpacePlaneHanger;
@synthesize isInVehicleAssemblyBuilding = _isInVehicleAssemblyBuilding;

- (id)initWithURL:(NSURL *)url
{
    self = [super init];
    if (self) {
        self.url = url;
        NSStringEncoding encoding;
        
        NSArray *lines = [LineToken linesFromURL:self.url
                                    withEncoding:&encoding
                                     withOptions:@{ kLineOptionCommentTokenKey : @"//" }];
        
        _parser = [ConfigurationParser parserWithLineTokens:lines];
        
        _parser.delegate = self;
        [_parser beginParsing];
    }
    return self;
}

#pragma mark -
#pragma mark Properties


- (BOOL)isInVehicleAssemblyBuilding
{
    return [self.url.path rangeOfString:@"VAB"].location != NSNotFound;
}

- (BOOL)isInSpacePlaneHanger
{
    return [self.url.path rangeOfString:@"SPH"].location != NSNotFound;
}


#pragma mark -
#pragma mark Instance Methods

#pragma mark -
#pragma mark Class Methods

#pragma mark -
#pragma mark ConfigurationParserDelegate Methods

- (void)willBeginParsingWithConfiguration:(ConfigurationParser *)tokenizer
{
    NSLog(@"beginParsing %@",self.url.lastPathComponent);
}

- (BOOL)handleNewContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
#define kShipPartContext @"PART"

    if( [tokenizer.currentContext isEqualToString:kShipPartContext] ) {
        
        _currentPart = [[NSMutableDictionary alloc] init];
        
        return YES;
    }
    
    return NO;
}

- (BOOL)handleBeginContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    
    return NO;
}

- (BOOL)handleKeyValue:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    if( tokenizer.isGlobal ) {
        [self setValue:line.value forKey:line.key];
        return YES;
    }
    
    if( [tokenizer.currentContext isEqualToString:kShipPartContext] ) {
        [_currentPart setValue:line.value forKey:line.key];
        return YES;
    }
    
    
    return NO;
}

- (BOOL)handleEndContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    if( [tokenizer.currentContext isEqualToString:kShipPartContext] ) {
        [self.parts addObject:_currentPart];
        _currentPart = nil;
    }
    
    return NO;
}

- (BOOL)handleUnknownContent:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    
    NSLog(@"unknownContent: %@ %@",tokenizer.currentContext,line);
    
    return YES;
}

- (void)willEndParsingWithConfiguration:(ConfigurationParser *)tokenizer
{
    NSLog(@"endParsing %@",self.url.lastPathComponent);
}

@end
