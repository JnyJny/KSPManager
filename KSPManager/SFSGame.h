//
//  SFSGame.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/26/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "KSPBucket.h"

#import "SFSFlight.h"
#import "SFSEditor.h"
#import "SFSTrackingStation.h"
#import "SFSSpaceCenter.h"
#import "SFSCrew.h"
#import "SFSVessel.h"
#import "SFSPart.h"
#import "SFSModule.h"
#import "SFSScenario.h"

#define kSFSGameKeyVersion     @"version"
#define kSFSGameKeyTitle       @"Title"
#define kSFSGameKeyDescription @"Description"
#define kSFSGameKeyMode        @"Mode"
#define kSFSGameKeyStatus      @"Status"
#define kSFSGameKeyScene       @"Scene"

@interface SFSGame : KSPBucket

@property (strong, nonatomic, readonly) NSMutableArray *parameters;
@property (strong, nonatomic, readonly) NSMutableArray *crew;
@property (strong, nonatomic, readonly) NSMutableArray *vessels;
@property (strong, nonatomic, readonly) SFSScenario *scenario;

@property (strong, nonatomic, readonly) NSString *version;
@property (strong, nonatomic, readonly) NSString *title;
@property (strong, nonatomic, readonly) NSString *Description;
@property (assign, nonatomic, readonly) NSInteger mode;
@property (assign, nonatomic, readonly) NSInteger status;
@property (assign, nonatomic, readonly) NSInteger scene;



- (void)addParameterForKeyword:(NSString *)keyword withOptions:(NSDictionary *)options;
- (void)addScenarioWithOptions:(NSDictionary *)options;
- (void)addCrewWithOptions:(NSDictionary *)options;

- (void)addVesselWithOptions:(NSDictionary *)options;
- (void)addVessel:(SFSVessel *)vessel;

- (void)addOrbitToLastVessel:(NSDictionary *)options;
- (void)addPartToLastVesselWithOptions:(NSDictionary *)options;
- (void)addPartToLastVessel:(SFSPart *)part;


@end
