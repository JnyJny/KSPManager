//
//  SFSObject.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/26/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSPBucket : NSObject

@property (strong, nonatomic) NSMutableDictionary *options;

- (id)initWithOptions:(NSDictionary *)options;

- (void)addEntriesFromDictionary:(NSDictionary *)otherDictionary;

+ (NSString *)keyword;
+ (BOOL)keywordMatch:(NSString *)candidate;
- (NSArray *)allKeys;
- (NSArray *)allValues;
@end
