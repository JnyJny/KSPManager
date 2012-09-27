//
//  SFSPart.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/26/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "SFSPart.h"

@interface SFSPart ()

@property (strong, nonatomic, readwrite) SFSModule *module;

@end

@implementation SFSPart

- (void)addModuleWithOptions:(NSDictionary *)options
{
    self.module = [[SFSModule alloc] initWithOptions:options];
}

@end
