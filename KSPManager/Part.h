//
//  Part.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/15/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Asset.h"
#import "ConfigurationParser.h"

@class ConfigurationParser;

#define kPartKeyCoMOffset                  @"CoMOffset"
#define kPartKeyCrewCapacity               @"CrewCapacity"
#define kPartKeyDeployAsLandingGear        @"DeployAsLandingGear"
#define kPartKeyIntakeShape                @"IntakeShape"
#define kPartKeyIsp                        @"Isp"
#define kPartKeyKd                         @"Kd"
#define kPartKeyKi                         @"Ki"
#define kPartKeyKp                         @"Kp"
#define kPartKeyNoCrossFeedNodeKey         @"NoCrossFeedNodeKey"
#define kPartKeyAlphaCutoff                @"alphaCutoff"
#define kPartKeyAngularDrag                @"angularDrag"
#define kPartKeyAngularStrength            @"angularStrength"
#define kPartKeyAnim_decouple_name         @"anim_decouple_name"
#define kPartKeyAnimationName              @"animationName"
#define kPartKeyAttachRules                @"attachRules"
#define kPartKeyAuthor                     @"author"
#define kPartKeyAutoDeployDelay            @"autoDeployDelay"
#define kPartKeyBrakeKey                   @"brakeKey"
#define kPartKeyBreakingForce              @"breakingForce"
#define kPartKeyBreakingTorque             @"breakingTorque"
#define kPartKeyCategory                   @"category"
#define kPartKeyChildStageOffset           @"childStageOffset"
#define kPartKeyClosedDrag                 @"closedDrag"
#define kPartKeyCost                       @"cost"
#define kPartKeyCrashTolerance             @"crashTolerance"
#define kPartKeyCtrlSurfaceArea            @"ctrlSurfaceArea"
#define kPartKeyCtrlSurfaceRange           @"ctrlSurfaceRange"
#define kPartKeyDeflectionLiftCoeff        @"deflectionLiftCoeff"
#define kPartKeyDeployAltitude             @"deployAltitude"
#define kPartKeyDeploySpeed                @"deploySpeed"
#define kPartKeyDescription                @"description"
#define kPartKeyDragCoeff                  @"dragCoeff"
#define kPartKeyDragModelType              @"dragModelType"
#define kPartKeyDryMass                    @"dryMass"
#define kPartKeyEjectionForce              @"ejectionForce"
#define kPartKeyEmptyExplosionPotential    @"emptyExplosionPotential"
#define kPartKeyEngineAccelerationSpeed    @"engineAccelerationSpeed"
#define kPartKeyEngineDecelerationSpeed    @"engineDecelerationSpeed"
#define kPartKeyExhaustDamage              @"exhaustDamage"
#define kPartKeyExplosionPotential         @"explosionPotential"
#define kPartKeyExtensionTime              @"extensionTime"
#define kPartKeyFuel                       @"fuel"
#define kPartKeyFuelConsumption            @"fuelConsumption"
#define kPartKeyFuelCrossFeed              @"fuelCrossFeed"
#define kPartKeyFullExplosionPotential     @"fullExplosionPotential"
#define kPartKeyFullyDeployedDrag          @"fullyDeployedDrag"
#define kPartKeyFx_exhaustFlame_blue       @"fx_exhaustFlame_blue"
#define kPartKeyFx_exhaustFlame_blue_small @"fx_exhaustFlame_blue_small"
#define kPartKeyFx_exhaustFlame_yellow     @"fx_exhaustFlame_yellow"
#define kPartKeyFx_exhaustLight_blue       @"fx_exhaustLight_blue"
#define kPartKeyFx_exhaustLight_yellow     @"fx_exhaustLight_yellow"
#define kPartKeyFx_exhaustSparks_yellow    @"fx_exhaustSparks_yellow"
#define kPartKeyFx_gasBurst_white          @"fx_gasBurst_white"
#define kPartKeyFx_gasJet_white            @"fx_gasJet_white"
#define kPartKeyFx_smokeTrail_light        @"fx_smokeTrail_light"
#define kPartKeyFx_smokeTrail_medium       @"fx_smokeTrail_medium"
#define kPartKeyGimbalRange                @"gimbalRange"
#define kPartKeyHeatConductivity           @"heatConductivity"
#define kPartKeyHeatDissipation            @"heatDissipation"
#define kPartKeyHeatProduction             @"heatProduction"
#define kPartKeyIcon                       @"icon"
#define kPartKeyIconCenter                 @"iconCenter"
#define kPartKeyIntakeResponseSpeed        @"intakeResponseSpeed"
#define kPartKeyIntakeSize                 @"intakeSize"
#define kPartKeyIntakeSuctionPower         @"intakeSuctionPower"
#define kPartKeyInternalFuel               @"internalFuel"
#define kPartKeyLadderAnimationRootName    @"ladderAnimationRootName"
#define kPartKeyLadderColliderName         @"ladderColliderName"
#define kPartKeyLadderRetractAnimationName @"ladderRetractAnimationName"
#define kPartKeyLinPower                   @"linPower"
#define kPartKeyLinearStrength             @"linearStrength"
#define kPartKeyLowerAirflowLimit          @"lowerAirflowLimit"
#define kPartKeyManufacturer               @"manufacturer"
#define kPartKeyMass                       @"mass"
#define kPartKeyMaxIntakePower             @"maxIntakePower"
#define kPartKeyMaxLength                  @"maxLength"
#define kPartKeyMaxTemp                    @"maxTemp"
#define kPartKeyMaxThrust                  @"maxThrust"
#define kPartKeyMaxTorque                  @"maxTorque"
#define kPartKeyMaximumEnginePower         @"maximumEnginePower"
#define kPartKeyMaximumExhaustSpeed        @"maximumExhaustSpeed"
#define kPartKeyMaximum_drag               @"maximum_drag"
#define kPartKeyMesh                       @"mesh"
#define kPartKeyMinAirPressureToOpen       @"minAirPressureToOpen"
#define kPartKeyMinThrust                  @"minThrust"
#define kPartKeyMinimum_drag               @"minimum_drag"
#define kPartKeyMirrorRefAxis              @"mirrorRefAxis"
#define kPartKeyModule                     @"module"
#define kPartKeyName                       @"name"
#define kPartKeyNode_attach                @"node_attach"
#define kPartKeyNode_stack_bottom          @"node_stack_bottom"
#define kPartKeyNode_stack_bottom01        @"node_stack_bottom01"
#define kPartKeyNode_stack_bottom02        @"node_stack_bottom02"
#define kPartKeyNode_stack_bottom03        @"node_stack_bottom03"
#define kPartKeyNode_stack_top             @"node_stack_top"
#define kPartKeyOptimalAirflow             @"optimalAirflow"
#define kPartKeyPhysicsSignificance        @"physicsSignificance"
#define kPartKeyPivotAxis                  @"pivotAxis"
#define kPartKeyPivotingAngle              @"pivotingAngle"
#define kPartKeyRandomSpeedFactor          @"randomSpeedFactor"
#define kPartKeyRescaleFactor              @"rescaleFactor"
#define kPartKeyRetractSpeed               @"retractSpeed"
#define kPartKeyRetractTime                @"retractTime"
#define kPartKeyRimFalloff                 @"rimFalloff"
#define kPartKeyRotPower                   @"rotPower"
#define kPartKeyScale                      @"scale"
#define kPartKeySemiDeployedDrag           @"semiDeployedDrag"
#define kPartKeySound_decoupler_fire       @"sound_decoupler_fire"
#define kPartKeySound_jet_deep             @"sound_jet_deep"
#define kPartKeySound_jet_low              @"sound_jet_low"
#define kPartKeySound_parachute_open       @"sound_parachute_open"
#define kPartKeySound_parachute_single     @"sound_parachute_single"
#define kPartKeySound_rocket_hard          @"sound_rocket_hard"
#define kPartKeySound_servomotor_wav       @"sound_servomotor.wav"
#define kPartKeySound_vent_large           @"sound_vent_large"
#define kPartKeySound_vent_medium          @"sound_vent_medium"
#define kPartKeySound_vent_soft            @"sound_vent_soft"
#define kPartKeySpecPower                  @"specPower"
#define kPartKeyStackSymmetry              @"stackSymmetry"
#define kPartKeyStageOffset                @"stageOffset"
#define kPartKeyStallThreshold             @"stallThreshold"
#define kPartKeySubcategory                @"subcategory"
#define kPartKeyTexture                    @"texture"
#define kPartKeyThrust                     @"thrust"
#define kPartKeyThrustCenter               @"thrustCenter"
#define kPartKeyThrustVector               @"thrustVector"
#define kPartKeyThrustVector0              @"thrustVector0"
#define kPartKeyThrustVector1              @"thrustVector1"
#define kPartKeyThrustVector2              @"thrustVector2"
#define kPartKeyThrustVector3              @"thrustVector3"
#define kPartKeyThrustVectoringCapable     @"thrustVectoringCapable"
#define kPartKeyTitle                      @"title"
#define kPartKeyTrf_anchor_name            @"trf_anchor_name"
#define kPartKeyTrf_animationRoot_name     @"trf_animationRoot_name"
#define kPartKeyTrf_towerPivot_name        @"trf_towerPivot_name"
#define kPartKeyTrf_towerStretch_name      @"trf_towerStretch_name"
#define kPartKeyUpperAirFlowLimit          @"upperAirFlowLimit"
#define kPartKeyUseAGL                     @"useAGL"
#define kPartKeyVacIsp                     @"vacIsp"


@interface Part : Asset <ConfigurationParserDelegate> {
    NSMutableDictionary *_globalContext;
    ConfigurationParser *_parser;
}


@property (strong, nonatomic)              NSURL  *configurationURL;
@property (strong, nonatomic, readonly) NSString  *partDirectoryName;

@property (strong, nonatomic)           NSString  *detail;
@property (strong, nonatomic)           NSString  *module;
@property (strong, nonatomic)           NSString  *desc;
@property (strong, nonatomic)           NSString  *categoryName;


- (id)initWithConfigurationFileURL:(NSURL *)cfgURL;

- (BOOL)movePartTo:(NSURL *)destinationDirectoryURL;
- (BOOL)copyPartTo:(NSURL *)destinationDirectoryURL;

+ (NSArray *)inventory:(NSURL *)baseURL;
+ (NSArray *)categoryNames;




@end
