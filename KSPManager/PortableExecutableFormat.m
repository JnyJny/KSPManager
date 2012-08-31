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
@synthesize version = _version;

- (id)initWithContentsOfURL:(NSURL *)url
{
    if( self = [super init] ){
        
        self.url = _url;
        

        void *dll = dlopen([self.url.path cStringUsingEncoding:NSStringEncodingConversionAllowLossy],RTLD_LAZY);
    
        NSLog(@"dll is %@",(dll)?@"good":@"nil");
    
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
        
        
    }
    return _data;
    
}

- (NSString *)version
{
    if( _version == nil ){
            _version = @"V 1.1 Slippery Snake";
    }
    return _version;
}

@end
