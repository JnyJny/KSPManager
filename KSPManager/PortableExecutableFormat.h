//
//  PortableExecutableFormat.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/29/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "pef.h"

@interface PortableExecutableFormat : NSObject

- (id)initWithContentsOfURL:(NSURL *)url;

@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSString *version;
@property (strong, nonatomic) NSData *data;

@end
