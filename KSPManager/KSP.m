//
//  KSP.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/14/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "KSP.h"
#import "KSP_Constants.h"
#import "Part.h"
#import "Plugin.h"
#import "Ship.h"
#import "Prop.h"
#import "Space.h"
#import "Training.h"
#import "Scenario.h"
#import "Sandbox.h"

@implementation KSP

@synthesize baseURL = _baseURL;

@synthesize bundleURL = _appURL;
@synthesize propsURL = _propsURL;
@synthesize spacesURL = _spacesURL;
@synthesize partsURL = _partsURL;
@synthesize pluginsURL = _pluginsURL;
@synthesize pluginDataURL = _pluginDataURL;
@synthesize resourcesURL = _resourcesURL;

@synthesize trainingURL = _trainingURL;
@synthesize scenariosURL = _scenariosURL;
@synthesize sandboxesURL = _sandboxesURL;

@synthesize screenshotsURL = _screenshotsURL;
@synthesize soundsURL = _soundsURL;
@synthesize settingsURL = _settingsURL;
@synthesize shipsURL = _shipsURL;

@synthesize availablePartsURL = _availablePartsURL;
@synthesize availablePluginsURL = _availablePluginsURL;
@synthesize availableShipsURL = _availableShipsURL;
@synthesize availablePropsURL = _availablePropsURL;
@synthesize availableSpacesURL = _availableSpacesURL;
@synthesize availableTrainingURL = _availableTrainingURL;
@synthesize availableScenariosURL = _availableScenariosURL;
@synthesize availableSandboxesURL = _availableSandboxesURL;

@synthesize validInstallation = _validInstallation;

// asset lists

@synthesize parts = _parts;
@synthesize plugins = _plugins;
@synthesize ships = _ships;
@synthesize props = _props;
@synthesize spaces = _spaces;
@synthesize training = _training;
@synthesize scenarios = _scenarios;
@synthesize sandboxes = _sandboxes;

@synthesize managedAssets = _managedAssets;

@synthesize unzipURL = _unzipURL;
@synthesize unrarURL = _unrarURL;
@synthesize userPreferencesPlistURL = _userPreferencesPlistURL;
@synthesize savedApplicationStateURL = _savedApplicationStateURL;


- (id)initWithURL:(NSURL *)fileURL
{
    self = [super init];
    if (self) {
        _baseURL = fileURL;
        [self migrate];
    }
    return self;
}


- (void)migrate
{
    NSError *error = nil;
    
    NSURL *modURL = [self buildRelativeFileURL:kKSP_MODS createIntermediates:NO];
    NSURL *managedURL = [self buildRelativeFileURL:kKSPManagedRoot createIntermediates:NO];
    
    BOOL modExists;
    BOOL managedExists;
    
    modExists = [modURL checkResourceIsReachableAndReturnError:nil];
    managedExists = [managedURL checkResourceIsReachableAndReturnError:nil];
    

    if( (!modExists && managedExists) ||
        ( modExists && managedExists) )
        return ;
    
    
    if( modExists && !managedExists ) {
     
        [[NSFileManager defaultManager] moveItemAtURL:modURL toURL:managedURL error:&error];
        
        if( error ) {
            [[NSAlert alertWithError:error] runModal];
        }
        NSLog(@"successfully migrated from %@ to %@",modURL,managedURL);
        return;
    }
    
    // what did we miss?  !modExists and !managedExists, meaning the
    // KSP installation has never been managed.  No problem.

    return;
}

#pragma mark -
#pragma mark URL Properties


- (NSURL *)buildRelativeFileURL:(NSString *)path
{
    return [self buildRelativeFileURL:path createIntermediates:NO];
}

- (NSURL *)buildRelativeFileURL:(NSString *)path createIntermediates:(BOOL)create
{
    NSError *error = nil;
    
    NSURL *url = [self.baseURL URLByAppendingPathComponent:path];
    
    if( create ) {
        [[NSFileManager defaultManager] createDirectoryAtURL:[url URLByDeletingLastPathComponent]
                                 withIntermediateDirectories:YES
                                                  attributes:nil
                                                       error:&error];
        if( error ){
            NSLog(@"buildRelativeFileURL:%@ failed: %@",path,error);
            return nil;
        }
    }

    return url;
}

- (NSURL *)bundleURL
{
    if( _appURL == nil ) {
        _appURL = [self buildRelativeFileURL:kKSP_APP];
    }
    return _appURL;
}

- (NSURL *)propsURL
{
    if( _propsURL == nil ) {
        _propsURL = [self buildRelativeFileURL:kKSP_PROPS];
    }
    return _propsURL;
}

- (NSURL *)spacesURL
{
    if( _spacesURL == nil ) {
        _spacesURL = [self buildRelativeFileURL:kKSP_SPACES];
    }
    return _spacesURL;
}

- (NSURL *)partsURL
{
    if( _partsURL == nil ) {
        _partsURL = [self buildRelativeFileURL:kKSP_PARTS];
    }
    return _partsURL;
}

- (NSURL *)pluginsURL
{
    if( _pluginsURL == nil ) {
        _pluginsURL =[self buildRelativeFileURL:kKSP_PLUGINS];

    }
    return _pluginsURL;
}

- (NSURL *)pluginDataURL
{
    if( _pluginDataURL == nil ) {
        _pluginDataURL =[self buildRelativeFileURL:kKSP_PLUGINDATA];
        
    }
    return _pluginDataURL;
}

- (NSURL *)resourcesURL
{
    if( _resourcesURL == nil ) {
        _resourcesURL = [self buildRelativeFileURL:kKSP_RESOURCES];
    }
    return _resourcesURL;
}

- (NSURL *)trainingURL
{
    if ( _trainingURL == nil ) {
        _trainingURL = [self buildRelativeFileURL:kKSP_TRAINING];
    }
    return _trainingURL;
}

- (NSURL *)scenariosURL
{
    if( _scenariosURL == nil ) {
        _scenariosURL = [self buildRelativeFileURL:kKSP_SCENARIOS];
    }
    return _scenariosURL;
}

- (NSURL *)sandboxesURL
{
    if( _sandboxesURL == nil ) {
        _sandboxesURL = [self buildRelativeFileURL:kKSP_SANDBOXES];
    }
    return _sandboxesURL;
}

- (NSURL *)screenshotsURL
{
    if( _screenshotsURL == nil ) {
        _screenshotsURL = [self buildRelativeFileURL:kKSP_SCREENSHOTS];
    }
    return _screenshotsURL;
}

- (NSURL *)soundsURL
{
    if( _soundsURL == nil ) {
        _soundsURL = [self buildRelativeFileURL:kKSP_SOUNDS];
    }
    return _soundsURL;
}

- (NSURL *)settingsURL
{
    if( _settingsURL == nil ) {
        _settingsURL = [self buildRelativeFileURL:kKSP_SETTINGS];
    }
    return _settingsURL;
}

- (NSURL *)shipsURL
{
    if( _shipsURL == nil ) {
        _shipsURL = [self buildRelativeFileURL:kKSP_SHIPS];
    }
    return _shipsURL;
}

- (NSURL *)availablePartsURL
{
    if( _availablePartsURL == nil ) {
        _availablePartsURL = [self buildRelativeFileURL:kKSPManagedParts createIntermediates:YES];
    }
    return _availablePartsURL;
}

- (NSURL *)availablePluginsURL
{
    if( _availablePluginsURL == nil ) {
        _availablePluginsURL = [self buildRelativeFileURL:kKSPManagedPlugins createIntermediates:YES];
    }
    return _availablePluginsURL;
}

- (NSURL *)availableShipsURL
{
    if( _availableShipsURL == nil ) {
        _availableShipsURL = [self buildRelativeFileURL:kKSPManagedShips createIntermediates:YES];
    }
    return _availableShipsURL;
}

- (NSURL *)availablePropsURL
{
    if( _availablePropsURL == nil ) {
        _availablePropsURL = [self buildRelativeFileURL:kKSPManagedProps createIntermediates:YES];
    }
    return _availablePropsURL;
}

- (NSURL *)availableSpacesURL
{
    if( _availableSpacesURL == nil ) {
        _availableSpacesURL = [self buildRelativeFileURL:kKSPManagedSpaces createIntermediates:YES];
    }
    return _availableSpacesURL;
}

- (NSURL *)availableTrainingURL
{
    if( _availableTrainingURL == nil ) {
        _availableTrainingURL = [self buildRelativeFileURL:kKSPManagedScenarios createIntermediates:YES];
    }
    return _availableTrainingURL;
}

- (NSURL *)availableScenariosURL
{
    if( _availableScenariosURL == nil ) {
        _availableScenariosURL = [self buildRelativeFileURL:kKSPManagedScenarios createIntermediates:YES];
    }
    return _availableScenariosURL;
}

- (NSURL *)availableSandboxesURL
{
    if( _availableSandboxesURL == nil ) {
        _availableSandboxesURL = [self buildRelativeFileURL:kKSPManagedSandboxes createIntermediates:YES];
    }
    return _availableSandboxesURL;
}

#pragma mark -
#pragma mark Managed Asset Arrays

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
        [_ships addObjectsFromArray:[Ship inventory:self.shipsURL withPartList:self.parts]];
        [_ships addObjectsFromArray:[Ship inventory:self.availableShipsURL withPartList:self.parts]];
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

- (NSMutableArray *)training
{
    if( _training == nil ) {
        _training = [[NSMutableArray alloc] init];
        [_training addObjectsFromArray:[Training inventory:self.trainingURL]];
        [_training addObjectsFromArray:[Training inventory:self.availableTrainingURL]];
    }
    return _training;
}

- (NSMutableArray *)scenarios
{
    if( _scenarios == nil ) {
        _scenarios = [[NSMutableArray alloc] init];
        [_scenarios addObjectsFromArray:[Scenario inventory:self.scenariosURL]];
        [_scenarios addObjectsFromArray:[Scenario inventory:self.availableScenariosURL]];
    }
    return _scenarios;
}

- (NSMutableArray *)sandboxes
{
    if( _sandboxes == nil ) {
        _sandboxes = [[NSMutableArray alloc] init];
        [_sandboxes addObjectsFromArray:[Sandbox inventory:self.sandboxesURL]];
        [_sandboxes addObjectsFromArray:[Sandbox inventory:self.availableSandboxesURL]];
    }
    return _sandboxes;
}

- (NSDictionary *)managedAssets
{

    NSMutableDictionary *tmp = [[NSMutableDictionary alloc] init];
    [tmp addEntriesFromDictionary:@{ [Part class].description:self.parts}];
    [tmp addEntriesFromDictionary:@{ [Plugin class].description:self.plugins}];
    [tmp addEntriesFromDictionary:@{ [Ship class].description:self.ships}];
    [tmp addEntriesFromDictionary:@{ [Prop class].description:self.props}];
    [tmp addEntriesFromDictionary:@{ [Space class].description:self.spaces}];
    [tmp addEntriesFromDictionary:@{ [Training class].description:self.training}];
    [tmp addEntriesFromDictionary:@{ [Scenario class].description:self.scenarios}];
    [tmp addEntriesFromDictionary:@{ [Sandbox class].description:self.sandboxes}];
    
    return tmp;
}

#pragma mark -
#pragma mark Utility Properties

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

- (NSURL *)userPreferencesPlistURL
{
    if( _userPreferencesPlistURL == nil ) {
        _userPreferencesPlistURL = [NSURL fileURLWithPath:[kKSPPreferencesPlistPath stringByExpandingTildeInPath]];
    }
    return _userPreferencesPlistURL;
}


- (NSURL *)savedApplicationStateURL
{
    if( _savedApplicationStateURL == nil ) {
        _savedApplicationStateURL = [NSURL fileURLWithPath:[kKSPSavedApplicationStatePath stringByExpandingTildeInPath]];
    }
    return _savedApplicationStateURL;
}

#pragma mark -
#pragma mark Super Method Overrides

- (NSString *)description
{
    return [NSString stringWithFormat:@"KSP Installation [%@] @ %@",self.isValidInstallation?@"VALID":@"INVALID",self.baseURL];
    
}

#pragma mark -
#pragma mark Instance Methods



- (BOOL)install:(Asset *)object
{
    
    if( [object isMemberOfClass:[Part class]] )
        return [object moveTo:self.partsURL];

    if( [object isMemberOfClass:[Plugin class]] )
        return [object moveTo:self.pluginsURL];

    if( [object isMemberOfClass:[Ship class]] ) {
        Ship *ship = (Ship *)object;
        return [object moveTo:[self.shipsURL URLByAppendingPathComponent:ship.hangerName]];
    }
    
    if( [object isMemberOfClass:[Prop class]] )
        return [object moveTo:self.propsURL];
    
    if( [object isMemberOfClass:[Space class]] )
        return [object moveTo:self.spacesURL];
    
    if( [object isMemberOfClass:[Training class]] )
        return [object moveTo:self.trainingURL];
    
    if( [object isMemberOfClass:[Scenario class]] )
        return [object moveTo:self.scenariosURL];
    
    if( [object isMemberOfClass:[Sandbox class]] )
        return [object moveTo:self.sandboxesURL];
    
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
        return [object moveTo:[self.availableShipsURL URLByAppendingPathComponent:ship.hangerName]];
    }
    
    if( [object isMemberOfClass:[Prop class]] ) {
        return [object moveTo:self.availablePropsURL];
    }
    
    if( [object isMemberOfClass:[Space class]] )
        return [object moveTo:self.availableSpacesURL];
    
    if( [object isMemberOfClass:[Training class]] )
        return [object moveTo:self.availableTrainingURL];
    
    if( [object isMemberOfClass:[Scenario class]] )
        return [object moveTo:self.availableScenariosURL];
    
    if( [object isMemberOfClass:[Sandbox class]] )
        return [object moveTo:self.availableSandboxesURL];
    
    NSLog(@"KSP uninstall:%@ unknown asset %@",object,object.class);

    return NO;
}

// manage - move asset from wherever it is now in the file system heirarchy
//          to KSP_ROOT/<wherever it should go>
//
//          if install is YES: put it in KSP_ROOT/<asset dir>
//          if install is NO: put it in KSP_ROOT/Managed/<asset dir>
//

- (BOOL)manage:(Asset *)object installed:(BOOL)install
{
    

    NSMutableArray *collection = [self.managedAssets valueForKey:object.class.description];
    
    if( collection == nil  )
        return NO;
    
    [collection addObject:object];


    if (install)
        return [self install:object];
    
    return [self uninstall:object];
}

// unmange - alittle more involved
//
//           remove the asset from it's managed array
//           ask the asset to remove it's managed file(s)
//           nil out the object


- (BOOL)unmanage:(Asset *)object
{

    NSMutableArray *collection = [self.managedAssets valueForKey:object.class.description];
    
    if( collection == nil )
        return NO;
    
    [collection removeObject:object];
    
    if( [object remove] == NO ) {
        // add the object back if the remove fails
        [collection addObject:object];
        return NO;
    }

    object = nil;
    
    return YES;
}

// createAssetsWith:install:
//
// This is how new assets are added
//

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
            // XXX throw an error
            NSLog(@"rar archives are currently unsupported.");
            return assets;
        }
        
        if( [ext caseInsensitiveCompare:kCRAFT_EXT] == NSOrderedSame ) {
            [assets addObject:[[Ship alloc] initWithURL:url]];
            goto AddAndInstall;
        }
        
        if( [ext caseInsensitiveCompare:kSFS_EXT] == NSOrderedSame ) {
#if 0
            // persistent file of some sort.. uh. punt
            // XXX throw an error
            NSLog(@"adding .sfs files currently unsupported.");
#endif
            // wrong, we support them now.  strip the lastPathComponent from url
            // and continue.  I think this should work.  Lots of things have .sfs extensions
            // ( training, scenario, sandbox.. the inventories should be able to sort it all
            // out.  It's a good theory.
            url = [url URLByDeletingLastPathComponent];
            goto AddAndInstall;
        }
    }
    
AddAndInstall:
    
    if( (results = [Part inventory:url]) )
        [assets addObjectsFromArray:results];
    
    if( (results = [Plugin inventory:url]) )
        [assets addObjectsFromArray:results];
    
    if( (results = [Ship inventory:url]) )
        [assets addObjectsFromArray:results];
    
    if( (results = [Prop inventory:url]) )
        [assets addObjectsFromArray:results];
    
    if( (results = [Space inventory:url]) )
        [assets addObjectsFromArray:results];
    
    if( (results = [Training inventory:url]) )
        [assets addObjectsFromArray:results];
    
    if( (results = [Scenario inventory:url]) )
        [assets addObjectsFromArray:results];
    
    if( (results = [Sandbox inventory:url]) )
        [assets addObjectsFromArray:results];
    
    for (Asset *asset in assets)
        [self manage:asset installed:install];
    
    return assets;
}



#pragma mark -
#pragma mark Utility Methods

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


#pragma mark -



- (BOOL)isValidInstallation
{
    NSBundle *kspBundle = [NSBundle bundleWithURL:self.bundleURL];
    
    if( kspBundle == nil )
        return NO;
    
    return [[kspBundle bundleIdentifier] isEqualToString:kKSP_BUNDLE_ID];
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
