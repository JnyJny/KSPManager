//
//  Asset.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/27/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KSP_Constants.h"

@interface Asset : NSObject

@property (strong, nonatomic) NSURL   *baseURL;
@property (strong, nonatomic) NSError *error;
@property (assign, readonly)  BOOL isInstalled;
@property (assign, readonly)  BOOL isAvailable;

@property (strong, readonly) NSMutableDictionary *global;
@property (strong, readonly) NSMutableArray      *contexts;


@property (strong, nonatomic) NSString *assetTitle;
@property (strong, nonatomic) NSString *assetCategory;

- (id)initWithURL:(NSURL *)baseURL;
- (void)addEntriesFromDictionary:(NSDictionary *)newEntries;

+ (NSArray *)assetSearch:(NSURL *)baseURL usingBlock:(BOOL (^)(NSString *path))pathTest error:(NSError **)error;
+ (NSArray *)assetSearch:(NSURL *)baseURL usingBlock:(BOOL (^)(NSString *path))pathTest;

- (BOOL)moveTo:(NSURL *)destinationDirURL;
- (BOOL)copyTo:(NSURL *)destinationDirURL;
- (BOOL)remove;

@end
