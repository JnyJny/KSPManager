//
//  SFSObject.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/27/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "SFSObject.h"

@implementation SFSObject

+ (NSString *)keyword
{
    return [[[self className] stringByReplacingOccurrencesOfString:@"SFS" withString:@""] uppercaseString];
}

@end
