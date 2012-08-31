//
//  Line.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/27/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Line.h"

@implementation Line

@synthesize commentToken = _commentToken;
@synthesize assignmentToken = _assignmentToken;
@synthesize number;
@synthesize text = _text;
@synthesize content = _content;
@synthesize comment = _comment;
@synthesize key = _key;
@synthesize value = _value;
@synthesize bareword = _bareword;

- (id)initWithString:(NSString *)string commentToken:(NSString *)cToken assignmentToken:(NSString *)aToken
{
    self = [super init];
    if (self) {
        _commentToken = cToken;
        _assignmentToken = aToken;
        _text = string;
    }
    return self;
}

- (NSString *)comment
{
    if( _comment == nil ){
        
        NSRange range = [self.text rangeOfString:self.commentToken ];
        
        if( range.location != NSNotFound ) {
            NSArray *split = [self.text componentsSeparatedByString:self.commentToken];
            _comment = [split lastObject];
            _content = [split objectAtIndex:0];
        }
    }
    return _comment;
}



+ (NSMutableArray *)linesFromURL:(NSURL *)url
{
    NSMutableArray *lines;
    
    
    
    return lines;
}
@end
