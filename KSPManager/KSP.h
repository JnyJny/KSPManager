//
//  KSP.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/14/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSP_Constants.h"

@class Asset;

@interface KSP : NSObject

@property (strong, nonatomic, readonly) NSURL *baseURL;
@property (strong, nonatomic, readonly) NSURL *bundleURL;
@property (strong, nonatomic, readonly) NSURL *propsURL;
@property (strong, nonatomic, readonly) NSURL *spacesURL;
@property (strong, nonatomic, readonly) NSURL *partsURL;
@property (strong, nonatomic, readonly) NSURL *pluginsURL;
@property (strong, nonatomic, readonly) NSURL *pluginDataURL;
@property (strong, nonatomic, readonly) NSURL *resourcesURL;

//@property (strong, nonatomic, readonly) NSURL *savesURL;
@property (strong, nonatomic, readonly) NSURL *trainingURL;
@property (strong, nonatomic, readonly) NSURL *scenariosURL;
@property (strong, nonatomic, readonly) NSURL *sandboxesURL;

@property (strong, nonatomic, readonly) NSURL *screenshotsURL;
@property (strong, nonatomic, readonly) NSURL *soundsURL;
@property (strong, nonatomic, readonly) NSURL *settingsURL;
@property (strong, nonatomic, readonly) NSURL *shipsURL;

@property (strong, nonatomic, readonly) NSURL *availablePartsURL;
@property (strong, nonatomic, readonly) NSURL *availablePluginsURL;
@property (strong, nonatomic, readonly) NSURL *availableShipsURL;
@property (strong, nonatomic, readonly) NSURL *availablePropsURL;
@property (strong, nonatomic, readonly) NSURL *availableSpacesURL;
@property (strong, nonatomic, readonly) NSURL *availableTrainingURL;
@property (strong, nonatomic, readonly) NSURL *availableScenariosURL;
@property (strong, nonatomic, readonly) NSURL *availableSandboxesURL;

@property (readonly, nonatomic,getter = isValidInstallation) BOOL validInstallation;

@property (strong, nonatomic, readonly) NSMutableArray *parts;
@property (strong, nonatomic, readonly) NSMutableArray *plugins;
@property (strong, nonatomic, readonly) NSMutableArray *ships;
@property (strong, nonatomic, readonly) NSMutableArray *props;
@property (strong, nonatomic, readonly) NSMutableArray *spaces;
@property (strong, nonatomic, readonly) NSMutableArray *training;
@property (strong, nonatomic, readonly) NSMutableArray *scenarios;
@property (strong, nonatomic, readonly) NSMutableArray *sandboxes;

@property (strong, nonatomic, readonly) NSDictionary *managedAssets;

@property (strong, nonatomic, readonly) NSURL *unzipURL;
@property (strong, nonatomic, readonly) NSURL *unrarURL;
@property (strong, nonatomic, readonly) NSURL *userPreferencesPlistURL;
@property (strong, nonatomic, readonly) NSURL *savedApplicationStateURL;


- (id)initWithURL:(NSURL *)fileURL;

- (BOOL)install:(Asset *)object;
- (BOOL)uninstall:(Asset *)object;

- (BOOL)manage:(Asset *)object installed:(BOOL)install;
- (BOOL)unmanage:(Asset *)object;

- (NSArray *)createAssetsWith:(NSURL *)fileURL install:(BOOL)install;

- (NSURL *)downloadCacheURLforPath:(NSString *)path;
- (NSURL *)cacheURLforPath:(NSString *)path;

- (id)assetMatchingValue:(NSString *)value forKey:(NSString *)key;

- (BOOL)launchKSP;

- (void)cleanUp;

+ (NSArray *)locateInstallationDirectories;
+ (BOOL)terminateRunningKSP;





@end
