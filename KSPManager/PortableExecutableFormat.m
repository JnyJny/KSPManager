//
//  PortableExecutableFormat.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/29/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "PortableExecutableFormat.h"

@interface PortableExecutableFormat () {
    IMAGE_DOS_HEADER *_doshdr;
    IMAGE_PE_HEADERS *_pehdr;
}

@property (strong, nonatomic) NSString *rsrcStrings0;
@property (strong, nonatomic) NSString *rsrcStrings1;

@end

@implementation PortableExecutableFormat

@synthesize url = _url;
@synthesize data = _data;

@synthesize rsrcStrings0 = _rsrcStrings0;
@synthesize rsrcStrings1 = _rsrcStrings1;

#ifdef EXPOSED_POINTERS

@synthesize resourceSectionHeader = _resourceSectionHeader;
@synthesize resourceSection = _resourceSection;
@synthesize versionInfo = _versionInfo;
@synthesize stringFileInfo = _stringFileInfo;
@synthesize fixedFileInfo = _fixedFileInfo;
@synthesize sectionHeaders = _sectionHeaders;
#endif

@synthesize fileVersionValue = _fileVersionValue;
@synthesize productVersionValue = _productVersionValue;
@synthesize fileTimestampValue = _fileTimestampValue;
@synthesize fileVersion = _fileVersion;
@synthesize productVersion = _productVersion;
@synthesize fileTimestamp = _fileTimestamp;
@synthesize internalName = _internalName;
@synthesize companyName = _companyName;
@synthesize productName = _productName;
@synthesize fileDescription = _fileDescription;
@synthesize originalFileName = _originalFileName;


- (id)initWithContentsOfURL:(NSURL *)url
{
    if( self = [super init] ){
        self.url = url;
        
        _doshdr = IMAGE_GET_DOS_HEADER(self.data.bytes);
        _pehdr = IMAGE_GET_PE_HEADER(_doshdr);
    }
    return self;
}

#pragma mark -
#pragma mark Properties

- (NSString *)rsrcStrings0
{
    if( _rsrcStrings0 == nil ) {
        _rsrcStrings0 = [[NSString alloc] initWithBytes:self.resourceSection
                                                 length:self.resourceSectionHeader->SizeOfRawData
                                               encoding:NSUTF16StringEncoding];
        
    }
    return _rsrcStrings0;
}

- (NSString *)rsrcStrings1
{
    if( _rsrcStrings1 == nil ) {
        _rsrcStrings1 = [[NSString alloc] initWithBytes:((BYTE *)self.resourceSection) + 1
                                                 length:self.resourceSectionHeader->SizeOfRawData - 1
                                               encoding:NSUTF16StringEncoding];
        
    }
    return _rsrcStrings1;
}


- (NSString *)description
{
 
    return [NSString stringWithFormat:@"PFE url %@ pn %@ pv %@ fn %@ fv %@",
                self.url,
                self.productName,
                self.productVersion,
                self.originalFileName,
                self.fileVersion];

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
        _productVersion = [self resourceValueForKey:kPEStringProductVersion];
    }
    return _productVersion;
}

- (NSString *)fileVersion
{
    if( _fileVersion == nil ) {
        _fileVersion = [self resourceValueForKey:kPEStringFileVersion];
    }
    return _fileVersion;
}

- (NSString *)internalName
{
    if( _internalName == nil ){
        _internalName = [self resourceValueForKey:kPEStringInternalName];
    }
    return _internalName;
}

- (NSString *)companyName
{
    if( _companyName == nil ) {
        _companyName = [self resourceValueForKey:kPEStringCompanyName];
    }
    return _companyName;
}

- (NSString *)productName
{
    if( _productName == nil ) {
        _productName = [self resourceValueForKey:kPEStringProductName];
    }
    return _productName;
}

- (NSString *)fileDescription
{
    if( _fileDescription == nil ) {
        _fileDescription = [self resourceValueForKey:kPEStringFileDescription];
    }
    return _fileDescription;
}

- (NSString *)originalFileName
{
    if( _originalFileName == nil ) {
        _originalFileName = [self resourceValueForKey:kPEStringOriginalFilename];
    }
    return _originalFileName;
}


// resourceValueForKey is a huge nasty hack.
//
// we have two "strings" initialized from _all_ the data in the resource section.
// there are two since i'm not sure what byte alignment is required to build the big
// string WRT UTF16.
//
// Making the huge assumption that the kPEString* strings exist in the resource section,
// we first search rsrcString0 and then rsrcString1
// if we find the key string, we skip over zero bytes until the first non-zero byte
// which is the beginning of the Value UTF16 string.  Unfortunately, we need to know the
// the length of the string before we can turn it into a NSString.  So skip thru the
// string until we find a WORD (2 bytes, thank you MS) worth of zeros.  Do some pointer
// arithmetic to get the length and then create a new NSString for value.  It can all go
// off the rails if any one of the assumptions breaks ( nulls etc ).

- (NSString *)resourceValueForKey:(NSString *)key
{
    BYTE *vStart;
    WORD *vEnd;
    NSUInteger len;
    
    NSRange range = [self.rsrcStrings0 rangeOfString:key];
    
    if( range.location != NSNotFound ) {
        
        vStart = (BYTE *)self.resourceSection + ((range.location + range.length) * sizeof(WORD));
        
        while (1) {
            if( *vStart != 0)
                break;
            vStart++;
        }
        
        vEnd = (WORD *)vStart;
        while(1) {
            if( *vEnd == 0 )
                break;
            vEnd++;
        }

        len = (NSUInteger)( (BYTE *)vEnd - vStart);
#if 0
        NSLog(@"1: vStart %p",vStart);
        NSLog(@"1: vEnd %p",vEnd);
        NSLog(@"len = %lu",len);
#endif

        return [[NSString alloc] initWithBytes:vStart length:len encoding:NSUTF16StringEncoding];
    }
    
    range = [self.rsrcStrings1 rangeOfString:key];
    
    if( range.location != NSNotFound ) {

        vStart = (BYTE *)self.resourceSection + ((range.location+1 + range.length) * sizeof(WORD));
        
        while (1) {
            if( *vStart != 0)
                break;
            vStart++;
        }
        
        vEnd = (WORD *)vStart;
        while(1) {
            if( *vEnd == 0 )
                break;
            vEnd++;
        }
        
        len =  (NSUInteger)((BYTE *)vEnd - vStart);
#if 0
        NSLog(@"2: vStart %p",vStart);
        NSLog(@"2: vEnd %p",vEnd);
        NSLog(@"len = %lu",len);
#endif
        return [[NSString alloc] initWithBytes:vStart-1 length:len encoding:NSUTF16StringEncoding];
    }

    return nil;
}

#pragma mark -
#pragma mark Exposed Pointers


- (NSPointerArray *)sectionHeaders
{
    if( _sectionHeaders == nil ){
    
        NSPointerFunctionsOptions options = NSPointerFunctionsOpaqueMemory | NSPointerFunctionsOpaquePersonality;
            
        _sectionHeaders = [NSPointerArray pointerArrayWithOptions:options];
        
        IMAGE_SECTION_HEADER *sbase = IMAGE_GET_FIRST_SECTION(_pehdr);
        
        for(uint16_t i=0;i<_pehdr->FileHeader.NumberOfSections;i++)
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
        _resourceSection = (BYTE *)_doshdr + self.resourceSectionHeader->PointerToRawData;
    }
    return _resourceSection;
    
}


- (NSUInteger )offsetOfString:(NSString *)string inBuffer:(BYTE *)buffer ofSizeInBytes:(NSUInteger)size
{
    NSString *s0 = [[NSString alloc] initWithBytes:buffer length:size encoding:NSUTF16StringEncoding];
    
    NSRange range = [s0 rangeOfString:string];
    
    if( range.location != NSNotFound )
        return  range.location * sizeof(WORD);

     
    s0 = [[NSString alloc] initWithBytes:buffer+1 length:size-1 encoding:NSUTF16StringEncoding];
        
    range = [s0 rangeOfString:string];
    
    if( range.location != NSNotFound ) {
        range.location += 1;
        range.location *= sizeof(WORD);
    }
    
    return range.location;
}

#define kVersionInfoKey @"VS_VERSION_INFO"

- (VS_VERSIONINFO *)versionInfo
{
    if( _versionInfo == NULL ){
        
        NSUInteger off = [self offsetOfString:kVersionInfoKey
                                     inBuffer:self.resourceSection
                                ofSizeInBytes:self.resourceSectionHeader->SizeOfRawData];
        
        if( off != NSNotFound ) {
            off -= sizeof(WORD) * 3;
            _versionInfo = (VS_VERSIONINFO *)((BYTE *)self.resourceSection + off);
        }
    }
    return _versionInfo;
}

#define kStringFileInfoKey @"StringFileInfo"

- (StringFileInfo *) stringFileInfo
{
    if( _stringFileInfo == NULL ) {
        
        NSUInteger off = [self offsetOfString:kStringFileInfoKey
                                     inBuffer:self.resourceSection
                                ofSizeInBytes:self.resourceSectionHeader->SizeOfRawData];
        
        if( off != NSNotFound ) {
            off -= sizeof(WORD) * 3;
            _stringFileInfo = (StringFileInfo *)((BYTE *)self.resourceSection +off);
        }
        
    }
    return _stringFileInfo;
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



- (NSComparisonResult)compareByProductVersion:(id)target
{
    if( [[target class] isSubclassOfClass:[PortableExecutableFormat class]] == NO){
        NSLog(@"compareByProductVersion:%@ can't act on target.",[target className]);
        return NSOrderedSame;
    }
    
    NSNumber *a = [NSNumber numberWithUnsignedLong:[self productVersionValue]];
    NSNumber *b = [NSNumber numberWithUnsignedLong:[(PortableExecutableFormat *)target productVersionValue]];
    
    return [a compare:b];
}

@end
