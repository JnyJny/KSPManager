//
//  SFSGame.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/26/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "SFSGame.h"

@interface SFSGame ()

@property (strong, nonatomic, readwrite) SFSScenario *scenario;

@end

@implementation SFSGame

@synthesize parameters = _parameters;
@synthesize crew = _crew;
@synthesize vessels = _vessels;
@synthesize scenario = _scenario;

@synthesize version = _version;
@synthesize title = _title;
@synthesize Description = _Description;
@synthesize mode = _mode;
@synthesize status = _status;
@synthesize scene = _scene;

#pragma mark -
#pragma mark Properties


- (NSMutableArray *)parameters
{
    if( _parameters == nil ) {
        _parameters = [[NSMutableArray alloc] init];
    }
    return _parameters;
}

- (NSMutableArray *)crew
{
    if( _crew == nil ) {
        _crew = [[NSMutableArray alloc] init];
    }
    return _crew;
}

- (NSMutableArray *)vessels
{
    if( _vessels == nil ) {
        _vessels = [[NSMutableArray alloc] init];
    }
    return  _vessels;
}

- (NSString *)version
{
    if( _version == nil ) {
        _version = [self valueForKey:kSFSGameKeyVersion];
    }
    return _version;
}

- (NSString *)title
{
    if( _title == nil ) {
        _title = [self valueForKey:kSFSGameKeyTitle];
    }
    return _title;
}

- (NSString *)Description
{
    if( _Description == nil ) {
        _Description = [self valueForKey:kSFSGameKeyDescription];
    }
    return _Description;
}

- (NSInteger)mode
{
    NSString *mode = [self valueForKey:kSFSGameKeyMode];
    return mode.integerValue;
}

- (NSInteger)status
{
    NSString *status = [self valueForKey:kSFSGameKeyStatus];
    return status.integerValue;
}

- (NSInteger)scene
{
    NSString *scene = [self valueForKey:kSFSGameKeyScene];
    return scene.integerValue;
}


#pragma mark -
#pragma mark Instance Methods

- (void)addParameterForKeyword:(NSString *)keyword withOptions:(NSDictionary *)options
{
    if( [SFSFlight keywordMatch:keyword] ) {
        [self.parameters addObject:[[SFSFlight alloc] initWithOptions:options]];
        return ;
    }
    
    if( [SFSEditor keywordMatch:keyword] ) {
        [self.parameters addObject:[[SFSEditor alloc] initWithOptions:options]];
        return ;
    }
    
    if( [SFSTrackingStation keywordMatch:keyword] ) {
        [self.parameters addObject:[[SFSTrackingStation alloc] initWithOptions:options]];
        return ;
    }
    
    if( [SFSSpaceCenter keywordMatch:keyword] ) {
        [self.parameters addObject:[[SFSSpaceCenter alloc] initWithOptions:options]];
        return ;
    }
}

- (void)addScenarioWithOptions:(NSDictionary *)options
{
    self.scenario = [[SFSScenario alloc] initWithOptions:options];
}

- (void)addCrewWithOptions:(NSDictionary *)options
{
    [self.crew addObject:[[SFSCrew alloc] initWithOptions:options]];
}

- (void)addVesselWithOptions:(NSDictionary *)options
{

    [self.vessels addObject:[[SFSVessel alloc] initWithOptions:options]];
}

- (void)addVessel:(SFSVessel *)vessel
{
    [self.vessels addObject:vessel];
}

- (void)addOrbitToLastVessel:(NSDictionary *)options
{
    SFSVessel *v = [self.vessels lastObject];
    [v addOrbitWithOptions:options];
}

- (void)addPartToLastVesselWithOptions:(NSDictionary *)options
{
    SFSVessel *v = [self.vessels lastObject];
    [v addPartWithOptions:options];
}

- (void)addPartToLastVessel:(SFSPart *)part
{
    SFSVessel *v = [self.vessels lastObject];
    [v.parts addObject:part];
}

@end
