//
//  Orbit.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/5/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "PersistentObject.h"

@interface Orbit : PersistentObject

@property (strong, nonatomic) NSString *referenceBodyName;
@property (assign, nonatomic,getter = isPilotable) BOOL pilotable;
@property (assign, nonatomic,getter = isDebris) BOOL debris;

+ (NSArray *)referenceBodies;

@end
