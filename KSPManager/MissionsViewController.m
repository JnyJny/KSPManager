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
@synthesize crewArrayController;
@synthesize tableSwitchControl;
@synthesize tableView;


- (void)awakeFromNib
{
    
    //    NSLog(@"Crew = %@",self.ksp.persistenceFile.crew);
    //    NSLog(@"Vessels = %@",self.ksp.persistenceFile.vessels);
    
    
    //    [self.vesselArrayController setFilterPredicate:[NSPredicate predicateWithFormat:@""]];
    
    
    [self switchTableContent:self.tableSwitchControl];
}

typedef enum {
    MissionTableOptionAll,
    MissionTableOptionPilotable,
    MissionTableOptionDebris
} MissionTableConfigureOptions;


- (void)configureTableViewWithArrayController:(NSArrayController *)arrayController forPersistentObject:(PersistentObject *)pObject
{
    //pObject is just a template to find out what Headers and keys it will provide to the table.
    
    NSInteger n = pObject.columnInfo.count - self.tableView.tableColumns.count;
    
    // if there aren't enough tableColumns in the tableView, add enough to satisfy this pObject
    
    for(NSInteger i=0;i < n ; i++ )
        [self.tableView addTableColumn:[[NSTableColumn alloc] initWithIdentifier:[pObject keyForIndex:i]]];


    // next, walk the tableColumns and
    [self.tableView.tableColumns enumerateObjectsUsingBlock:^(NSTableColumn *c,NSUInteger idx,BOOL *stop) {

        if( idx >= pObject.columnInfo.count) {
            // hide them and remove their bindings if we don't need them
            //            [c setHidden:YES];
            [c unbind:@"value"];
            return ;
        }
        
        // pObject will supply us with a header string and a key path
        
        NSString *key = [pObject keyForIndex:idx];
        NSString *hdr = [pObject headerForIndex:idx];
        
        [c setHidden:NO];
        [c unbind:@"value"];
        [c.headerCell setStringValue:hdr];
        [c.headerCell setFont:[NSFont boldSystemFontOfSize:11.0]];
        [c bind:@"value"
         toObject:arrayController
      withKeyPath:[NSString stringWithFormat:@"arrangedObjects.%@",key]
          options:nil];

    }];
    
}



- (void)configureTableForVesselsWithOption:(MissionTableConfigureOptions )option
{
    Vessel * tmp = [[Vessel alloc] init];
    NSPredicate *predicate;


    
    switch (option) {
        case MissionTableOptionAll:
            predicate = nil;
            break;
        case MissionTableOptionPilotable:
            predicate = [NSPredicate predicateWithBlock:^BOOL(PersistentObject *evaluatedObject, NSDictionary *bindings) {
                return ((Vessel *)evaluatedObject).isPilotable;
            }];

            break;
        case MissionTableOptionDebris:
            predicate = [NSPredicate predicateWithBlock:^BOOL(PersistentObject *evaluatedObject, NSDictionary *bindings) {
                return ((Vessel *)evaluatedObject).isDebris;
            }];
            break;
        default:
            break;
    }
    
    
    [self.vesselArrayController setFilterPredicate:predicate];
    [self.vesselArrayController rearrangeObjects];
    
    [self configureTableViewWithArrayController:self.vesselArrayController
                            forPersistentObject:tmp];
}

- (IBAction)switchTableContent:(NSSegmentedControl *)sender
{
    if( !self.tableView )
        return ;
    
    switch(sender.selectedSegment){
        case 0:
            [self configureTableForVesselsWithOption:MissionTableOptionPilotable];
            break;
        case 1:
            NSLog(@"crew = %@",self.ksp.persistenceFile.crew);
            [self configureTableViewWithArrayController:self.crewArrayController
                                    forPersistentObject:[[Crew alloc] init]];
            break;
        case 2:
            [self configureTableForVesselsWithOption:MissionTableOptionDebris];
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
