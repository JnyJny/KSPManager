//
//  PersistentObject.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/5/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "PersistentObject.h"

@implementation PersistentObject

- (id)initWithOptions:(NSDictionary *)options
{
    if( self = [super init] ) {
        
        if( options ) {
            for(NSString *key in options.allKeys){
                id value = [options valueForKey:key];
                [self setValue:value forKey:key];
            }
        }
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@ no KVO for key %@ value %@ rejected",[self class],key,value);
}
@end
