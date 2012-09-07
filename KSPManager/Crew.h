//
//  Crew.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/5/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "PersistentObject.h"


#define kCrewKeyName         @"name"
#define kCrewKeyBrave        @"brave"
#define kCrewKeyDumb         @"dumb"
#define kCrewKeyBadAzz       @"badS"
#define kCrewKeyState        @"state"
#define kCrewKeyTimeOfDeath  @"ToD"
#define kCrewKeyIdx          @"idx"


// According to Harvester
//0: Available
//1: Assigned (to an ongoing flight)
//2: Dead
//3: Respawning (will become available again when UT reaches ToD)

typedef enum {
    CrewStateAvailable,
    CrewStateAssigned,
    CrewStateDead,
    CrewStateRewspawning
} CrewState;


@interface Crew : PersistentObject
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@end
