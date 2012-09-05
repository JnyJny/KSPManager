//
//  VesselPart.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/5/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "PersistentObject.h"

@interface VesselPart : PersistentObject


@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *parent;
@property (strong, nonatomic) NSString *position;
@property (strong, nonatomic) NSString *rotation;
@property (strong, nonatomic) NSString *mirror;
@property (strong, nonatomic) NSString *istg;
@property (strong, nonatomic) NSString *dstg;
@property (strong, nonatomic) NSString *sqor;
@property (strong, nonatomic) NSString *sidx;
@property (strong, nonatomic) NSString *attm;
@property (strong, nonatomic) NSString *srfN;
@property (strong, nonatomic) NSString *attN; // this is an array
@property (strong, nonatomic) NSString *mass;
@property (strong, nonatomic) NSString *temp;
@property (strong, nonatomic) NSString *expt;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *connected;
@property (strong, nonatomic) NSString *attached;
@property (strong, nonatomic) NSString *crew; // also array
@property (strong, nonatomic) NSString *fuel;
@property (strong, nonatomic) NSString *hasShroud;
@property (strong, nonatomic) NSString *allowFlow;
@property (strong, nonatomic) NSString *lgSt;
@property (strong, nonatomic) NSString *nTime;
@property (strong, nonatomic) NSString *aSpeed;
@property (strong, nonatomic) NSString *qty;
@property (strong, nonatomic) NSString *sym; // another array
@property (strong, nonatomic) NSString *cData;


@end
