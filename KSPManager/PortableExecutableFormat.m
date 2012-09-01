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
@synthesize pehdr = _pehdr;

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
        _doshdr = IMAGE_GET_DOS_HEADER(self.data.bytes);
    }
    return _doshdr;
}

- (IMAGE_PE_HEADERS *)pehdr
{
    if( _pehdr == NULL) {
        _pehdr = IMAGE_GET_PE_HEADER(self.doshdr);
    }
    return _pehdr;
}

- (NSUInteger)e_magic
{
    return self.doshdr->e_magic;
}

- (NSUInteger)e_lfanew
{
    return self.doshdr->e_lfanew;
}

- (NSUInteger)signature
{
    return self.pehdr->Signature;
}

- (NSString *)version
{
    if( _version == nil ){
            _version = @"V 1.1 Slippery Snake";
    }
    return _version;
}

@end
