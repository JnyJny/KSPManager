//
//  CFGObject.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/27/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "CFGObject.h"

@implementation CFGObject

+ (NSString *)keyword
{
    return [[[self className] stringByReplacingOccurrencesOfString:@"CFG" withString:@""] uppercaseString];
}

@end
