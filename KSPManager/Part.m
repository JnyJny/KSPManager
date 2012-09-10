//
//  Part.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/15/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Part.h"

@implementation Part

@synthesize partDirectoryName = _partDirectoryName;
@synthesize configurationURL = _configurationURL;

@synthesize detail = _detail;
@synthesize module = _module;
@synthesize desc = _desc;
@synthesize categoryName = _categoryName;



- (id)initWithConfigurationFileURL:(NSURL *)cfgURL
{
    if( [cfgURL checkResourceIsReachableAndReturnError:nil] == NO )
        return nil;
    
    if( self = [super initWithURL:[cfgURL URLByDeletingLastPathComponent]] ) {
         self.configurationURL = cfgURL;
        NSStringEncoding encoding;
        
        _globalContext = [[NSMutableDictionary alloc] init];
        
        NSArray *lines = [LineToken linesFromURL:self.configurationURL
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

- (NSString *)partDirectoryName
{
    if( _partDirectoryName == nil ){
        _partDirectoryName = [self.baseURL lastPathComponent];
    }
    return _partDirectoryName;
}


- (void)setConfigurationURL:(NSURL *)configurationURL
{
    if( _configurationURL == configurationURL )
        return ;
    
    _configurationURL = configurationURL;
}

 
- (NSString *)detail
{
    if( _detail == nil ) {
        _detail = [NSString stringWithFormat:@"\n%@\n\n",[self valueForKey:kPartKeyName]];

        for(NSString *key in _globalContext.allKeys ) {
            id value = [_globalContext valueForKey:key];
            _detail = [_detail stringByAppendingFormat:@"\t%@ -> %@\n",key,value];
        }
        
    }
    return _detail;
}

#pragma mark -
#pragma mark Overriden Properties

- (BOOL)isInstalled
{
    NSRange range =[self.baseURL.path rangeOfString:kKSP_MODS];
    
    // if currentURL.path doesn't contain kKSP_MODS, installed == YES
    
    return (range.location == NSNotFound);
}


#pragma mark -
#pragma mark Instance Methods


- (BOOL)movePartTo:(NSURL *)destinationDirectoryURL
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSURL *targetURL = [destinationDirectoryURL URLByAppendingPathComponent:self.partDirectoryName isDirectory:YES];
    
    NSError *error = nil;
    
    [fileManager moveItemAtURL:self.baseURL toURL:targetURL error:&error];
    
    if( error ){
        self.error = error;
        return NO;
    }
    
    self.baseURL = targetURL;

    self.error = nil;
    
    return YES;
}

- (BOOL)copyPartTo:(NSURL *)destinationDirectoryURL
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSURL *targetURL = [destinationDirectoryURL URLByAppendingPathComponent:self.partDirectoryName isDirectory:YES];
    
    NSError *error = nil;
    
    [fileManager copyItemAtURL:self.baseURL toURL:targetURL error:&error];
    
    if( error ) {
        self.error = error;
        return NO;
    }
    
    self.baseURL = targetURL;
    
    self.error = nil;

    return YES;
}

- (void)addEntriesFromDictionary:(NSDictionary *)newEntries
{
    [_globalContext addEntriesFromDictionary:newEntries];
}

#pragma mark -
#pragma mark Overridden Methods

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    [_globalContext setValue:value forUndefinedKey:key];
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return [_globalContext valueForKey:key];
}

#pragma mark -
#pragma mark ConfigurationParserDelegate

- (void)willBeginParsingWithConfiguration:(ConfigurationParser *)tokenizer
{
    NSLog(@"beginParse %ld lines for %@",tokenizer.lines.count,self.configurationURL.lastPathComponent);
}

- (BOOL)handleNewContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    
    if( tokenizer.isGlobal ) {
    
        return YES;
    }
    
 
    return NO;
}

- (BOOL)handleBeginContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    NSLog(@"handleBeginContext: %@",tokenizer.currentContext);
    return NO;
}


- (BOOL)handleKeyValue:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    NSLog(@"handleKeyValue: %@  %@ -> %@",tokenizer.currentContext,line.key,line.value);
    
    if( tokenizer.isGlobal ) {
        [self addEntriesFromDictionary:line.keyValue];
        return YES;
    }
    return NO;
}

- (BOOL)handleEndContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    NSLog(@"endContext: %@",tokenizer.currentContext);
        
    return NO;
}

- (BOOL)handleUnknownContent:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    NSLog(@"UnknownContent: %@ %@",tokenizer.currentContext,line.content);
    
    return NO;
}

- (void)willEndParsingWithConfiguration:(ConfigurationParser *)tokenizer
{
    NSLog(@"endParsing %@",self.configurationURL.lastPathComponent);
}


#pragma mark -
#pragma mark Class Methods


+ (NSArray *)inventory:(NSURL *)baseURL
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    NSArray *partCfgPaths = [self assetSearch:baseURL usingBlock:^BOOL(NSString *path) {
        return [[path lastPathComponent] isEqualToString:kPART_CONFIG];
    }];

    for(NSString *cfgPath in partCfgPaths){
        Part *part = [[Part alloc]initWithConfigurationFileURL:[baseURL URLByAppendingPathComponent:cfgPath]];
        if( part )
            [results addObject:part];
    }
    
    return results;
}



+ (NSArray *)categoryNames
{
    return @[kPART_PROPULSION,kPART_COMMAND,kPART_STRUCTURAL,kPART_UTILITY,kPART_DECAL,kPART_CREW];
}

@end
