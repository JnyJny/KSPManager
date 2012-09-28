//
//  CFGPart.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/26/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "CFGPart.h"

@interface CFGPart ()

@property (strong, nonatomic, readwrite) CFGModule *module;

@end

@implementation CFGPart

@synthesize module = _module;


- (void)addModuleWithOptions:(NSDictionary *)options
{
    self.module = [[CFGModule alloc] initWithOptions:options];
}


@end
