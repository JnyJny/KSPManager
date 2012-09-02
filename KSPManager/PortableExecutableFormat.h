//
//  PortableExecutableFormat.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/29/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "pe.h"
#import "msve.h"

@interface PortableExecutableFormat : NSObject {

}

- (id)initWithContentsOfURL:(NSURL *)url;

@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic, readonly) NSString *productVersion;
@property (strong, nonatomic, readonly) NSString *fileVersion;
@property (strong, nonatomic, readonly) NSString *fileTimestamp;
@property (strong, nonatomic) NSData *data;

@property (assign, readonly) IMAGE_DOS_HEADER *doshdr;
@property (assign, readonly) IMAGE_PE_HEADERS *pehdr;
@property (assign, readonly) IMAGE_SECTION_HEADER *resourceSectionHeader;
@property (assign, readonly) VS_VERSIONINFO *versionInfo;
@property (assign, readonly) void *resourceSection;
@property (assign, readonly) VS_FIXEDFILEINFO *fixedFileInfo;

@property (strong, readonly) NSPointerArray *sectionHeaders;

@property (assign, readonly) uint64_t fileVersionValue;
@property (assign, readonly) uint64_t productVersionValue;
@property (assign, readonly) uint64_t fileTimestampValue;


@end
