//
//  PartCFG.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/27/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "PartCFG.h"
#import "CFGModule.h"

@interface PartCFG () {
    NSMutableDictionary *_options;
}
@property (strong, nonatomic, readwrite) CFGPart *part;
@end


@implementation PartCFG

@synthesize part = _part;

#pragma mark -
#pragma mark LifeCycle

#pragma mark -
#pragma mark Properties

- (CFGPart *)part
{
    if( _part == nil ) {
        _part = [[CFGPart alloc] init];
    }
    return _part;
}

#pragma mark -
#pragma mark Instance Methods

#pragma mark -
#pragma mark ConfigurationTokenizerDelegate Methods

- (BOOL)handleNewContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    if( [CFGModule keywordMatch:tokenizer.currentContext] ) {
        _options = [[NSMutableDictionary alloc] init];
        return YES;
    }
    
    if( tokenizer.isGlobal )
        return YES;
    
    return NO;
}

- (BOOL)handleBeginContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    return YES;
}

- (BOOL)handleKeyValue:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    if( [CFGModule keywordMatch:tokenizer.currentContext] ) {
        [_options addEntriesFromDictionary:line.keyValue];
        return YES;
    }
    
    if( tokenizer.isGlobal ) {
        [self.part addEntriesFromDictionary:line.keyValue];
        return YES;
    }
    
    return NO;
}

- (BOOL)handleEndContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    
    if( [CFGModule keywordMatch:tokenizer.currentContext] ) {
        [self.part addModuleWithOptions:_options];
        return YES;
    }
 
    return NO;
}

- (BOOL)handleUnknownContent:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    // might be a comment or something, ignore it and hope for the best
    return YES;
}


#pragma mark -
#pragma mark Class Methods

+ (CFGPart *)partForContentsOfURL:(NSURL *)url
{
    PartCFG *cfg = [[PartCFG alloc] initWithContentsOfURL:url];
    cfg.parser.delegate = cfg;
    [cfg.parser beginParsing];
    
    return cfg.part;
}
@end
