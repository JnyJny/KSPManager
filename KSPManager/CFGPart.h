//
//  CFGPart.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/26/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "CFGObject.h"
#import "CFGModule.h"
@interface CFGPart : CFGObject

@property (strong, nonatomic, readonly) CFGModule *module;

- (void)addModuleWithOptions:(NSDictionary *)options;

@end
