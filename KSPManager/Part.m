//
//  Part.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/15/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Part.h"
#import "ConfigFile.h"

@implementation Part

@synthesize partDirectoryName = _partDirectoryName;
@synthesize configurationURL = _configurationURL;

@synthesize detail = _detail;
@synthesize module = _module;
@synthesize name = _name;
@synthesize desc = _desc;
@synthesize author = _author;
@synthesize manufacturer = _manufacturer;
@synthesize category = _category;
@synthesize categoryName = _categoryName;
@synthesize fuel = _fuel;


- (id)initWithConfigurationFileURL:(NSURL *)cfgURL
{
    if( [cfgURL checkResourceIsReachableAndReturnError:nil] == NO )
        return nil;
    
    if( self = [super initWithURL:[cfgURL URLByDeletingLastPathComponent]] ) {
         self.configurationURL = cfgURL;
        _category  = -1;
        _fuel = -1;
        
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
    
    if( _configurationURL )
        _configFile = [[ConfigFile alloc] initWithURL:_configurationURL
                                         commentToken:kKSP_COMMENT_TOKEN
                                      assignmentToken:kKSP_ASSIGNMENT_TOKEN];
    else
        _configFile = nil;
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"name %@ file %@",self.name,self.baseURL.path];
}


- (id)configurationValueForKey:(NSString *)key
{
    if ( _configDict == nil ) {
        _configDict = [NSMutableDictionary dictionaryWithDictionary:[_configFile parse]];
    }
    return [_configDict valueForKey:key];
}

- (NSString *)module
{
    if( _module == nil ) {
        _module = [self configurationValueForKey:kPART_MODULE_KEY];
    }
    return _module;
}


- (NSString *)name
{
    if( _name == nil) {
        
        for(NSString *key in @[ kPART_TITLE_KEY,kPART_NAME_KEY]) {
            _name = [self configurationValueForKey:key];
            if( _name )
                break;
        }
        
        if( _name == nil )
            _name = self.partDirectoryName;
    }
    return _name;
}

- (NSString *)desc
{
    if( _desc == nil ) {
        _desc = [self configurationValueForKey:kPART_DESCRIPTION_KEY];
    }
    return _desc;
}

- (NSString *)author
{
    if( _author == nil ) {
        _author = [self configurationValueForKey:kPART_AUTHOR_KEY];
    }
    return _author;
}

- (NSString *)manufacturer
{
    if( _manufacturer == nil ) {
        _manufacturer = [self configurationValueForKey:kPART_MANUFACTURER_KEY];
    }
    return _manufacturer;
}

- (NSInteger)category
{
    if( _category == -1 ) {
        _category = [(NSString *)[self configurationValueForKey:kPART_CATEGORY_KEY] integerValue];
    }
    return _category;
}

- (NSString *)categoryName
{
    if( _categoryName == nil ) {
        _categoryName = [[Part categoryNames] objectAtIndex:self.category];
    }
    return _categoryName;
}

- (NSInteger)fuel
{
    if( _fuel == -1 ) {
        // solid fuel parts have "internal fuel"
        // tanks have "fuel"
    }
    return _fuel;
}



    
- (NSString *)detail
{
    if( _detail == nil ) {
        _detail = [NSString stringWithFormat:@"\n%@\n\n",self.name];
        for(NSString *key in @[kPART_MODULE_KEY, kPART_AUTHOR_KEY, kPART_MANUFACTURER_KEY] ) {
            NSString *value = [_configDict valueForKey:key];
            
            if( value != nil )
                _detail = [NSString stringWithFormat:@"%@%@:\t%@\n",_detail,key,value];
        }
        if( self.desc)
            _detail  = [NSString stringWithFormat:@"%@\n%@",_detail,self.desc];
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
