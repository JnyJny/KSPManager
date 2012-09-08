//
//  CrewViewController.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/7/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "CrewViewController.h"
#import "Crew.h"

@interface CrewViewController ()

@end

@implementation CrewViewController
@synthesize tableView;
@synthesize crewArrayController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


- (void)awakeFromNib
{

    //pObject is just a template to find out what Headers and keys it will provide to the table.
    
    Crew *crew = [[Crew alloc] init];
    
    // if there aren't enough tableColumns in the tableView, add enough to satisfy this pObject
    
    for(NSInteger i=0;i < crew.columnInfo.count  ; i++ )
        [self.tableView addTableColumn:[[NSTableColumn alloc] initWithIdentifier:[crew keyForIndex:i]]];
    
    
    // next, walk the tableColumns and
    [self.tableView.tableColumns enumerateObjectsUsingBlock:^(NSTableColumn *c,NSUInteger idx,BOOL *stop) {
        
        
        NSString *key = [crew keyForIndex:idx];
        NSString *hdr = [crew headerForIndex:idx];
        
        [c setHidden:NO];
        [c unbind:@"value"];
        [c.headerCell setStringValue:hdr];
        [c.headerCell setFont:[NSFont boldSystemFontOfSize:11.0]];
        [c bind:@"value"
       toObject:self.crewArrayController
    withKeyPath:[@"arrangedObjects." stringByAppendingString:key]
        options:nil];
    }];
    
}

@end
