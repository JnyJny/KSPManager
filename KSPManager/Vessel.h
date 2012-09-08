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





@interface Vessel : PersistentObject {
    NSDate *_date;
}

@property (strong, nonatomic) Orbit *orbit;
@property (strong, nonatomic) NSMutableArray *parts;
@property (assign, nonatomic) BOOL isPilotable;
@property (assign, nonatomic) BOOL isDebris;






@end
