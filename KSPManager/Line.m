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
@synthesize beginDictToken = _beginDictToken;
@synthesize endDictToken = _endDictToken;


@synthesize rawText = _rawText;
@synthesize content = _content;
@synthesize comment = _comment;
@synthesize key = _key;
@synthesize value = _value;
@synthesize bareword = _bareword;
@synthesize lineNumber = _lineNumber;
@synthesize keyValue = _keyValue;

@synthesize optionKeys = _optionKeys;

@synthesize hasComment = _hasComment;
@synthesize hasContent = _hasContent;
@synthesize hasKeyValue = _hasKeyValue;
@synthesize hasBareword = _hasBareword;
@synthesize hasDictBegin = _hasDictBegin;
@synthesize hasDictEnd = _hasDictEnd;
@synthesize isEmpty = _isEmpty;

- (id)initWithString:(NSString *)string withOptions:(NSDictionary *)options
{
    self = [super init];
    if (self) {
        self.rawText = string;
        [self setOptions:options];
    }
    return self;
}

#pragma mark -
#pragma mark Implementation Private Methods

- (void)resetParseState
{
    _isParsed = NO;
    _brokenAssignment = NO;
    _hasDictBegin = NO;
    _hasDictEnd = NO;
    _isEmpty = NO;
    
    _content  = nil;
    _comment  = nil;
    _key      = nil;
    _value    = nil;
    _bareword = nil;
}

- (void)parse
{
    NSRange commentRange;
    NSRange contentRange;
    NSRange keyRange;
    NSRange valRange;
    NSRange range;

    NSCharacterSet *whiteSpaceAndNewLines = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceCharacterSet];
    
    NSString *text;
    
    // first trim whitespace and newline
    text = [self.rawText stringByTrimmingCharactersInSet:whiteSpaceAndNewLines];
    
    if( text.length == 0 ) { // empty line after trimming, nothing to do.
        _isEmpty = YES;
        goto doneParsing;
    }
    
    // next, look for commentTokens in text
    
    commentRange = [text rangeOfString:self.commentToken];
    
    if( commentRange.location != NSNotFound ) {
        // comment found, seperate comment out from content
        if( commentRange.location == 0 ) {
            // comment at beginning of line
            _comment = text;
            goto doneParsing;
        }
        // [_content]commentToken[_comment]

        contentRange.location = 0;
        contentRange.length = commentRange.location - 1;
        commentRange.length = text.length - commentRange.location;

        _content = [[text substringWithRange:contentRange] stringByTrimmingCharactersInSet:whiteSpace];
        _comment = [[text substringWithRange:commentRange] stringByTrimmingCharactersInSet:whiteSpace];
    }
    else {
        // no commentToken found, whole line is content
        _content = text;
    }
    
    // next, parse _content for assignmentToken
    
    valRange = [_content rangeOfString:self.assignmentToken];
    
    if( valRange.location != NSNotFound ) {
        // _content contains an assignment:  [_key]assignmentToken[_value]
        
        
        keyRange.location = 0;
        keyRange.length = valRange.location - 1;

        if ( !valRange.length || !keyRange.length ) {
            // broken assignment missing key:  = value
            NSLog(@"Line: missing key in assignment: %@",text);
            _brokenAssignment = YES;
            goto doneParsing;
        }
        
        valRange.location += self.assignmentToken.length;
        valRange.length = _content.length - valRange.location;
        
        _key   = [[_content substringWithRange:keyRange] stringByTrimmingCharactersInSet:whiteSpace];
        _value = [[_content substringWithRange:valRange] stringByTrimmingCharactersInSet:whiteSpace];
        goto doneParsing;
    }
    
    // no assignmentToken found, check for DICT_BEGIN, DICT_END
    
    range = [_content rangeOfString:self.beginDictToken];
    
    if( range.location != NSNotFound ){
        _hasDictBegin = YES;
        goto doneParsing;
    }
    
    range = [_content rangeOfString:self.endDictToken];
    
    if( range.location != NSNotFound ){
        _hasDictEnd = YES;
        goto doneParsing;
    }
    
    // _content is not assignment, dictBegin or dictEnd, must be bareword
    
    // split _content on whitespace in case it's a multi-word sequence, take the first word
    
    _bareword = [[[_content componentsSeparatedByCharactersInSet:whiteSpace] objectAtIndex:0] stringByTrimmingCharactersInSet:whiteSpace];

doneParsing:
       
    _isParsed = YES;
}

#pragma mark -
#pragma mark Option Handling

- (NSArray *)optionKeys
{
    return @[ kLineOptionCommentTokenKey,
              kLineOptionAssignmentToKey,
              kLineOptionDictBeginTokenKey,
              kLineOptionDictEndTokenKey,
              kLineOptionLineNumberKey ];
}

- (void)setOptions:(NSDictionary *)options
{
    if( options == nil )
        return ;
    
    for(NSString *key in self.optionKeys) {
        id value;
        if( (value = [options valueForKey:key]) != nil )
            [self setValue:value forKey:key];
    }
}


#pragma mark -
#pragma mark Setters

- (void)setCommentToken:(NSString *)commentToken
{
    if( [_commentToken isEqualToString:commentToken] )
        return ;
    
    _commentToken = commentToken;
    [self resetParseState];
}

- (void)setAssignmentToken:(NSString *)assignmentToken
{
    if( [_assignmentToken isEqualToString:assignmentToken] )
        return ;
    
    _assignmentToken = assignmentToken;
    [self resetParseState];
}

- (void)setBeginDictToken:(NSString *)beginDictToken
{
    if( [_beginDictToken isEqualToString:beginDictToken] )
        return;
    
    _beginDictToken = beginDictToken;
    [self resetParseState];
}

- (void)setEndDictToken:(NSString *)endDictToken
{
    if( [_endDictToken isEqualToString:endDictToken] )
        return ;
    
    _endDictToken = endDictToken;
    [self resetParseState];
}

- (void)setRawText:(NSString *)rawText
{
    if( [_rawText isEqualToString:rawText] )
        return ;
    
    _rawText = [rawText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    [self resetParseState];
}

#pragma mark -
#pragma mark Getters

- (NSString *)commentToken
{
    if( _commentToken == nil ) {
        _commentToken = kLineDefaultCommentToken;
    }
    return _commentToken;
}

- (NSString *)assignmentToken
{
    if( _assignmentToken == nil ) {
        _assignmentToken = kLineDefaultAssignmentToken;
    }
    return _assignmentToken;
}

- (NSString *)beginDictToken
{
    if( _beginDictToken == nil ) {
        _beginDictToken = kLineDefaultBeginDictToken;
    }
    return _beginDictToken;
}

- (NSString *)endDictToken
{
    if( _endDictToken == nil ) {
        _endDictToken = kLineDefaultEndDictToken;
    }
    return _endDictToken;
}

- (NSString *)comment
{
    if( _comment == nil ){
        if( _isParsed == NO ) {
            [self parse];
        }
    }
    return _comment;
}

- (BOOL)hasComment
{
    return self.comment != nil;
}

- (NSString *)content
{
    if( _content == nil ) {
        if( _isParsed == NO )
            [self parse];
    }
    return _content;
}

- (BOOL)hasContent
{
    return self.content != nil;
}

- (NSString *)key
{
    if( _key == nil ){
        if( _isParsed == NO )
            [self parse];
    }
    return _key;
}

- (NSString *)value
{
    if( _value == nil ){
        if( _isParsed == NO )
            [self parse];
    }
    return _value;
}

- (BOOL)hasKeyValue
{
    return (self.key!=nil) && (self.value !=nil);
}

- (NSString *)bareword
{
    if( _bareword == nil ) {
        if( _isParsed == NO )
            [self parse];
    }
    return _bareword;
}

- (BOOL)hasBareword
{
    return self.bareword != nil;
}

- (BOOL)hasDictBegin
{
    return _hasDictBegin;
}

- (BOOL)hasDictEnd
{
    return _hasDictEnd;
}

- (BOOL)isEmpty
{
    return _isEmpty;
}

- (NSString *)description
{
    
    NSString *state = [NSString stringWithFormat:@"c:%d kv:%d bw:%d db:%d de:%d e:%d p:%d b:%d ## ",
                       self.hasComment,
                        self.hasKeyValue,
                       self.hasBareword,
                       self.hasDictBegin,
                       self.hasDictEnd,
                       self.isEmpty,
                       _isParsed,
                       _brokenAssignment];
    
    if( self.isEmpty )
        return [state stringByAppendingString:[NSString stringWithFormat:@"%05lu <empty>",self.lineNumber.unsignedIntegerValue]];
    
    if( self.hasDictBegin || self.hasDictEnd || self.hasBareword )
        return [state stringByAppendingString:[NSString stringWithFormat:@"%05lu -%@- c%@c",
                self.lineNumber.unsignedIntegerValue,
                self.content,
                self.comment?self.comment:@""]];
    
    if( self.hasKeyValue )
        return [state stringByAppendingString:[NSString stringWithFormat:@"%05lu k: -%@- v: -%@- c%@c",
                self.lineNumber.unsignedIntegerValue,
                self.key,
                self.value,
                self.comment?self.comment:@""]];

    return [state stringByAppendingString:[NSString stringWithFormat:@"BUSTED %lu: -%@-",self.rawText.length,self.rawText]];
}

- (NSDictionary *)keyValue
{
    if( self.hasKeyValue )
        return @{ self.key:self.value };
    return nil;
}

#pragma mark -
#pragma Class Methods

+ (NSMutableArray *)linesFromURL:(NSURL *)url
{
    NSMutableArray *lines = [[NSMutableArray alloc] init];
    NSCharacterSet *newlines = [NSCharacterSet newlineCharacterSet];
    NSError *error = nil;
    NSStringEncoding encoding;
    
    NSString *fileText = [NSString stringWithContentsOfURL:url
                                                usedEncoding:&encoding
                                                     error:&error];
    if( !fileText ) {
        fileText = [NSString stringWithContentsOfURL:url
                                            encoding:NSISOLatin1StringEncoding
                                               error:&error];
    }
    
    NSArray *fileTextLines = [fileText componentsSeparatedByCharactersInSet:newlines];

    
    for(NSString *fileTextLine in fileTextLines) {
        Line *line = [[Line alloc] initWithString:fileTextLine withOptions:nil];
        line.lineNumber = [NSNumber numberWithUnsignedInteger:[fileTextLines indexOfObject:fileTextLine]];
        [lines addObject:line];
    }
    
    return lines;
}

@end
