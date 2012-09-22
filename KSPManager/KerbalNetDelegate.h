//
//  KerbalNetDelegate.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/14/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Remote;

@protocol KerbalNetDelegate <NSObject>

@optional

- (void)willBeginNetworkOperationForRemoteAsset:(Remote *)remote;
- (void)didFinishNetworkOperationForRemoteAsset:(Remote *)remote;

- (void)willBeginRefresh;
- (void)didEndRefresh;
@end
