//
//  KSP.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/14/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersistenceFile.h"


@interface KSP : NSObject {

}
@property (strong, nonatomic, readonly) NSURL *baseURL;
@property (strong, nonatomic, readonly) NSURL *bundleURL;
@property (strong, nonatomic, readonly) NSURL *internalsURL;
@property (strong, nonatomic, readonly) NSURL *partsURL;
@property (strong, nonatomic, readonly) NSURL *pluginsURL;
@property (strong, nonatomic, readonly) NSURL *pluginDataURL;
@property (strong, nonatomic, readonly) NSURL *resourcesURL;
@property (strong, nonatomic, readonly) NSURL *persistentURL;
@property (strong, nonatomic, readonly) NSURL *savesURL;
@property (strong, nonatomic, readonly) NSURL *screenshotsURL;
@property (strong, nonatomic, readonly) NSURL *soundsURL;
@property (strong, nonatomic, readonly) NSURL *settingsURL;
@property (strong, nonatomic, readonly) NSURL *shipsURL;
@property (strong, nonatomic, readonly) NSURL *vabURL;
@property (strong, nonatomic, readonly) NSURL *sphURL;
@property (strong, nonatomic, readonly) NSURL *availablePartsURL;
@property (strong, nonatomic, readonly) NSURL *availablePluginsURL;
@property (strong, nonatomic, readonly) NSURL *availableShipsURL;

@property (readonly, nonatomic,getter = isValidInstallation) BOOL validInstallation;

@property (strong, nonatomic, readonly) NSMutableArray *parts;
@property (strong, nonatomic, readonly) NSMutableArray *plugins;
@property (strong, nonatomic, readonly) NSMutableArray *ships;

@property (strong, nonatomic, readonly) PersistenceFile *persistenceFile;

@property (strong, nonatomic, readonly) NSURL *unzipURL;
@property (strong, nonatomic, readonly) NSURL *unrarURL;



- (id)initWithURL:(NSURL *)fileURL;

- (BOOL)install:(id)object;
- (BOOL)uninstall:(id)object;

- (BOOL)remove:(id)object;
- (BOOL)add:(id)object;


- (NSArray *)createAssetsWith:(NSURL *)fileURL install:(BOOL)install;

- (BOOL)launchKSP;

+ (NSArray *)locateInstallationDirectories;
+ (BOOL)terminateRunningKSP;





@end
