//
//  Line.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/27/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Line : NSString

@property (strong, nonatomic, readonly) NSString *commentToken;
@property (strong, nonatomic, readonly) NSString *assignmentToken;

@property (assign) NSInteger number;

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *comment;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *value;
@property (strong, nonatomic) NSString *bareword;

@end
