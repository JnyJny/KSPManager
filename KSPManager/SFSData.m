//
//  SFSData.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/23/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "SFSData.h"

// sfs files are used for:
//
// persitent.sfs
// autosaves.sfs
// training_description.sfs
// scenario_description.sfs

@interface SFSData () {
    ConfigurationParser *_parser;
    NSMutableDictionary *_dict;
    
    NSMutableDictionary *_game;
    NSMutableDictionary *_parameters;
    NSMutableDictionary *_flightstate;
}
@end

@implementation SFSData

#pragma mark -
#pragma mark LifeCycle

- (id)initWithContentsOfURL:(NSURL *)sfsSource
{
    if( self = [super init] ) {
 
        _parser = [ConfigurationParser parserWithURL:sfsSource];
        if( _parser == nil ) {
            // error?
            return nil;
        }
        
        _dict = [[NSMutableDictionary alloc] init];
        
        self.baseURL = sfsSource;
        
    }
    return self;
}

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Instance Methods

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    [_dict setValue:value forKey:key];
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return [_dict valueForKey:key];
}

- (void)addEntriesFromDictionary:(NSDictionary *)dict
{
    [_dict addEntriesFromDictionary:dict];
}

#pragma mark -
#pragma mark ConfigrationParserDelegate Methods

- (void)willBeginParsingWithConfiguration:(ConfigurationParser *)tokenizer
{
    NSLog(@"begin: %@",self.baseURL.lastPathComponent);
}

- (void)didEndParsingWithConfiguration:(ConfigurationParser *)tokenizer
{
    NSLog(@"end: %@",self.baseURL.lastPathComponent);
}

- (BOOL)handleNewContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    return YES;
}

- (BOOL)handleBeginContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    return YES;
}

- (BOOL)handleKeyValue:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    
    return YES;
}

- (BOOL)handleEndContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    return YES;
}

- (BOOL)handleComment:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    return YES;
}

- (BOOL)handleUnknownContent:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    return NO;
}


#pragma mark -
#pragma mark Class Methods

#pragma mark -
#pragma mark

@end
