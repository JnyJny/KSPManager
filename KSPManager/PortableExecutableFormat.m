//
//  PortableExecutableFormat.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/29/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "PortableExecutableFormat.h"
#import <dlfcn.h>


@implementation PortableExecutableFormat

@synthesize url = _url;
@synthesize data = _data;
@synthesize doshdr = _doshdr;
@synthesize nthdr = _nthdr;

@synthesize version = _version;
@synthesize e_magic = _e_magic;
@synthesize e_lfanew = _e_lfanew;
@synthesize signature = _signature;

- (id)initWithContentsOfURL:(NSURL *)url
{
    if( self = [super init] ){
        
        self.url = url;
        
    
    }
    return self;
}

#pragma mark -
#pragma mark Properties

- (NSString *)description
{
 
    return [NSString stringWithFormat:@"PLUGIN %@ @ %@ ",self.url.lastPathComponent,self.version];
    
}

- (NSData *)data
{
    if( _data == nil ){
        NSError *error = nil;
        
        _data = [[NSData alloc] initWithContentsOfURL:self.url options:NSDataReadingMappedIfSafe error:&error];
        
        if( error ){
            NSLog(@"data getter: %@",error);
        }
        
        _doshdr = (IMAGE_DOS_HEADER *)self.data.bytes;
        _e_magic = _doshdr->e_magic;
        _e_lfanew = _doshdr->e_lfanew;
        
    }
    return _data;
    
}

- (IMAGE_DOS_HEADER *)doshdr
{
    if( _doshdr == NULL ) {
        NSRange range = { 0x0, sizeof(IMAGE_DOS_HEADER) };

        _doshdr = malloc(range.length);
        
        [self.data getBytes:_doshdr range:range];
    }
    return _doshdr;
}

- (IMAGE_NT_HEADER *)nthdr
{
    if( _nthdr == NULL) {
        NSRange range = { self.e_lfanew, sizeof(IMAGE_NT_HEADER) };
        _nthdr = calloc(1,range.length);
        [self.data getBytes:_nthdr range:range];
    }
    return _nthdr;
}

- (NSUInteger)e_magic
{
    NSRange range = {0x0,2};
    [self.data getBytes:&_e_magic range:range];
    
    return _e_magic;
}

- (NSUInteger)e_lfanew
{
    NSRange range = { 0x3c, 4 };
    [self.data getBytes:&_e_lfanew range:range];
    return _e_lfanew;
}

- (NSUInteger)signature
{
    return self.nthdr->Signature;
}

- (NSString *)version
{
    if( _version == nil ){
            _version = @"V 1.1 Slippery Snake";
    }
    return _version;
}

@end
