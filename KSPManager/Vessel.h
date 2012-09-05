//
//  Vessel.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/5/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "PersistentObject.h"
#import "Orbit.h"
#import "VesselPart.h"

@interface Vessel : PersistentObject

@property (strong, nonatomic) Orbit *orbit;
@property (strong, nonatomic) NSMutableArray *parts;

@property (strong, nonatomic) NSString *pid;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *sit;
@property (strong, nonatomic) NSString *landed;
@property (strong, nonatomic) NSString *landedAt;
@property (strong, nonatomic) NSString *splashed;
@property (strong, nonatomic) NSString *met;
@property (strong, nonatomic) NSString *lct;
@property (strong, nonatomic) NSString *root;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lon;
@property (strong, nonatomic) NSString *alt;
@property (strong, nonatomic) NSString *hgt;
@property (strong, nonatomic) NSString *nrm;
@property (strong, nonatomic) NSString *rot;
@property (strong, nonatomic) NSString *CoM;
@property (strong, nonatomic) NSString *stg;
@property (strong, nonatomic) NSString *prst;
@property (strong, nonatomic) NSString *eva;

- (void)addOrbit:(NSDictionary *)orbitInfo;
- (void)addPart:(NSDictionary *)partInfo;
@end
