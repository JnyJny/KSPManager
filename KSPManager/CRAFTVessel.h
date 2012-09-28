//
//  CRAFTVessel.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/26/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "CRAFTObject.h"
#import "CRAFTPart.h"


@interface CRAFTVessel : CRAFTObject

@property (strong, nonatomic, readonly) NSMutableArray *parts;

- (void)addPartWithOptions:(NSDictionary *)options;

- (void)addPart:(id)part;


@end
