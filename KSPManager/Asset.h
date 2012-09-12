//
//  Asset.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/27/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KSP_Constants.h"

@interface Asset : NSObject {
    NSMutableDictionary *_global;
}

@property (strong, nonatomic) NSURL   *baseURL;
@property (strong, nonatomic) NSError *error;
@property (assign, readonly)  BOOL isInstalled;
@property (assign, readonly)  BOOL isAvailable;

@property (strong, nonatomic) NSString *assetTitle;
@property (strong, nonatomic) NSString *assetCategory;

- (id)initWithURL:(NSURL *)baseURL;

+ (NSArray *)assetSearch:(NSURL *)baseURL usingBlock:(BOOL (^)(NSString *path))pathTest error:(NSError **)error;
+ (NSArray *)assetSearch:(NSURL *)baseURL usingBlock:(BOOL (^)(NSString *path))pathTest;

@end
