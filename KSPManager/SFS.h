//
//  SFS.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/26/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "BaseConfigurationFile.h"

#import "SFSGame.h"

@interface SFS : BaseConfigurationFile

+ (SFSGame *)gameFromContentsOfURL:(NSURL *)url;


@end
