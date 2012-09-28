//
//  SFSVessel.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/26/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "CRAFTVessel.h"
#import "SFSOrbit.h"
#import "SFSPart.h"


@interface SFSVessel : CRAFTVessel

@property (strong, nonatomic, readonly) SFSOrbit *orbit;

- (void)addOrbitWithOptions:(NSDictionary *)options;

@end
