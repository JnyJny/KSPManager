//
//  KerbalNetDelegate.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/14/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KerbalNetDelegate <NSObject>

@optional

- (void)willBeginNetworkOperationWith:(NSURL *)url;
- (void)didFinishNetworkOperaitonWIth:(NSURL *)url andError:(NSError *)error;

- (void)willBeginRefresh;
- (void)didEndRefresh;
@end
