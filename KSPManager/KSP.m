//
//  KSP.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/14/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "KSP.h"
#import "KSP_Constants.h"
#import "PersistenceFile.h"
#import "Part.h"
#import "Plugin.h"
#import "Ship.h"
#import "Prop.h"
#import "Space.h"

@implementation KSP

@synthesize baseURL = _baseURL;

@synthesize bundleURL = _appURL;
@synthesize propsURL = _propsURL;
@synthesize spacesURL = _spacesURL;
@synthesize partsURL = _partsURL;
@synthesize pluginsURL = _pluginsURL;
@synthesize pluginDataURL = _pluginDataURL;
@synthesize resourcesURL = _resourcesURL;
@synthesize persistentURL = _persistentURL;
@synthesize savesURL = _savesURL;
@synthesize screenshotsURL = _screenshotsURL;
@synthesize soundsURL = _soundsURL;
@synthesize settingsURL = _settingsURL;
@synthesize shipsURL = _shipsURL;

@synthesize availablePartsURL = _availablePartsURL;
@synthesize availablePluginsURL = _availablePluginsURL;
@synthesize availableShipsURL = _availableShipsURL;
@synthesize availablePropsURL = _availablePropsURL;
@synthesize availableSpacesURL = _availableSpacesURL;

@synthesize parts = _parts;
@synthesize plugins = _plugins;
@synthesize ships = _ships;
@synthesize props = _props;
@synthesize spaces = _spaces;

@synthesize persistenceFile = _persistenceFile;
@synthesize unzipURL = _unzipURL;
@synthesize unrarURL = _unrarURL;
@synthesize userPreferencesPlist = _userPreferencesPlist;

@synthesize validInstallation = _validInstallation;



- (id)initWithURL:(NSURL *)fileURL
{
    self = [super init];
    if (self) {
        _baseURL = fileURL;
    }
    return self;
}

#pragma mark -
#pragma mark Readonly Properties

- (NSURL *)buildRelativeFileURL:(NSString *)path
{
    NSError *error = nil;
    
    NSURL *url = [self.baseURL URLByAppendingPathComponent:path];
    
    [[NSFileManager defaultManager] createDirectoryAtURL:url
                             withIntermediateDirectories:YES
                                              attributes:nil
                                                   error:&error];
    
    if( error ){
        NSLog(@"buildRelativeFileURL:%@ failed: %@",path,error);
        return nil;
    }

    return url;
}

- (NSURL *)buildValidRelativeFileURL:(NSString *)path
{
    
    NSURL *url = [self.baseURL URLByAppendingPathComponent:path];
    NSError *error = nil;
    
    if( [url checkResourceIsReachableAndReturnError:&error ] == NO)
        url = nil;
    
    if( error ){
        NSLog(@"buildValidRelativeFileURL:%@ failed: %@",path,error);
        return nil;
    }
    
    return url;
}

- (NSURL *)bundleURL
{
    if( _appURL == nil ) {
        _appURL = [self buildValidRelativeFileURL:kKSP_APP];
    }
    return _appURL;
}

- (NSURL *)propsURL
{
    if( _propsURL == nil ) {
        _propsURL = [self buildValidRelativeFileURL:kKSP_PROPS];
    }
    return _propsURL;
}

- (NSURL *)spacesURL
{
    if( _spacesURL == nil ) {
        _spacesURL = [self buildValidRelativeFileURL:kKSP_SPACES];
    }
    return _spacesURL;
}

- (NSURL *)partsURL
{
    if( _partsURL == nil ) {
        _partsURL = [self buildValidRelativeFileURL:kKSP_PARTS];
    }
    return _partsURL;
}

- (NSURL *)pluginsURL
{
    if( _pluginsURL == nil ) {
        _pluginsURL =[self buildValidRelativeFileURL:kKSP_PLUGINS];

    }
    return _pluginsURL;
}

- (NSURL *)pluginDataURL
{
    if( _pluginDataURL == nil ) {
        _pluginDataURL =[self buildValidRelativeFileURL:kKSP_PLUGINDATA];
        
    }
    return _pluginDataURL;
}

- (NSURL *)resourcesURL
{
    if( _resourcesURL == nil ) {
        _resourcesURL = [self buildValidRelativeFileURL:kKSP_RESOURCES];
    }
    return _resourcesURL;
}

- (NSURL *)persistentURL
{
    if( _persistentURL == nil ){
        _persistentURL = [self buildValidRelativeFileURL:kKSP_PERSISTENT];
    }
    return _persistentURL;
}

- (NSURL *)savesURL
{
    if( _savesURL == nil ) {
        _savesURL = [self buildValidRelativeFileURL:kKSP_SAVES];
    }
    return _savesURL;
}

- (NSURL *)screenshotsURL
{
    if( _screenshotsURL == nil ) {
        _screenshotsURL = [self buildValidRelativeFileURL:kKSP_SCREENSHOTS];
    }
    return _screenshotsURL;
}

- (NSURL *)soundsURL
{
    if( _soundsURL == nil ) {
        _soundsURL = [self buildValidRelativeFileURL:kKSP_SOUNDS];
    }
    return _soundsURL;
}

- (NSURL *)settingsURL
{
    if( _settingsURL == nil ) {
        _settingsURL = [self buildValidRelativeFileURL:kKSP_SETTINGS];
    }
    return _settingsURL;
}

- (NSURL *)shipsURL
{
    if( _shipsURL == nil ) {
        _shipsURL = [self buildValidRelativeFileURL:kKSP_SHIPS];
    }
    return _shipsURL;
}

- (NSURL *)availablePartsURL
{
    if( _availablePartsURL == nil ) {
        _availablePartsURL = [self buildRelativeFileURL:kKSP_MODS_PARTS];
    }
    return _availablePartsURL;
}

- (NSURL *)availablePluginsURL
{
    if( _availablePluginsURL == nil ) {
        _availablePluginsURL = [self buildRelativeFileURL:kKSP_MODS_PLUGINS];
    }
    return _availablePluginsURL;
}

- (NSURL *)availableShipsURL
{
    if( _availableShipsURL == nil ) {
        _availableShipsURL = [self buildRelativeFileURL:kKSP_MODS_SHIPS];
    }
    return _availableShipsURL;
}

- (NSURL *)availablePropsURL
{
    if( _availablePropsURL == nil ) {
        _availablePropsURL = [self buildRelativeFileURL:kKSP_MODS_PROPS];
    }
    return _availablePropsURL;
}

- (NSURL *)availableSpacesURL
{
    if( _availableSpacesURL == nil ) {
        _availableSpacesURL = [self buildRelativeFileURL:kKSP_MODS_SPACES];
    }
    return _availableSpacesURL;
}


- (NSMutableArray *)parts
{
    if( _parts == nil) {
        _parts = [[NSMutableArray alloc] init];
        [_parts addObjectsFromArray:[Part inventory:self.partsURL]];
        [_parts addObjectsFromArray:[Part inventory:self.availablePartsURL]];
    }
    return _parts;
}

- (NSMutableArray *)plugins
{
    if( _plugins == nil ) {
        _plugins = [[NSMutableArray alloc] init];
        [_plugins addObjectsFromArray:[Plugin inventory:self.pluginsURL]];
        [_plugins addObjectsFromArray:[Plugin inventory:self.availablePluginsURL]];
    }
    return _plugins;
}

- (NSMutableArray *)ships
{
    if( _ships == nil ) {
        _ships = [[NSMutableArray alloc] init];
        [_ships addObjectsFromArray:[Ship inventory:self.shipsURL]];
        [_ships addObjectsFromArray:[Ship inventory:self.availableShipsURL]];
    }
    return _ships;
}

- (NSMutableArray *)props
{
    if( _props == nil ) {
        _props = [[NSMutableArray alloc] init];
        
        [_props addObjectsFromArray:[Prop inventory:self.propsURL]];
        [_props addObjectsFromArray:[Prop inventory:self.availablePropsURL]];
    }
    return _props;
}

- (NSMutableArray *)spaces
{
    if( _spaces == nil ) {
        _spaces = [[NSMutableArray alloc] init];
        [_spaces addObjectsFromArray:[Space inventory:self.spacesURL]];
        [_spaces addObjectsFromArray:[Space inventory:self.availableSpacesURL]];
    }
    return _spaces;
}



- (PersistenceFile *)persistenceFile
{
    if( _persistenceFile == nil ){
        _persistenceFile = [[PersistenceFile alloc] initWithURL:self.persistentURL];
    }
    return _persistenceFile;
}

- (NSURL *)unzipURL
{
    if( _unzipURL == nil) {
        _unzipURL = [NSURL fileURLWithPath:kKSP_DEFAULT_UNZIP_PATH];
    }
    return _unzipURL;
}

- (NSURL *)unrarURL
{
    if( _unrarURL == nil ){
        _unrarURL = nil;
    }
    return _unrarURL;
}

- (NSURL *)userPreferencesPlist
{
    if( _userPreferencesPlist == nil ) {
        _userPreferencesPlist = [NSURL fileURLWithPath:[kKSPPreferencesPlistPath stringByExpandingTildeInPath]];
    }
    return _userPreferencesPlist;
}

#pragma mark -
#pragma mark Super Method Overrides

- (NSString *)description
{
    return [NSString stringWithFormat:@"KSP Installation [%@] @ %@",self.isValidInstallation?@"VALID":@"INVALID",self.baseURL];
    
}

#pragma mark -
#pragma mark Instance Methods

- (BOOL)isValidInstallation
{
    _validInstallation = ( (self.bundleURL != nil) &&
                          (self.propsURL != nil) &&
                          (self.spacesURL != nil) &&
                          (self.partsURL != nil) &&
                          (self.pluginsURL != nil) &&
                          (self.screenshotsURL != nil) &&
                          (self.shipsURL != nil ) &&
                          (self.soundsURL != nil)) ;
    
    return _validInstallation;
}


- (BOOL)install:(Asset *)object
{
    
    if( [object isMemberOfClass:[Part class]] )
        return [object moveTo:self.partsURL];

    if( [object isMemberOfClass:[Plugin class]] )
        return [object moveTo:self.pluginsURL];

    if( [object isMemberOfClass:[Ship class]] ) {
        Ship *ship = (Ship *)object;
        return [object moveTo:[self.shipsURL URLByAppendingPathComponent:ship.hanger]];
    }
    
    if( [object isMemberOfClass:[Prop class]] )
        return [object moveTo:self.propsURL];
    
    if( [object isMemberOfClass:[Space class]] )
        return [object moveTo:self.spacesURL];

    NSLog(@"KSP install:%@ unknown asset %@",object,object.class);
    
    return NO;
}

- (BOOL)uninstall:(Asset *)object
{
    if( [object isMemberOfClass:[Part class]] )
        return [object moveTo:self.availablePartsURL];

    if( [object isMemberOfClass:[Plugin class]] )
        return [object moveTo:self.availablePluginsURL];

    if( [object isMemberOfClass:[Ship class]] ) {
        Ship *ship = (Ship *)object;
        
        return [object moveTo:[self.availableShipsURL URLByAppendingPathComponent:ship.hanger]];
    }
    
    if( [object isMemberOfClass:[Prop class]] ) {
        return [object moveTo:self.availablePropsURL];
    }
    
    if( [object isMemberOfClass:[Space class]] )
        return [object moveTo:self.availableSpacesURL];
    
    NSLog(@"KSP uninstall:%@ unknown asset %@",object,object.class);

    return NO;
}

- (BOOL)manage:(Asset *)object installed:(BOOL)install
{
    
    // XXX need to recognize and reject duplication?
    
    if( [object isMemberOfClass:[Part class]] )
        [self.parts addObject:object];
    
    if( [object isMemberOfClass:[Plugin class]] )
        [self.plugins addObject:object];
    
    if( [object isMemberOfClass:[Ship class]] )
        [self.ships addObject:object];
    
    if( [object isMemberOfClass:[Prop class]] )
        [self.props addObject:object];
    
    if( [object isMemberOfClass:[Space class]] )
        [self.spaces addObject:object];
    
    if (install)
        return [self install:object];
    
    return [self uninstall:object];
}

- (BOOL)unmanage:(Asset *)object
{

    if( [object remove] == NO )
        return NO;
    
    if( [self.parts containsObject:object] )
        [self.parts removeObject:object];
    
    if( [self.plugins containsObject:object] )
        [self.plugins removeObject:object];

    
    if( [self.ships containsObject:object] )
        [self.ships removeObject:object];
    
    if( [self.props containsObject:object] )
        [self.props removeObject:object];
    
    if( [self.spaces containsObject:object] )
        [self.spaces removeObject:object];

    object = nil;
    
    return YES;
}

- (void)cleanUp
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSURL *caches = [[fileManager URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
    
    caches = [caches URLByAppendingPathComponent:[NSString pathWithComponents:@[[NSBundle mainBundle].bundleIdentifier,kKSP_TEMP_ASSETS]]
                                     isDirectory:YES];
    
    [fileManager removeItemAtURL:caches  error:nil];
    
}

- (NSURL *)downloadCacheURLforPath:(NSString *)path
{
   [[NSFileManager defaultManager] createDirectoryAtURL:[self cacheURLforPath:@"Downloads"]
                            withIntermediateDirectories:YES
                                             attributes:nil
                                                  error:nil];
    
    return [self cacheURLforPath:[@"Downloads" stringByAppendingPathComponent:path]];
}

- (NSURL *)cacheURLforPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *cacheURL;
    NSError *error = nil;

    NSURL *caches = [[fileManager URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
    
    cacheURL = [caches URLByAppendingPathComponent:[NSString pathWithComponents:@[[NSBundle mainBundle].bundleIdentifier,kKSP_TEMP_ASSETS]]
                                       isDirectory:YES];
    
    [fileManager createDirectoryAtURL:cacheURL
          withIntermediateDirectories:YES
                           attributes:nil
                                error:&error];
    

    cacheURL = [cacheURL URLByAppendingPathComponent:path];
    
    if( [cacheURL checkResourceIsReachableAndReturnError:&error] == YES )
        [fileManager removeItemAtURL:cacheURL error:&error];
    
    return cacheURL;
}

- (NSURL *)inflateZipFile:(NSURL *)fileURL inDestination:(NSURL *)dstURL
{

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;

    NSURL *copyURL;
    
    if( dstURL != nil ) {

        [fileManager copyItemAtURL:fileURL toURL:dstURL error:&error];

        if( error ) {
            NSLog(@"copy %@ to %@: %@",fileURL,dstURL,error);
            return nil;
        }
        fileURL = copyURL;
    }
    
    NSTask *task = [[NSTask alloc] init];
    
    [task setCurrentDirectoryPath:[fileURL URLByDeletingLastPathComponent].path];
    [task setLaunchPath:self.unzipURL.path];
    [task setArguments:@[@"-o",fileURL.lastPathComponent]];
    
    [task launch];
    [task waitUntilExit];
    
    if([task terminationStatus] != 0)
        return nil;
    
    return [fileURL URLByDeletingLastPathComponent];
}


- (NSArray *)createAssetsWith:(NSURL *)url install:(BOOL)install
{
    NSMutableArray *assets = [[NSMutableArray alloc] init];
    NSArray *results;
    NSError *error = nil;
    NSNumber *isDir;
    
    [url getResourceValue:&isDir forKey:NSURLIsDirectoryKey error:&error];
    
    if( error ) {
        [[NSAlert alertWithError:error] runModal];
        return assets;
    }
    
    if( [isDir boolValue] == NO) {
        
        NSString *ext = url.lastPathComponent.pathExtension;
        
        if( [ext caseInsensitiveCompare:@"zip"] == NSOrderedSame ){
            NSURL *dst = nil;
            if( [url.path rangeOfString:kKSP_TEMP_ASSETS].location == NSNotFound )
                dst =[self cacheURLforPath:url.lastPathComponent];
            
            url = [self inflateZipFile:url inDestination:dst];
            
            goto AddAndInstall;
        }
        
        if( [ext caseInsensitiveCompare:kPLUGIN_EXT] == NSOrderedSame ){
            [assets addObject:[[Plugin alloc]initWithURL:url]];
            goto AddAndInstall;
        }
        
        if( [ext caseInsensitiveCompare:@"rar"] == NSOrderedSame ){
            // it's a RAR which needs a third-party helper to unarchive
            NSLog(@"rar archives are currently unsupported.");
            return assets;
        }
        
        if( [ext caseInsensitiveCompare:kCRAFT_EXT] == NSOrderedSame ) {
            [assets addObject:[[Ship alloc] initWithURL:url]];
            goto AddAndInstall;
        }
        
        if( [ext caseInsensitiveCompare:@"sfs"] == NSOrderedSame ) {
            // persistent file of some sort.. uh. punt
            NSLog(@"adding .sfs files currently unsupported.");
            return assets;
        }
    }

AddAndInstall:
    
    results = [Part inventory:url];
    
    if( results )
        [assets addObjectsFromArray:results];
    
    results = [Plugin inventory:url];
    if(results)
        [assets addObjectsFromArray:results];
    
    results = [Ship inventory:url];
    if( results )
        [assets addObjectsFromArray:results];

    results = [Prop inventory:url];
    if( results )
        [assets addObjectsFromArray:results];
    
    results = [Space inventory:url];
    if( results )
        [assets addObjectsFromArray:results];
    
    for (Asset *asset in assets) 
        [self manage:asset installed:install];

    return assets;
}

- (BOOL)launchKSP
{
    NSTask *task = [[NSTask alloc] init];
    
    [task setLaunchPath:[NSBundle bundleWithURL:self.bundleURL].executablePath];
    [task setCurrentDirectoryPath:self.baseURL.path];
    [task launch];
    
    return task.isRunning;
}

#pragma mark -
#pragma mark Class Methods




+ (NSArray *)locateInstallationDirectories
{
    
    
    NSMutableArray *searchURLS = [[NSMutableArray alloc] init];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSMutableArray *results = [[NSMutableArray alloc] init];
    NSSearchPathDomainMask domains = NSUserDomainMask;
    
    // deep search the user's Desktop, Downloads and Document directory

    [searchURLS addObjectsFromArray:[fileManager URLsForDirectory:NSDesktopDirectory
                                                        inDomains:domains]];

    [searchURLS addObjectsFromArray:[fileManager URLsForDirectory:NSDownloadsDirectory
                                                        inDomains:domains]];

    [searchURLS addObjectsFromArray:[fileManager URLsForDirectory:NSDocumentDirectory
                                                        inDomains:domains]];
    
    for(NSURL *url in searchURLS) {
        
        NSError *error = nil;
        NSArray *subPaths = [fileManager subpathsOfDirectoryAtPath:url.path error:&error];
        
        if( error ) {
            [[NSAlert alertWithError:error] runModal];
            continue;
        }
        
        for(NSString *subPath in subPaths) {
            if( [[subPath lastPathComponent] isEqualToString:kKSP_APP]) {
                NSURL *targetURL = [url URLByAppendingPathComponent:subPath.stringByDeletingLastPathComponent isDirectory:YES];
                [results addObject:[[KSP alloc]initWithURL:targetURL]];
            }
        }
    }
    
    [searchURLS removeAllObjects];
    
    // shallow search /Applications & the users's home directory
    
    [searchURLS addObjectsFromArray:[fileManager URLsForDirectory:NSAllApplicationsDirectory
                                                        inDomains:NSLocalDomainMask]];
    
    [searchURLS addObjectsFromArray:[fileManager URLsForDirectory:NSUserDirectory
                                                        inDomains:NSUserDomainMask]];
    
    for(NSURL *url in searchURLS){
        NSError *error = nil;
     
        NSArray *subURLs = [fileManager contentsOfDirectoryAtURL:url
                                      includingPropertiesForKeys:@[ NSURLIsDirectoryKey, NSURLLocalizedNameKey ]
                                                         options:NSDirectoryEnumerationSkipsHiddenFiles | NSDirectoryEnumerationSkipsSubdirectoryDescendants
                                                           error:&error];
        
        for(NSURL *subURL in subURLs){
            if( [subURL.lastPathComponent isEqualToString:kKSP_APP] == YES ){
                NSURL *targetURL = [url URLByAppendingPathComponent:subURL.path.stringByDeletingLastPathComponent];
                [results addObject:[[KSP alloc] initWithURL:targetURL]];
            }
        }
    }
    

    return results;
}

+ (BOOL)terminateRunningKSP
{
    BOOL result = NO;

    NSArray *selectedApps =
    [NSRunningApplication runningApplicationsWithBundleIdentifier:kKSP_BUNDLE_ID ];

    [selectedApps makeObjectsPerformSelector:@selector(terminate)];
    result = YES;
    
    return result;
}








@end
