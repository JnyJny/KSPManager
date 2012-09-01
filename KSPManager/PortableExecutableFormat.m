//
//  PortableExecutableFormat.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/29/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "PortableExecutableFormat.h"
#import <dlfcn.h>


@implementation PortableExecutableFormat

@synthesize url = _url;
@synthesize data = _data;

@synthesize doshdr = _doshdr;
@synthesize pehdr = _pehdr;

@synthesize sectionHeaders = _sectionHeaders;

@synthesize resourceSectionHeader = _resourceSectionHeader;
@synthesize resourceSection = _resourceSection;

@synthesize fixedFileInfo = _fixedFileInfo;

@synthesize fileVersionValue = _fileVersionValue;
@synthesize productVersionValue = _productVersionValue;
@synthesize fileTimestampValue = _fileTimestampValue;

@synthesize productVersion = _productVersion;
@synthesize fileVersion = _fileVersion;
@synthesize fileTimestamp = _fileTimestamp;


- (id)initWithContentsOfURL:(NSURL *)url
{
    if( self = [super init] ){
        
        self.url = url;
#if 0
        @try {
            if( self.fixedFileInfo->dwFileType != VFT_APP ){
                self = nil;
            }
        }
        @catch (NSException *exception) {
            NSLog(@"Exception! %@",exception);
            self = nil;
        }
#endif
    }
    return self;
}

#pragma mark -
#pragma mark Properties

- (NSString *)description
{
 
    return [NSString stringWithFormat:@"PFE %@ @ %@ magic %04x",
                self.url.lastPathComponent,
                self.productVersion,
                self.doshdr->e_magic];

    
}

- (NSData *)data
{
    if( _data == nil ){
        NSError *error = nil;
        _data = [[NSData alloc] initWithContentsOfURL:self.url options:NSDataReadingMappedIfSafe error:&error];
        if( error ){
            NSLog(@"data getter: %@",error);
        }
    }
    return _data;
    
}

- (IMAGE_DOS_HEADER *)doshdr
{
    if( _doshdr == NULL ) {
        _doshdr = IMAGE_GET_DOS_HEADER(self.data.bytes);
    }
    return _doshdr;
}

- (IMAGE_PE_HEADERS *)pehdr
{
    if( _pehdr == NULL) {
        _pehdr = IMAGE_GET_PE_HEADER(self.doshdr);
    }
    return _pehdr;
}

- (NSPointerArray *)sectionHeaders
{
    if( _sectionHeaders == nil ){
    
        NSPointerFunctionsOptions options = NSPointerFunctionsOpaqueMemory | NSPointerFunctionsOpaquePersonality;
            
        _sectionHeaders = [NSPointerArray pointerArrayWithOptions:options];
        
        IMAGE_SECTION_HEADER *sbase = IMAGE_GET_FIRST_SECTION(self.pehdr);
        
        for(uint16_t i=0;i<self.pehdr->FileHeader.NumberOfSections;i++)
            [_sectionHeaders addPointer:sbase+i];

    }
    return _sectionHeaders;
}

- (IMAGE_SECTION_HEADER *)resourceSectionHeader
{
    if( _resourceSectionHeader == NULL ){

        // XXX this is weak
        
#define kRESOURCE_SECTION_NAME ".rsrc"
        
        for(NSUInteger i=0;i<self.sectionHeaders.count;i++) {
            IMAGE_SECTION_HEADER *shdr = [self.sectionHeaders pointerAtIndex:i];
            if( shdr && strncmp((const char *)shdr->Name, kRESOURCE_SECTION_NAME,strlen(kRESOURCE_SECTION_NAME)) == 0 ){
                _resourceSectionHeader = shdr;
                break;
            }
        }
    }
    return _resourceSectionHeader;
}

- (void *)resourceSection
{
    if( _resourceSection == NULL ){
        _resourceSection = (BYTE *)self.doshdr + self.resourceSectionHeader->PointerToRawData;
    }
    return _resourceSection;
    
}

- (VS_FIXEDFILEINFO *)fixedFileInfo
{
    if( _fixedFileInfo == NULL ) {
        BYTE *buf = (BYTE *)self.resourceSection;
        
        for(NSUInteger i=0;i<self.resourceSectionHeader->SizeOfRawData;i++){
            DWORD *ptr = (DWORD *)(buf+i);
            if( *ptr == VS_FIXEDFILEINFO_SIGNATURE ){
                _fixedFileInfo = (VS_FIXEDFILEINFO *)ptr;
                break;
            }
        }
    }
    return _fixedFileInfo;
}

- (uint64_t)combineMSB:(uint32_t)msb andLSB:(uint32_t)lsb
{
    return ((uint64_t)msb << 32) | ( (uint64_t)lsb & 0x00000000FFFFFFFF );
}

- (uint64_t)fileVersionValue
{
    if( _fileVersionValue == 0 ) {
        _fileVersionValue   = [self combineMSB:self.fixedFileInfo->dwFileVersionMS
                                 andLSB:self.fixedFileInfo->dwFileVersionLS];
    }
    return _fileVersionValue;
}

- (uint64_t)productVersionValue
{
    if( _productVersionValue == 0 ) {
        _productVersionValue = [self combineMSB:self.fixedFileInfo->dwProductVersionMS
                                    andLSB:self.fixedFileInfo->dwProductVersionLS];
    }
    return _productVersionValue;
}

- (uint64_t)fileTimestampValue
{
    if( _fileTimestampValue == 0 ){
        _fileTimestampValue = [self combineMSB:self.fixedFileInfo->dwFileDateMS
                                   andLSB:self.fixedFileInfo->dwFileDateLS];
    }
    return _fileTimestampValue;
}


- (NSString *)productVersion
{
    if( _productVersion == nil ){
        uint64_t value = self.productVersionValue;
        uint16_t *nibbles = (uint16_t *)& value;
        
        _productVersion = [NSString stringWithFormat:@"%d.%d.%d.%d",
                            nibbles[3],
                           nibbles[2],
                           nibbles[1],
                           nibbles[0]];
    }
    return _productVersion;
}



@end
