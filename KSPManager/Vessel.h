//
//  Vessel.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/5/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "PersistentObject.h"

@interface Vessel : PersistentObject



- (void)addOrbit:(NSDictionary *)orbitInfo;
- (void)addPart:(NSDictionary *)partInfo;
@end
