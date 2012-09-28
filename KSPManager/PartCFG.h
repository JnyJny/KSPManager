//
//  PartCFG.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/27/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "CFG.h"
#import "CFGPart.h"

@interface PartCFG : CFG

@property (strong, nonatomic, readonly) CFGPart *part;

+ (CFGPart *)partForContentsOfURL:(NSURL *)url;

@end
