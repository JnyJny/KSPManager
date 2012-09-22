//
//  Remote.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/13/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Asset.h"

typedef enum {
    kRemoteDownloadStatusNotDownloaded,
    kRemoteDownloadStatusDownloading,
    kRemoteDownloadStatusDownloaded,
} RemoteDownLoadStatus;


@interface Remote : Asset


@property (strong, nonatomic, readonly) NSURL *url;
@property (strong, nonatomic, readonly) NSURL *localURL;
@property (assign, nonatomic, readonly) BOOL isDownloaded;
@property (strong, nonatomic, readonly) NSString *cleanDescription;

- (id)initWithOptions:(NSDictionary *)options;

- (BOOL)downloadTo:(NSURL *)localURL;
@end
