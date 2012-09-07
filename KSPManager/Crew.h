//
//  Crew.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/5/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "PersistentObject.h"

@interface Crew : PersistentObject
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@end
