//
//  BaseConfigurationFile.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/26/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "BaseConfigurationFile.h"

@interface BaseConfigurationFile ()

@property (strong, nonatomic, readwrite) NSURL *url;

@end

@implementation BaseConfigurationFile

@synthesize url = _url;
@synthesize parser = _parser;

- (id)initWithContentsOfURL:(NSURL *)url
{
    if( self = [super init] ) {
        self.url = url;
        self.parser.delegate = self;
    }
    return self;
}

- (ConfigurationParser *)parser
{
    if( _parser == nil ) {
        _parser = [ConfigurationParser parserWithURL:self.url];
    }
    return _parser;
}

- (void)willBeginParsingWithConfiguration:(ConfigurationParser *)tokenizer
{
    NSLog(@"%@ willBeginParsing %@",self.className,self.url);
}

- (void)didEndParsingWithConfiguration:(ConfigurationParser *)tokenizer
{
    NSLog(@"%@ didEndParsing %@",self.className,self.url);
}

- (BOOL)handleComment:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    return YES;
}

- (BOOL)handleEmptyContent:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    return YES;
}

- (BOOL)handleUnknownContent:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    NSLog(@"%@ context %@ unknown content %@",self.className,tokenizer.currentContext,line);
    return NO;
}


@end
