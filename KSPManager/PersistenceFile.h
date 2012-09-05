//
//  Mission.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/5/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersistenceFile : NSObject {
    NSMutableArray *_lines;
}

@property (strong, nonatomic, readonly) NSURL *url;
@property (strong, nonatomic) NSMutableDictionary *options;
@property (strong, nonatomic) NSMutableArray *crew;
@property (strong, nonatomic) NSMutableArray *vessels;

- (id)initWithURL:(NSURL *)url;
- (void)parseLines;

@end
