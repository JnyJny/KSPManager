//
//  ConfigurationParserDelegate.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/9/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LineToken;
@class ConfigurationParser;

@protocol ConfigurationParserDelegate <NSObject>

@optional

- (void)willBeginParsingWithConfiguration:(ConfigurationParser *)tokenizer;

// Handlers return YES if they are consuming the line, halting further processing of the line
// and continuing on to the next line.  Returning NO causes the scanner to keep testing the
// the current line for various conditions.

- (BOOL)handleEmptyContent:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer;

- (BOOL)handleContent:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer;

- (BOOL)handleComment:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer;

- (BOOL)handleKeyValue:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer;

- (BOOL)handleNewContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer;

- (BOOL)handleBeginContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer;

- (BOOL)handleEndContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer;

- (BOOL)handleUnknownContent:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer;

- (void)willEndParsingWithConfiguration:(ConfigurationParser *)tokenizer;

@end
