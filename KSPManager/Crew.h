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
@property (strong, nonatomic) NSString *brave;
@property (strong, nonatomic) NSString *dumb;
@property (strong, nonatomic) NSString *badS;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *ToD;
@property (strong, nonatomic) NSString *idx;

- (id)initWithOptions:(NSDictionary *)options;



@end
