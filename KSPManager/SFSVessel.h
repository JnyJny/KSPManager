//
//  SFSVessel.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/26/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "KSPBucket.h"
#import "SFSOrbit.h"
#import "SFSPart.h"


@interface SFSVessel : KSPBucket

@property (strong, nonatomic, readonly) SFSOrbit *orbit;
@property (strong, nonatomic, readonly) NSMutableArray *parts;

- (void)addOrbitWithOptions:(NSDictionary *)options;
- (void)addPartWithOptions:(NSDictionary *)options;
- (void)addPart:(SFSPart *)part;

@end
