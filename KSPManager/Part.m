//
//  Part.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/15/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Part.h"
#import "PartCFG.h"

@interface Part () {
    CFGPart *_cfgPart;
}

@end

@implementation Part


@synthesize configurationURL = _configurationURL;
@synthesize categoryName = _categoryName;

- (id)initWithURL:(NSURL *)configurationFileURL
{
    
    if( self = [super initWithURL:[configurationFileURL URLByDeletingLastPathComponent]] ) {
        
        if( [configurationFileURL checkResourceIsReachableAndReturnError:nil]   == NO )
            return nil;
        
        _cfgPart = [PartCFG partForContentsOfURL:configurationFileURL];
    }

    return self;
}

#pragma mark -
#pragma mark Properties



- (void)setConfigurationURL:(NSURL *)configurationURL
{
    if( _configurationURL == configurationURL )
        return ;
    
    _configurationURL = configurationURL;
    
    self.baseURL = [_configurationURL URLByDeletingLastPathComponent];
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
    return [_cfgPart valueForKey:key];
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
    
    if( !title || (title.length == 0) )
        title = [self valueForKey:kPartKeyName];
    
    if( !title || (title.length == 0) )
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

    
    NSURL *targetURL = [destinationDirURL URLByAppendingPathComponent:self.baseURL.lastPathComponent
                                                          isDirectory:YES];
    
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
    
    NSURL *targetURL = [destinationDirURL URLByAppendingPathComponent:self.baseURL.lastPathComponent
                                                          isDirectory:YES];
    
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
