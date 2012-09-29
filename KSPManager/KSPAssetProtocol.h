//
//  KSPAssetProtocol.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/28/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KSPAssetProtocol <NSObject>

- (NSString *)assetTitle;
- (NSString *)assetCategory;
- (NSString *)assetSubcategory;
- (NSString *)assetType;

- (BOOL)isInstalled;
- (BOOL)isAvailable;

- (BOOL)moveTo:(NSURL *)destinationURL;
- (BOOL)copyTo:(NSURL *)destinationURL;
- (BOOL)remove;

+ (NSArray *)inventory:(NSURL *)directory;

@end
