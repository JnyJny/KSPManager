//
//  Line.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/27/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Line : NSObject {
    BOOL _isParsed;
    BOOL _brokenAssignment;
}

@property (strong, nonatomic) NSString *commentToken;
@property (strong, nonatomic) NSString *assignmentToken;
@property (strong, nonatomic) NSString *beginDictToken;
@property (strong, nonatomic) NSString *endDictToken;
@property (assign, nonatomic) NSNumber *lineNumber;

@property (strong, nonatomic) NSString *rawText;
@property (strong, nonatomic) NSString *comment;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *value;
@property (strong, nonatomic) NSString *bareword;
@property (weak, nonatomic) NSDictionary *keyValue;


@property (strong, nonatomic, readonly) NSArray *optionKeys;

@property (assign, readonly) BOOL hasComment;
@property (assign, readonly) BOOL hasContent;
@property (assign, readonly) BOOL hasKeyValue;
@property (assign, readonly) BOOL hasBareword;
@property (assign, readonly) BOOL hasDictBegin;
@property (assign, readonly) BOOL hasDictEnd;
@property (assign, readonly) BOOL isEmpty;


#define kLineDefaultCommentToken    @"#"
#define kLineDefaultAssignmentToken @"="
#define kLineDefaultBeginDictToken  @"{"
#define kLineDefaultEndDictToken    @"}"

#define kLineOptionCommentTokenKey   @"commentToken"
#define kLineOptionAssignmentToKey   @"assignmentToken"
#define kLineOptionDictBeginTokenKey @"beginDictToken"
#define kLineOptionDictEndTokenKey   @"endDictToken"
#define kLineOptionLineNumberKey     @"lineNumber"

- (void)setOptions:(NSDictionary *)options;

+ (NSMutableArray *)linesFromURL:(NSURL *)url;


@end
