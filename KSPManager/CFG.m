//
//  CFG.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/26/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "CFG.h"


@interface CFG ()

@property (strong, nonatomic, readwrite) CFGPart *part;
@property (strong, nonatomic, readwrite) CFGProp *prop;
@property (strong, nonatomic, readwrite) CFGSpace *space;

@end

@implementation CFG

@synthesize part = _part;
@synthesize prop = _prop;
@synthesize space = _space;

- (CFGPart *)part
{
    if( _part == nil ) {
        _part = [[CFGPart alloc] init];
    }
    return _part;
}

- (CFGProp *)prop
{
    if( _prop == nil ) {
        _prop = [[CFGProp alloc] init];
    }
    return _prop;
}

- (CFGSpace *)space
{
    if( _space == nil ) {
        _space = [[CFGSpace alloc] init];
    }
    return _space;
}


+ (CFGPart *)partForContentsOfURL:(NSURL *)url
{
    CFG *cfg = [[CFG alloc] initWithContentsOfURL:url];
    
    return cfg.part;
}

+ (CFGProp *)propForContentsOfURL:(NSURL *)url
{
    CFG *cfg = [[CFG alloc] initWithContentsOfURL:url];
    
    return  cfg.prop;
}


+ (CFGSpace *)spaceForContentsOfURL:(NSURL *)url
{
    CFG *cfg = [[CFG alloc] initWithContentsOfURL:url];

    return  cfg.space;
}

#pragma mark -
#pragma mark ConfigurationParserDelegate Methods



- (BOOL)handleNewContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{

    return NO;
}

- (BOOL)handleBeginContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    return NO;
}

- (BOOL)handleKeyValue:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    return NO;
}

- (BOOL)handleEndContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
 
    return NO;
}



@end
