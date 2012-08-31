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
@property (readonly)             BOOL  isInstalled;

- (id)initWithURL:(NSURL *)baseURL;

+ (NSArray *)assetSearch:(NSURL *)baseURL usingBlock:(BOOL (^)(NSString *path))pathTest error:(NSError **)error;
+ (NSArray *)assetSearch:(NSURL *)baseURL usingBlock:(BOOL (^)(NSString *path))pathTest;

@end
