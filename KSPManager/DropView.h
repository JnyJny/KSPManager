//
//  ArchiveDropView.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/21/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DropViewDelegate.h"

@interface DropView : NSView


@property (strong, nonatomic) IBOutlet id<DropViewDelegate> delegate;


@end



