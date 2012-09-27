//
//  Ship.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/10/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Asset.h"


@interface Ship : Asset

@property (strong,nonatomic, readonly) NSMutableArray *parts;
@property (strong,nonatomic) NSString *hanger;
@property (assign,nonatomic, readonly) BOOL isInSpacePlaneHanger;
@property (assign,nonatomic, readonly) BOOL isInVehicleAssemblyBuilding;

- (id)initWithURL:(NSURL *)url;

+ (NSArray *)inventory:(NSURL *)url;


@end
