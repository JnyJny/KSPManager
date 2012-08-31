//
//  ConfigFile.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/17/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCONFIGFILE_COMMENT_TOKEN    @"//"
#define kCONFIGFILE_ASSIGNMENT_TOKEN @"="
#define kCONFIGFILE_BEGIN_SUBDICT    @"{"
#define kCONFIGFILE_END_SUBDICT      @"}"

@interface ConfigFile : NSMutableDictionary

@property (strong, nonatomic) NSURL *fileURL;
@property (strong, nonatomic) NSString *commentToken;
@property (strong, nonatomic) NSString *assignmentToken;
@property (strong, nonatomic) NSArray  *contents;
@property (strong, nonatomic) NSError  *error;

- (id)initWithURL:(NSURL *)fileURL commentToken:(NSString *)cToken assignmentToken:(NSString *)aToken;
- (id)initWithURL:(NSURL *)fileURL;

- (NSDictionary *)parse;


@end
