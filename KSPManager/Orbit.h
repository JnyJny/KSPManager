//
//  Orbit.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/5/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "PersistentObject.h"

@interface Orbit : PersistentObject

@property (strong, nonatomic) NSString *SMA;
@property (strong, nonatomic) NSString *ECC;
@property (strong, nonatomic) NSString *INC;
@property (strong, nonatomic) NSString *LPE;
@property (strong, nonatomic) NSString *LAN;
@property (strong, nonatomic) NSString *MNA;
@property (strong, nonatomic) NSString *EPH;
@property (strong, nonatomic) NSString *REF;
@property (strong, nonatomic) NSString *OBJ;

@end
