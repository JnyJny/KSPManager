//
//  Ship.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/10/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Ship.h"

@implementation Ship

@synthesize isInSpacePlaneHanger = _isInSpacePlaneHanger;
@synthesize isInVehicleAssemblyBuilding = _isInVehicleAssemblyBuilding;

- (id)initWithURL:(NSURL *)url
{
    if ( self = [super initWithURL:url] ) {
        
        NSStringEncoding encoding;
        
        NSArray *lines = [LineToken linesFromURL:self.baseURL
                                    withEncoding:&encoding
                                     withOptions:@{ kLineOptionCommentTokenKey : @"//" }];
        
        _parser = [ConfigurationParser parserWithLineTokens:lines];
        
        _parser.delegate = self;
        [_parser beginParsing];
    }
    return self;
}


#pragma mark -
#pragma mark Overriden Properties

#define kShipKeyShipName @"ship"
#define kShipFilenameAutoSaved @"Auto-Saved Ship"

- (NSString *)assetTitle
{
    if( [self.baseURL.lastPathComponent rangeOfString:kShipFilenameAutoSaved].location != NSNotFound    )
        return [NSString stringWithFormat:@"Auto-Saved %@",[self valueForKey:kShipKeyShipName]];
    
    return [self valueForKey:kShipKeyShipName];
}

- (NSString *)assetCategory
{
    return self.isInSpacePlaneHanger?@"SPH":@"VAB";
}

- (BOOL)isInstalled
{
    return [self.baseURL.path rangeOfString:kKSP_MODS_SHIPS].location == NSNotFound;
}

- (BOOL)isAvailable
{
    return [self.baseURL.path rangeOfString:kKSP_MODS_SHIPS].location != NSNotFound;
}

#pragma mark -
#pragma mark Properties

- (BOOL)isInVehicleAssemblyBuilding
{
    return [self.baseURL.path rangeOfString:@"VAB"].location != NSNotFound;
}

- (BOOL)isInSpacePlaneHanger
{
    return [self.baseURL.path rangeOfString:@"SPH"].location != NSNotFound;
}

- (NSString *)description
{
    return [self.baseURL.path stringByAppendingFormat:@": %@, %@",self.assetTitle,self.assetCategory];
}

#pragma mark -
#pragma mark Instance Methods

- (BOOL)moveTo:(NSURL *)destinationDirURL
{
    
    return NO;
}

- (BOOL)copyTo:(NSURL *)destinationDirURL
{
    
    return NO;
}

- (BOOL)remove
{
    
    return NO;
}

- (BOOL)rename:(NSURL *)newName
{
    NSLog(@"ship rename unimplimented");
    return NO;
}

#pragma mark -
#pragma mark Class Methods

#pragma mark -
#pragma mark ConfigurationParserDelegate Methods

- (void)willBeginParsingWithConfiguration:(ConfigurationParser *)tokenizer
{
    NSLog(@"beginParsing %@",self.baseURL);
}

- (BOOL)handleNewContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
#define kShipPartContext @"PART"

    if( [tokenizer.currentContext isEqualToString:kShipPartContext] ) {
        
        _currentPart = [[NSMutableDictionary alloc] init];
        
        return YES;
    }
    
    return NO;
}

- (BOOL)handleBeginContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    
    return NO;
}

- (BOOL)handleKeyValue:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    if( tokenizer.isGlobal ) {
        [self setValue:line.value forKey:line.key];
        return YES;
    }
    
    if( [tokenizer.currentContext isEqualToString:kShipPartContext] ) {
        [_currentPart setValue:line.value forKey:line.key];
        return YES;
    }
    
    
    return NO;
}

- (BOOL)handleEndContext:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    if( [tokenizer.currentContext isEqualToString:kShipPartContext] ) {
        [self.parts addObject:_currentPart];
        _currentPart = nil;
    }
    
    return NO;
}

- (BOOL)handleUnknownContent:(LineToken *)line inConfiguration:(ConfigurationParser *)tokenizer
{
    
    NSLog(@"unknownContent: %@ %@",tokenizer.currentContext,line);
    
    return YES;
}

- (void)willEndParsingWithConfiguration:(ConfigurationParser *)tokenizer
{
    NSLog(@"endParsing %@",self.baseURL.lastPathComponent);
}

#pragma mark -
#pragma mark Class methods



+ (NSArray *)inventory:(NSURL *)baseUrl
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    NSArray *paths = [self assetSearch:baseUrl usingBlock:^BOOL(NSString *path) {
        return [path.pathExtension caseInsensitiveCompare:kCRAFT_EXT] == NSOrderedSame;
    }];
    
    for(NSString *path in paths) {
        Ship *ship = [[Ship alloc] initWithURL:[baseUrl URLByAppendingPathComponent:path isDirectory:NO]];
        if( ship )
            [results addObject:ship];
    }
    
    return results;
}

@end
