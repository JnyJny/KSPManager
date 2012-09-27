//
//  BaseConfigurationFile.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/26/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigurationParser.h"

@interface BaseConfigurationFile : NSObject <ConfigurationParserDelegate>

@property (strong, nonatomic, readonly) ConfigurationParser *parser;
@property (strong, nonatomic, readonly) NSURL *url;

- (id)initWithContentsOfURL:(NSURL *)url;

@end
