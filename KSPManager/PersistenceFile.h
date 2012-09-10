//
//  PersistenceFile.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/5/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigurationParser.h"
#import "Crew.h"
#import "Vessel.h"
#import "VesselPart.h"


@interface PersistenceFile : NSObject <ConfigurationParserDelegate> {
    ConfigurationParser *_parser;
#if 0
    NSMutableArray *_lines;
#endif
}

@property (strong, nonatomic, readonly) NSURL *url;
@property (assign, nonatomic) NSStringEncoding encoding;
@property (strong, nonatomic) NSMutableDictionary *global;
@property (strong, nonatomic) NSMutableArray *crew;
@property (strong, nonatomic) NSMutableArray *vessels;

@property (strong, nonatomic) Vessel     *currentVessel;
@property (strong, nonatomic) VesselPart *currentPart;
@property (strong, nonatomic) Crew       *currentCrew;

- (id)initWithURL:(NSURL *)url;
- (BOOL)writeToURL:(NSURL *)url;

@end
