//
//  SFSPart.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/26/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "KSPBucket.h"
#import "SFSModule.h"

@interface SFSPart : KSPBucket

@property (strong, nonatomic, readonly) SFSModule *module;

- (void)addModuleWithOptions:(NSDictionary *)options;

@end
