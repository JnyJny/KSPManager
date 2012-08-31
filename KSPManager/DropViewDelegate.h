//
//  DropViewDelegate.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/26/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DropView;


@protocol DropViewDelegate <NSObject>

@optional

- (void)handleURL:(NSURL *)url fromDropView:(DropView *)dropView;

@end

