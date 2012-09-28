//
//  CRAFTObject.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/27/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "CRAFTObject.h"

@implementation CRAFTObject


+ (NSString *)keyword
{
    return [[[self className] stringByReplacingOccurrencesOfString:@"CRAFT" withString:@""] uppercaseString];
}

@end
