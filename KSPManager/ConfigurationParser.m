//
//  ConfigurationParser.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/9/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "ConfigurationParser.h"

@interface ConfigurationParser ()

@property (strong, nonatomic, readwrite) NSString *lastContext;
@property (strong, nonatomic, readwrite) NSString *currentContext;


@end

@implementation NSMutableArray (LIFOCategory)

- (id)push:(id)object
{
    [self addObject:object];
    return object;
}

- (id)pop
{
    id object = [self top];
    if( object )
        [self removeLastObject];
    return object;
}

- (id)top
{
    return [self lastObject];
}

@end

@implementation ConfigurationParser

@synthesize delegate = _delegate;
@synthesize lines = _lines;
@synthesize context = _context;
@synthesize isGlobal;
@synthesize lastContext = _lastContext;
@synthesize currentContext = _currentContext;
@synthesize encoding = _encoding;
@synthesize globalContextId = _globalContextId;


+ (id)parserWithURL:(NSURL *)url
{
    NSStringEncoding encoding;
    
    ConfigurationParser *parser = [ConfigurationParser parserWithLineTokens:[LineToken linesFromURL:url withEncoding:&encoding]];
    
    parser.encoding = encoding;
    
    return parser;
}

+ (id)parserWithLineTokens:(NSArray *)lines
{
    return [[ConfigurationParser alloc] initWithLineTokens:lines];
}


- (id)initWithLineTokens:(NSArray *)lines;
{
    if( self = [super init] ){
        _lines = [NSMutableArray arrayWithArray:lines];
    }
    return self;
}

#pragma mark -
#pragma mark Private Methods

- (BOOL)informDelegateOfLine:(LineToken *)line usingSelector:(SEL)selector
{
    BOOL result = YES;
    
    if( [self.delegate respondsToSelector:selector] ){
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
       result = (BOOL)[self.delegate performSelector:selector
                                          withObject:line
                                          withObject:self];
#pragma clang diagnostic pop
    }
    
    return result;
}

#pragma mark -
#pragma mark Properties


#define kGlobalContextId @"GlobalContext"

- (NSMutableArray *)context
{
    if( _context == nil ) {
        _context = [[NSMutableArray alloc] init];
        [_context push:self.globalContextId];
    }
    return _context;
}

- (NSString *)currentContext
{
    id o = [self.context top];
    
    if ( o == nil ) {
        [self.context push:self.globalContextId];
        return [self.context top];
    }

    return o;
}

- (NSString *)globalContextId
{
    if( _globalContextId == nil ) {
        _globalContextId = kGlobalContextId;
    }
    return _globalContextId;
}

- (BOOL)isGlobal
{
    return [self.globalContextId isEqualToString:self.currentContext];
}


#pragma mark -
#pragma mark Instance Methods

- (BOOL)currentContextMatches:(NSString *)contextName
{
    return [self.currentContext isEqualToString:contextName];
}

- (BOOL)writeToURL:(NSURL *)url
{
    return NO;
}

- (BOOL)beginParsing
{
    return [self beginParsingLines:self.lines];
}

- (BOOL)beginParsingLines:(NSArray *)lines
{
    [self.context removeAllObjects];

    if( [self.delegate respondsToSelector:@selector(willBeginParsingWithConfiguration:)] )
        [self.delegate performSelector:@selector(willBeginParsingWithConfiguration:) withObject:self];
    
    for(LineToken *line in lines) {
        
        if( line.isEmpty || (line.hasContent == NO) ) {
            if( YES == [self informDelegateOfLine:line
                                    usingSelector:@selector(handleEmptyContent:inConfiguration:)] )
                continue;
        }
        
        if( line.hasComment ) {
            if( YES == [self informDelegateOfLine:line
                                    usingSelector:@selector(handleComment:inConfiguration:)] )
                continue;
        }
        
        if( line.hasKeyword ) {
            self.lastContext = self.currentContext;
            [self.context push:line.keyword];
            
            if( YES == [self informDelegateOfLine:line
                                    usingSelector:@selector(handleNewContext:inConfiguration:)] )
                continue;
        }
        
        if( line.hasDictBegin ) {
            if( YES == [self informDelegateOfLine:line
                                    usingSelector:@selector(handleBeginContext:inConfiguration:)])
             continue;
        }
        
        if( line.hasDictEnd ) {
            if( YES == [self informDelegateOfLine:line
                                    usingSelector:@selector(handleEndContext:inConfiguration:)]) {
                self.lastContext = self.currentContext;
                [self.context pop];
                continue;
            }
        }
        
        if( line.hasKeyValue ) {
            if( YES == [self informDelegateOfLine:line
                                    usingSelector:@selector(handleKeyValue:inConfiguration:)]);
                continue;
        }
        
        if( YES == [self informDelegateOfLine:line
                                usingSelector:@selector(handleUnknownContent:inConfiguration:)] ) {
            NSLog(@"delegate %@ : %@ barfed on line # %lu %@",
                  self.currentContext,
                  self.delegate.class,
                  [self.lines indexOfObject:line],line);
            break;
        }
    }
    
    if( [self.delegate respondsToSelector:@selector(willEndParsingWithConfiguration:)] )
        [self.delegate performSelector:@selector(willEndParsingWithConfiguration:) withObject:self];


    return YES;
}



@end
