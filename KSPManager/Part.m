//
//  Part.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/15/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Part.h"
#import "PartCFG.h"

@interface Part ()
@property (strong, nonatomic) CFGPart *cfgPart;
@property (strong, nonatomic,readwrite)  NSURL  *configurationURL;
@property (strong, nonatomic,readwrite)  NSString  *categoryName;

@end

@implementation Part

@synthesize cfgPart = _cfgPart;
@synthesize configurationURL = _configurationURL;
@synthesize categoryName = _categoryName;

- (id)initWithURL:(NSURL *)configurationFileURL
{
    return [super initWithURL:[configurationFileURL URLByDeletingLastPathComponent]];
}

#pragma mark -
#pragma mark Properties

- (CFGPart *)cfgPart
{
    if( _cfgPart == nil ) {
        _cfgPart = [PartCFG partForContentsOfURL:self.configurationURL];
    }
    return _cfgPart;
}

- (NSURL *)configurationURL
{
    if( _configurationURL == nil ) {
        _configurationURL = [self.url URLByAppendingPathComponent:kPART_CONFIG];
    }
    return _configurationURL;
}

- (NSString *)categoryName
{

    NSString *val = [self valueForKey:kPartKeyCategory];
    
    if( val.integerValue >= [Part categoryNames].count)
        return [@"Unknown: " stringByAppendingString:val];

    return [[Part categoryNames] objectAtIndex:val.integerValue];
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return [self.cfgPart valueForKey:key];
}


#pragma mark -
#pragma mark Asset Overridden Properties

- (BOOL)isInstalled
{
    return [self.url.path rangeOfString:kKSPManagedParts].location == NSNotFound;
}

- (BOOL)isAvailable
{
    return [self.url.path rangeOfString:kKSPManagedParts].location != NSNotFound;
}

- (NSString *)assetTitle
{
    NSString *title =  [self valueForKey:kPartKeyTitle];
    
    if( !title || (title.length == 0) )
        title = [self valueForKey:kPartKeyName];

    if( !title || (title.length == 0) )
        title = [self.url.lastPathComponent capitalizedString];
    
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

    
    NSURL *targetURL = [destinationDirURL URLByAppendingPathComponent:self.url.lastPathComponent
                                                          isDirectory:YES];
    
    NSError *error = nil;
    
    [self.fileManager moveItemAtURL:self.url toURL:targetURL error:&error];
    
    if( error ){
        self.error = error;
        return NO;
    }
    
    self.url = targetURL;
    self.error = nil;

    return YES;
}

- (BOOL)copyTo:(NSURL *)destinationDirURL
{
    
    NSURL *targetURL = [destinationDirURL URLByAppendingPathComponent:self.url.lastPathComponent
                                                          isDirectory:YES];
    
    NSError *error = nil;
    
    [self.fileManager copyItemAtURL:self.url toURL:targetURL error:&error];
    
    if( error ) {
        self.error = error;
        return NO;
    }
    
    self.url = targetURL;
    
    self.error = nil;
    
    return YES;
    
}

- (BOOL)remove
{
    NSError *error = nil;
    [self.fileManager removeItemAtURL:self.url error:&error];
    self.error = error;

    if( error )
        return NO;
    
    self.url = nil;
    
    return YES;
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
