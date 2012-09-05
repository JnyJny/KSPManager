//
//  Crew.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/5/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "PersistentObject.h"

@interface Crew : PersistentObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *brave;
@property (strong, nonatomic) NSNumber *dumb;
@property (strong, nonatomic) NSNumber *badS;
@property (strong, nonatomic) NSNumber *state;
@property (strong, nonatomic) NSNumber *ToD;
@property (strong, nonatomic) NSNumber *idx;

- (id)initWithOptions:(NSDictionary *)options;

@end
