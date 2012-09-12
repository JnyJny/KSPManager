//
//  Ship.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/10/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Asset.h"
#import "ConfigurationParser.h"

@interface Ship : Asset <ConfigurationParserDelegate> {
    ConfigurationParser *_parser;
    NSMutableDictionary *_currentPart;
}

@property (strong,nonatomic, readonly) NSMutableArray *parts;
@property (assign,nonatomic, readonly) BOOL isInSpacePlaneHanger;
@property (assign,nonatomic, readonly) BOOL isInVehicleAssemblyBuilding;

- (id)initWithURL:(NSURL *)url;

+ (NSArray *)inventory:(NSURL *)url;


@end
