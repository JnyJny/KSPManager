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
    NSInteger n = pObject.columnHeaders.count - self.tableView.tableColumns.count;

    NSLog(@"n = %ld ( %ld - %ld )",n, pObject.columnHeaders.count, self.tableView.tableColumns.count);
    
    for(NSInteger i=0;i < n ; i++ )
        [self.tableView addTableColumn:[[NSTableColumn alloc] initWithIdentifier:[pObject.columnHeaders.allValues objectAtIndex:i]]];

    [self.tableView.tableColumns enumerateObjectsUsingBlock:^(NSTableColumn *c,NSUInteger idx,BOOL *stop) {

        if( idx >= pObject.columnHeaders.count) {
            [c setHidden:YES];
            return ;
        }

        NSString *key = [pObject.columnOrder valueForKey:[NSString stringWithFormat:@"%lu",idx]];
        NSString *hdr = [pObject.columnHeaders valueForKey:key];
        
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

            predicate = [NSPredicate predicateWithFormat:@"%K == '%d'",kVesselOrbitKeyObjectType,kOrbitObjectTypePilotable];
            
            break;
        case MissionTableOptionDebris:
            predicate = [NSPredicate predicateWithFormat:@"%K == '%d'",kVesselOrbitKeyObjectType,kOrbitObjectTypeDebris];


            break;
        default:
            break;
    }
    
    NSLog(@"filter = %@",predicate);
    
    //    [self.vesselArrayController setFilterPredicate:predicate];
    
    [self configureTableViewWithArrayController:self.vesselArrayController
                            forPersistentObject:tmp];
}

- (void)configureTableForCrew
{
 
    Crew *tmp = [[Crew alloc] init];
    
    [self configureTableViewWithArrayController:self.crewArrayController
                            forPersistentObject:tmp];
    

}

- (IBAction)switchTableContent:(NSSegmentedControl *)sender
{
    
    if( !self.tableView )
        return ;
    
    switch(sender.selectedSegment){
        case 0:
            NSLog(@"vehicles");
            [self configureTableForVesselsWithOption:MissionTableOptionPilotable];
            break;
        case 1:
            NSLog(@"crew");
            [self configureTableForCrew];
            break;
        case 2:
            NSLog(@"debris");
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
