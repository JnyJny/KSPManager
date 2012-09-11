//
//  MissionsViewController.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/14/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "MissionsViewController.h"

#import "Crew.h"
#import "Vessel.h"


@interface MissionsViewController ()

@end

@implementation MissionsViewController
@synthesize vesselArrayController;
@synthesize tableSwitchControl;
@synthesize missionTableView;
@synthesize detailTableView;


- (void)awakeFromNib
{
    [self switchTableContent:self.tableSwitchControl];
    

    //pObject is just a template to find out what Headers and keys it will provide to the table.
    
    Vessel *v = [[Vessel alloc] init];
    
    // if there aren't enough tableColumns in the tableView, add enough to satisfy this pObject
    
    for(NSInteger i=0;i < v.columnInfo.count  ; i++ )
        [self.missionTableView addTableColumn:[[NSTableColumn alloc] initWithIdentifier:[v keyForIndex:i]]];


    // next, walk the tableColumns and
    [self.missionTableView.tableColumns enumerateObjectsUsingBlock:^(NSTableColumn *c,NSUInteger idx,BOOL *stop) {
        NSString *key = [v keyForIndex:idx];
        NSString *hdr = [v headerForIndex:idx];
        
        [c setHidden:NO];
        [c unbind:@"value"];
        [c.headerCell setStringValue:hdr];
        [c.headerCell setFont:[NSFont boldSystemFontOfSize:11.0]];
        [c bind:@"value"
         toObject:self.vesselArrayController
      withKeyPath:[@"arrangedObjects." stringByAppendingString:key]
          options:nil];
    }];
    
}


- (IBAction)switchTableContent:(NSSegmentedControl *)sender
{
    if( !self.missionTableView )
        return ;
    
    switch(sender.selectedSegment){
        case 0:
            self.vesselArrayController.filterPredicate = nil;
            break;
        case 1:
            self.vesselArrayController.filterPredicate = [NSPredicate predicateWithBlock:^BOOL(Vessel *vessel, NSDictionary *bindings){return vessel.isPilotable;}];
            break;
        case 2:
            self.vesselArrayController.filterPredicate = [NSPredicate predicateWithBlock:^BOOL(Vessel *vessel, NSDictionary *bindings){return vessel.isDebris;}];
            break;
    }
}

- (IBAction)didPushAdd:(id)sender {
}

- (IBAction)didPushRemove:(id)sender {
}

- (IBAction)didPushAction:(id)sender {
}

@end
