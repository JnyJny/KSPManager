//
//  CRAFT.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/26/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "BaseConfigurationFile.h"
#import "SFSVessel.h"

@interface CRAFT : BaseConfigurationFile

+ (CRAFTVessel *)vesselForContentsOfURL:(NSURL *)url;

@end
