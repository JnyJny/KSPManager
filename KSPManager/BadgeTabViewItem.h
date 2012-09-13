//
//  BadgeTabViewItem.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/13/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BadgeTabViewItem : NSTabViewItem

@property (strong, nonatomic) NSImage *badge;
@property (assign, nonatomic) BOOL showBadge;
@property (strong, nonatomic) NSString *badgeLabel;

@end
