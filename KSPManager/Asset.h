//
//  Asset.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/27/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "KSPBucket.h"
#import "KSP_Constants.h"

@interface Asset : KSPBucket

@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic,readonly) NSFileManager *fileManager;

@property (strong, nonatomic) NSString *assetTitle;
@property (strong, nonatomic) NSString *assetCategory;
@property (assign, readonly)  BOOL isInstalled;
@property (assign, readonly)  BOOL isAvailable;
@property (strong, nonatomic) NSError *error;

- (id)initWithURL:(NSURL *)url;

- (BOOL)moveTo:(NSURL *)destinationDirURL;
- (BOOL)copyTo:(NSURL *)destinationDirURL;
- (BOOL)remove;

+ (NSArray *)assetSearch:(NSURL *)url usingBlock:(BOOL (^)(NSString *path))pathTest error:(NSError **)error;
+ (NSArray *)assetSearch:(NSURL *)url usingBlock:(BOOL (^)(NSString *path))pathTest;
+ (NSArray *)inventory:(NSURL *)url;
@end
