//
//  CRAFTPart.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/26/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "CRAFTObject.h"
#import "CRAFTModule.h"

@class Part;

@interface CRAFTPart : CRAFTObject

@property (strong, nonatomic, readonly) CRAFTModule *module;
@property (strong, nonatomic) Part *definition;
@property (strong, nonatomic, readonly) NSString *name;
@property (assign, nonatomic, readonly) NSInteger pid;


- (void)addModuleWithOptions:(NSDictionary *)options;

@end
