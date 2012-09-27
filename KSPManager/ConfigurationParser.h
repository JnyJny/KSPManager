//
//  ConfigurationParser.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/9/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ConfigurationTokenizerDelegate.h"
#import "LineToken.h"

@interface ConfigurationParser : NSObject

@property (strong, nonatomic) id<ConfigurationParserDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *lines;

@property (strong, nonatomic, readonly) NSMutableArray *context;
@property (strong, nonatomic, readonly) NSString *lastContext;
@property (strong, nonatomic, readonly) NSString *currentContext;
@property (assign, nonatomic) NSStringEncoding encoding;
@property (strong, nonatomic) NSString *globalContextId;
@property (assign, nonatomic,readonly) BOOL isGlobal;



+ (id)parserWithURL:(NSURL *)url;
+ (id)parserWithLineTokens:(NSArray *)lines;

- (id)initWithLineTokens:(NSArray *)lines;

- (BOOL)currentContextMatches:(NSString *)contextName;

- (BOOL)writeToURL:(NSURL *)url;

- (BOOL)beginParsing;

@end
