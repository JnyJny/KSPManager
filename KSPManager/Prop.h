//
//  Prop.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/17/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Asset.h"

@interface Prop : Asset

@property (strong,nonatomic,readonly) NSURL *configURL;

+ (NSArray *)inventory:(NSURL *)targetDir;

@end
