//
//  PortableExecutableFormat.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/29/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "pe.h"
#import "msve.h"

@interface PortableExecutableFormat : NSObject {

}

- (id)initWithContentsOfURL:(NSURL *)url;

@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSString *version;
@property (strong, nonatomic) NSData *data;

@property (assign, readonly) IMAGE_DOS_HEADER *doshdr;
@property (assign, readonly) IMAGE_PE_HEADERS *pehdr;

@property (assign, readonly) NSUInteger e_magic;
@property (assign, readonly) NSUInteger e_lfanew;
@property (assign, readonly) NSUInteger signature;

@end
