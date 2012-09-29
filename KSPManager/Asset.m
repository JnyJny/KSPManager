//
//  Asset.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/27/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Asset.h"



@implementation Asset

@synthesize url = _url;
@synthesize fileManager = _fileManager;
@synthesize assetTitle = _assetTitle;
@synthesize assetCategory = _assetCategory;
@synthesize isInstalled = _isInstalled;
@synthesize isAvailable = _isAvailable;
@synthesize error = _error;

#pragma mark -
#pragma mark LifeCycle

- (id)initWithURL:(NSURL *)url
{
    if( self = [super init] ) {
        self.url = url;
    }
    return self;
}

#pragma mark -
#pragma mark Properties

- (NSFileManager *)fileManager
{
    if( _fileManager == nil ) {
        _fileManager = [NSFileManager defaultManager];
    }
    return _fileManager;
}


- (NSString *)assetTitle
{
    NSLog(@"%@ assetTitle falling back to Asset implementation",self.class);
    return @"assetTitle";
}

- (NSString *)assetCategory
{
    NSLog(@"%@ assetCategory falling back to Asset implementation",self.class);
    return @"assetCategory";
}


- (BOOL)isInstalled
{
    return [self.url.path rangeOfString:kKSPManagedRoot].location == NSNotFound;
}

- (BOOL)isAvailable
{
    return [self.url.path rangeOfString:kKSPManagedRoot].location != NSNotFound;
}



#pragma mark -
#pragma mark Instance Private Methods


#pragma mark -
#pragma mark Instance Methods

// default implementations of moveTo: copyTo: and remove will
// handle the single file asset model.  asset's which manage
// multiple files and/or directories will need to override
// the default methods to get the desired results.

- (BOOL)moveTo:(NSURL *)destinationDirURL
{
    NSError *error = nil;
    NSURL *targetURL;
    
    targetURL = [destinationDirURL URLByAppendingPathComponent:self.url.lastPathComponent];
    
    //xxx need to handle overwriting and file exists conditions
    
    [self.fileManager moveItemAtURL:self.url toURL:targetURL error:&error];
    
    self.error = error;
    if( error )
        return NO;
    
    self.url = targetURL;
    
    return YES;
}

- (BOOL)copyTo:(NSURL *)destinationDirURL
{

    return NO;
}

- (BOOL)remove
{

    return NO;
}


#pragma mark -
#pragma mark Class Methods

+ (NSArray *)assetSearch:(NSURL *)url usingBlock:(BOOL (^)(NSString *path))pathTest
{
   return [self assetSearch:url usingBlock:pathTest error:nil];
}

+ (NSArray *)assetSearch:(NSURL *)url usingBlock:(BOOL (^)(NSString *path))pathTest error:(NSError **)error
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    NSArray *paths = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:url.path
                                                                         error:error];
    
    if( error && (*error != nil))
        return nil;
    
    [paths enumerateObjectsUsingBlock:^(NSString *object,NSUInteger idx, BOOL *stop ){
            if( pathTest(object) == YES)
                [results addObject:object];
     }];

    return results;
}

+ (NSArray *)inventory:(NSURL *)url
{
    NSLog(@"%@ inventory falling back to Asset implementation",self.class);
    return nil;
}

@end
