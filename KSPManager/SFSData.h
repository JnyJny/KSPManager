//
//  SFSData.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/23/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigurationParser.h"

@interface SFSData : NSObject <ConfigurationParserDelegate>

@property (strong, nonatomic) NSURL *baseURL;
@property (assign, nonatomic, getter = isPersistent) BOOL persistent;
@property (assign, nonatomic, getter = isScenario) BOOL scenario;
@property (assign, nonatomic, getter = isTraining) BOOL training;

- (id)initWithContentsOfURL:(NSURL *)sfsSource;


@end
