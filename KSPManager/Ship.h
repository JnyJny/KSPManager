//
//  Ship.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/10/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigurationParser.h"

@interface Ship : NSObject <ConfigurationParserDelegate> {
    ConfigurationParser *_parser;
    NSMutableDictionary *_currentPart;
}

@property (strong,nonatomic) NSURL *url;
@property (strong,nonatomic, readonly) NSMutableArray *parts;
@property (assign,nonatomic, readonly) BOOL isInSpacePlaneHanger;
@property (assign,nonatomic, readonly) BOOL isInVehicleAssemblyBuilding;

- (id)initWithURL:(NSURL *)url;



@end
