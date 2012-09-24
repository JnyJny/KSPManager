//
//  Part.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/15/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Part.h"

@interface Part () {
    NSMutableDictionary *_curCtx;
}

@end

@implementation Part

@synthesize partDirectoryName = _partDirectoryName;
@synthesize configurationURL = _configurationURL;
@synthesize detail = _detail;
@synthesize categoryName = _categoryName;


- (id)initWithURL:(NSURL *)configurationFileURL
{
    
    if( self = [super initWithURL:[configurationFileURL URLByDeletingLastPathComponent]] ) {
        
        if( [configurationFileURL checkResourceIsReachableAndReturnError:nil]   == NO )
            return nil;
        
        self.configurationURL = configurationFileURL;

        NSStringEncoding encoding;
        
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
    
    self.baseURL = [_configurationURL URLByDeletingLastPathComponent];
}



- (NSString *)detail
{
    if( _detail == nil ) {
        _detail = @"";
        
        for(NSDictionary *ctx in [self.contexts arrayByAddingObject:self.global] ) {
         
            for(NSString *key in [ctx.allKeys sortedArrayUsingSelector:@selector(localizedCompare:)]) {
                
                if( [key isEqualToString:@"ContextName"] )
                    continue;
                
                NSString *prefix = @"";
                
                if( ctx != self.global )
                    prefix = [NSString stringWithFormat:@"%@.",[ctx valueForKey:@"ContextName"]];
                
                _detail = [_detail stringByAppendingFormat:@"\t%@%@ -> %@\n",prefix,key,[ctx valueForKey:key]];

            }
            
        }

    }
    return _detail;
}

- (NSString *)categoryName
{

    NSString *val = [self valueForKey:kPartKeyCategory];
    
    if( val.integerValue >= [Part categoryNames].count)
        return [@"Unknown: " stringByAppendingString:val];

    return [[Part categoryNames] objectAtIndex:val.integerValue];
}


#pragma mark -
#pragma mark Asset Overridden Properties

- (BOOL)isInstalled
{
    return [self.baseURL.path rangeOfString:kKSPManagedParts].location == NSNotFound;
}

- (BOOL)isAvailable
{
    return [self.baseURL.path rangeOfString:kKSPManagedParts].location != NSNotFound;
}

- (NSString *)assetTitle
{
    NSString *title =  [self valueForKey:kPartKeyTitle];
    
    if( title == nil )
        title = [self valueForKey:kPartKeyName];
    
    if( title == nil )
        title = self.baseURL.lastPathComponent;
    
    return title;
}

- (NSString *)assetCategory
{
    return self.categoryName;
}



#pragma mark -
#pragma mark Instance Methods

- (BOOL)moveTo:(NSURL *)destinationDirURL
{

    
    NSURL *targetURL = [destinationDirURL URLByAppendingPathComponent:self.partDirectoryName isDirectory:YES];
    
    NSError *error = nil;
    
    [self.fileManager moveItemAtURL:self.baseURL toURL:targetURL error:&error];
    
    if( error ){
        self.error = error;
        return NO;
    }
    
    self.baseURL = targetURL;
    self.error = nil;

    return YES;
}

- (BOOL)copyTo:(NSURL *)destinationDirURL
{
    
    NSURL *targetURL = [destinationDirURL URLByAppendingPathComponent:self.partDirectoryName isDirectory:YES];
    
    NSError *error = nil;
    
    [self.fileManager copyItemAtURL:self.baseURL toURL:targetURL error:&error];
    
    if( error ) {
        self.error = error;
        return NO;
    }
    
    self.baseURL = targetURL;
    
    self.error = nil;
    
    return YES;
    
}

- (BOOL)remove
{
    NSError *error = nil;
    
    [self.fileManager removeItemAtURL:self.baseURL error:&error];
    
    self.error = error;
    
    if( error )
        return NO;
    
    return YES;
}

- (BOOL)rename:(NSURL *)newName
{
    NSLog(@"part rename unimplimented");
    return NO;
}


#pragma mark -
#pragma mark ConfigurationParserDelegate

#if 0
- (void)willBeginParsingWithConfiguration:(ConfigurationParser *)tokenizer
{
    NSLog(@"beginParse %ld lines for %@",tokenizer.lines.count,self.configurationURL.lastPathComponent);
}
#endif

- (BOOL)handleNewContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    
    if( !tokenizer.isGlobal ) {
        _curCtx = [[NSMutableDictionary alloc] initWithDictionary:@{ @"ContextName" : tokenizer.currentContext }];
        return YES;
    }
    
    return NO;
}

- (BOOL)handleBeginContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    return YES;
}

- (BOOL)handleEndContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    if( !tokenizer.isGlobal ) {
        if( _curCtx)
            [self.contexts addObject:_curCtx];
        _curCtx = nil;
        return YES;
    }
    
    return NO;
}


- (BOOL)handleKeyValue:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{

    if( tokenizer.isGlobal ) {
        [self addEntriesFromDictionary:line.keyValue];
        return YES;
    }
    
    [_curCtx addEntriesFromDictionary:line.keyValue];

    return YES;
}


- (BOOL)handleUnknownContent:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    NSLog(@"UnknownContent:%@ %@ %@",self.baseURL.lastPathComponent, tokenizer.currentContext,line);
    return NO;
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
        Part *part = [[Part alloc]initWithURL:[baseURL URLByAppendingPathComponent:cfgPath]];
        if( part ) {
            NSLog(@"inventory part %@",part.baseURL);
            [results addObject:part];
        }
    }

    return results;
}



+ (NSArray *)categoryNames
{
    return @[kPART_PROPULSION,kPART_COMMAND,kPART_STRUCTURAL,kPART_UTILITY,kPART_DECAL,kPART_CREW];
}

@end
