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


#define kPEStringInternalName     @"InternalName"
#define kPEStringFileVersion      @"FileVersion"
#define kPEStringCompanyName      @"CompanyName"
#define kPEStringProductName      @"ProductName"
#define kPEStringProductVersion   @"ProductVersion"
#define kPEStringFileDescription  @"FileDescription"
#define kPEStringOriginalFilename @"OriginalFilename"


@interface PortableExecutableFormat : NSObject {
    NSString         *_rsrcStrings0;
    NSString         *_rsrcStrings1;

}

- (id)initWithContentsOfURL:(NSURL *)url;

@property (strong, nonatomic) NSURL *url;
@property (assign, readonly) uint64_t fileVersionValue;
@property (assign, readonly) uint64_t productVersionValue;
@property (assign, readonly) uint64_t fileTimestampValue;
@property (strong, readonly) NSDate   *fileTimestamp;
@property (strong, readonly) NSString *internalName;
@property (strong, readonly) NSString *fileVersion;
@property (strong, readonly) NSString *companyName;
@property (strong, readonly) NSString *productName;
@property (strong, readonly) NSString *productVersion;
@property (strong, readonly) NSString *fileDescription;
@property (strong, readonly) NSString *originalFileName;

@property (strong, nonatomic) NSData *data;

#define EXPOSED_POINTERS
#ifdef EXPOSED_POINTERS


@property (assign, readonly) IMAGE_SECTION_HEADER *resourceSectionHeader;
@property (assign, readonly) void *resourceSection;
@property (assign, readonly) VS_VERSIONINFO *versionInfo;
@property (assign, readonly) StringFileInfo *stringFileInfo;
@property (assign, readonly) VS_FIXEDFILEINFO *fixedFileInfo;
@property (strong, readonly) NSPointerArray *sectionHeaders;
#endif







@end
