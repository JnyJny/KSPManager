//
//  PersistentObject.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/5/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Line.h"

@interface PersistentObject : NSObject

@property (strong, nonatomic) NSString *keyword;
@property (strong, nonatomic) NSMutableDictionary *contents;
@property (strong, nonatomic) NSArray *contentKeys;
@property (strong, nonatomic) NSArray *lines;
@property (strong, nonatomic) NSMutableDictionary *columnHeaders;
@property (strong, nonatomic) NSMutableDictionary *columnOrder;

- (id)init;
- (id)initWithOptions:(NSDictionary *)options;
- (void)setOptions:(NSDictionary *)options;

+ (NSString *)keyword;
+ (BOOL)keywordMatch:(NSString *)candidate;

@end
