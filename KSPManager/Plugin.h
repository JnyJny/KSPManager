//
//  Plugin.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/27/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "Asset.h"

@interface Plugin : Asset 

@property (strong, nonatomic, readonly) NSString *installedFileName;
@property (strong, nonatomic, readonly) NSString *availableFileName;
@property (strong, nonatomic, readonly) NSString *version;
@property (strong, nonatomic, readonly) NSString *productName;
@property (strong, nonatomic, readonly) NSString *companyName;



@end
