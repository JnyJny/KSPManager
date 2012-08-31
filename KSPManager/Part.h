//
//  Part.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/15/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Asset.h"

@class ConfigFile;

@interface Part : Asset {
    NSMutableDictionary *_configDict;
    ConfigFile *_configFile;
}


@property (strong, nonatomic, readonly) NSString  *partDirectoryName;
@property (strong, nonatomic)              NSURL  *configurationURL;

@property (strong, nonatomic)           NSString  *detail;
@property (strong, nonatomic)           NSString  *module;
@property (strong, nonatomic)           NSString  *name;
@property (strong, nonatomic)           NSString  *desc;
@property (strong, nonatomic)           NSString  *author;
@property (strong, nonatomic)           NSString  *manufacturer;
@property (assign, nonatomic)          NSInteger   category;
@property (strong, nonatomic)           NSString  *categoryName;
@property (assign, nonatomic)          NSInteger   fuel;


- (id)initWithConfigurationFileURL:(NSURL *)cfgURL;

- (BOOL)movePartTo:(NSURL *)destinationDirectoryURL;
- (BOOL)copyPartTo:(NSURL *)destinationDirectoryURL;


+ (NSArray *)inventory:(NSURL *)baseURL;
+ (NSArray *)categoryNames;




@end
