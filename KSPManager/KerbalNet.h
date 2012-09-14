//
//  KerbalNet.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/13/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kKerbalNetKeyModNameperma            @"mod_nameperma"
#define kKerbalNetKeyModAuthor               @"mod_author"
#define kKerbalNetKeyModStatus_reason        @"mod_status_reason"
#define kKerbalNetKeyModReccomended          @"mod_reccomended"
#define kKerbalNetKeyModPageviews_external   @"mod_pageviews_external"
#define kKerbalNetKeyModLastupdate           @"mod_lastupdate"
#define kKerbalNetKeyModCategory             @"mod_category"
#define kKerbalNetKeyModName                 @"mod_name"
#define kKerbalNetKeyModRequired             @"mod_required"
#define kKerbalNetKeyModMirrored             @"mod_mirrored"
#define kKerbalNetKeyModId                   @"mod_id"
#define kKerbalNetKeyModThumbs_down_users    @"mod_thumbs_down_users"
#define kKerbalNetKeyModFeatured             @"mod_featured"
#define kKerbalNetKeyModMinversion           @"mod_minversion"
#define kKerbalNetKeyModVersionhistory       @"mod_versionhistory"
#define kKerbalNetKeyModDirect_download      @"mod_direct_download"
#define kKerbalNetKeyModFiletype             @"mod_filetype"
#define kKerbalNetKeyModLatestversion        @"mod_latestversion"
#define kKerbalNetKeyModDescription          @"mod_description"
#define kKerbalNetKeyModThumbs_up            @"mod_thumbs_up"
#define kKerbalNetKeyModDownloads            @"mod_downloads"
#define kKerbalNetKeyModThumbs_down          @"mod_thumbs_down"
#define kKerbalNetKeyModPageviews            @"mod_pageviews"

@interface KerbalNet : NSObject

@property (strong, nonatomic) NSString *applicationId;
@property (strong, nonatomic) NSString *applicationToken;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;

@property (strong, nonatomic, readonly) NSArray *remoteAssets;

- (id)initWithApplicationID:(NSString *)appID andApplicationToken:(NSString *)appToken;


@end