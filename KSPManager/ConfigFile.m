//
//  ConfigFile.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/17/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "ConfigFile.h"



@implementation ConfigFile

#pragma mark -
#pragma mark Synthesize

@synthesize fileURL = _fileURL;
@synthesize commentToken = _commentToken;
@synthesize assignmentToken = _assignmentToken;
@synthesize contents = _content;
@synthesize error = _error;

#pragma mark -
#pragma mark Lifecycle

- (id)initWithURL:(NSURL *)fileURL commentToken:(NSString *)cToken assignmentToken:(NSString *)aToken
{
    self = [super init];
    if (self) {
        self.fileURL = fileURL;
        self.commentToken = cToken;
        self.assignmentToken = aToken;
    }
    return self;
}

- (id)initWithURL:(NSURL *)fileURL
{
    return [self initWithURL:fileURL
                commentToken:kCONFIGFILE_COMMENT_TOKEN
             assignmentToken:kCONFIGFILE_ASSIGNMENT_TOKEN];
}

#pragma mark -
#pragma mark Properties

- (NSArray *)contents
{
    if( _content )
        return _content;
    
    NSStringEncoding encoding = NSUTF8StringEncoding;
    NSError *err = nil;
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    
    NSString *rawText = [NSString stringWithContentsOfURL:self.fileURL
                                             usedEncoding:&encoding
                                                    error:&err];
                         
    
    if( rawText == nil ) {
        encoding = NSISOLatin1StringEncoding;
        rawText = [NSString stringWithContentsOfURL:self.fileURL
                                           encoding:encoding
                                              error:&err];
        
        if( rawText == nil ) {
            self.error = err;
            _content = nil;
        }
    }
        
    NSArray *lines = [rawText componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
    for(NSString *line in lines) {
        
        NSString *str = [line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if(str.length == 0)
            continue;
            
        NSRange range = [str rangeOfString:self.commentToken];
        if( range.location != NSNotFound ){
            NSArray *split = [str componentsSeparatedByString:self.commentToken];
            if( split.count != 2)
                continue;
            str = [split objectAtIndex:0];
            
            if( str.length == 0)
                continue;
        }
            
        [tmp addObject:str];
    }
    
    _content = tmp;

    
    return _content;
}

#pragma mark -
#pragma mark Methods

- (NSDictionary *)parse
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceCharacterSet];
    
    NSArray *split;
    NSRange range;
    NSMutableDictionary *subDict = nil;
    NSString *subDictKey = nil;
    
    
    for(NSString *line in self.contents){
        
        range = [line rangeOfString:self.assignmentToken];
        
        if( range.location != NSNotFound ){
            
            split = [line componentsSeparatedByString:self.assignmentToken];
            NSString *keyString = [(NSString *)[split objectAtIndex:0] stringByTrimmingCharactersInSet:whiteSpace];
            NSString *valString = [(NSString *)[split objectAtIndex:1] stringByTrimmingCharactersInSet:whiteSpace];
            
            if( subDict ) {
                [subDict setValue:valString forKey:keyString];
                continue;
            }
            
            [dict setValue:valString forKey:keyString];
            continue;
        }
        
        range = [line rangeOfString:kCONFIGFILE_BEGIN_SUBDICT];
        
        if( range.location != NSNotFound ){
            if( subDictKey == nil )
                continue;
            subDict = [[NSMutableDictionary alloc] init];
            [dict setValue:subDict forKey:subDictKey];
            continue;
        }
         
        range = [line rangeOfString:kCONFIGFILE_END_SUBDICT];
        if( range.location != NSNotFound ){
            subDictKey = nil;
            subDict = nil;
            continue;
        }
        
        split = [line componentsSeparatedByCharactersInSet:whiteSpace];
        for(NSString *s in split)
            if( s.length ) {
                subDictKey = s;
                break;
            }
        
    }
    
    return dict;
}


@end
