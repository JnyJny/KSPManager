//
//  CFG.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/26/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "CFG.h"
#import "KSP_Constants.h"



@interface CFG ()
@property (strong, nonatomic, readwrite)ConfigurationParser *parser;
@end

@implementation CFG

@synthesize parser = _parser;


- (ConfigurationParser *)parser
{
    if( _parser == nil ) {
        NSStringEncoding encoding;
        
        NSArray *lines = [LineToken linesFromURL:self.url
                                    withEncoding:&encoding
                                     withOptions:@{ kLineOptionCommentTokenKey : @"//" }];
        
        _parser = [ConfigurationParser parserWithLineTokens:lines];
    }
    return _parser;
}

@end
