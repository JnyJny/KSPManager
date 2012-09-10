//
//  PersistentObject.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/5/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSP_Constants.h"
#import "LineToken.h"

@interface PersistentObject : NSObject

@property (strong, nonatomic) NSString *keyword;
@property (strong, nonatomic) NSMutableDictionary *contents;
@property (strong, nonatomic) NSArray *lines;
@property (strong, nonatomic) NSMutableArray *columnInfo;

- (id)init;
- (id)initWithOptions:(NSDictionary *)options;

- (void)setOptions:(NSDictionary *)options;

- (void)addColumnHeader:(NSString *)header forKey:(NSString *)key;
- (NSString *)keyForIndex:(NSInteger)index;
- (NSString *)headerForIndex:(NSInteger)index;

+ (NSString *)keyword;
+ (BOOL)keywordMatch:(NSString *)candidate;



@end
