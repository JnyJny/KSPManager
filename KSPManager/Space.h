//
//  Space.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/17/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Asset.h"

@interface Space : Asset

@property (strong, nonatomic, readonly) NSURL *configFile;

+ (NSArray *)inventory:(NSURL *)baseURL;
@end
