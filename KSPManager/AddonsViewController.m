//
//  AddonsViewController.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/11/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "AddonsViewController.h"
#import "Part.h"
#import "Plugin.h"
#import "Ship.h"
#import "DropView.h"

@interface AddonsViewController ()

@end

@implementation AddonsViewController
@synthesize installedArrayController;
@synthesize availableArrayController;
@synthesize installedDropView;
@synthesize availableDropView;
@synthesize installedTableView;
@synthesize availableTableView;
@synthesize addButton;
@synthesize removeButton;
@synthesize actionButton;
@synthesize categoryControl;

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
    
    NSSortDescriptor *titleSort = [NSSortDescriptor sortDescriptorWithKey:@"assetTitle" ascending:YES];
    
    NSSortDescriptor *categorySort = [NSSortDescriptor sortDescriptorWithKey:@"assetCategory" ascending:YES];
    
    NSPredicate *installedFilter = [NSPredicate predicateWithBlock:^BOOL(Asset * evaluatedObject, NSDictionary *bindings) {
        return evaluatedObject.isInstalled;
    }];
    
    NSPredicate *availableFilter = [NSPredicate predicateWithBlock:^BOOL(Asset *evaluatedObject, NSDictionary *bindings) {
        return !evaluatedObject.isInstalled;
    }];
    
    [installedArrayController setFilterPredicate:installedFilter];
    [installedArrayController setSortDescriptors:@[ titleSort, categorySort]];
    
    [availableArrayController setFilterPredicate:availableFilter];
    [availableArrayController setSortDescriptors:@[ titleSort, categorySort]];

}

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark DropViewDelegate Methods

- (void)handleURL:(NSURL *)url fromDropView:(DropView *)dropView
{
    BOOL install = (dropView == self.installedDropView );

    NSArray *assets = [self.ksp createAssetsWith:url install:install];
    
    NSLog(@"assets = %@",assets);
    
    [self.installedTableView deselectAll:self];
    [self.availableTableView deselectAll:self];
    [self.installedArrayController rearrangeObjects];
    [self.availableArrayController rearrangeObjects];
}



#pragma mark -
#pragma mark Actions

- (IBAction)didPushAddButton:(NSButton *)sender
{
    
}

- (IBAction)didPushRemoveButton:(NSButton *)sender
{
    
}

- (IBAction)didPushActionButton:(NSButton *)sender
{
    
}

- (IBAction)controlDidChange:(NSSegmentedControl *)sender
{
 
    NSLog(@"selected %ld",sender.selectedSegment);
    NSString *keyPath = nil;
    
    switch (sender.selectedSegment) {
        case 0:
            keyPath = @"ksp.parts";
            break;
        case 1:
            keyPath = @"ksp.plugins";
            break;
        case 2:
            keyPath = @"ksp.ships";
            break;
            
        default:
            break;
    }
    
#define kKeyContentArray @"contentArray"
    
    [self.availableArrayController unbind:kKeyContentArray];
    [self.installedArrayController unbind:kKeyContentArray];
    
    [self.availableArrayController bind:kKeyContentArray
                               toObject:self
                            withKeyPath:keyPath
                                options:nil];
    
    [self.installedArrayController bind:kKeyContentArray
                               toObject:self
                            withKeyPath:keyPath
                                options:nil];
    
    [self.availableArrayController rearrangeObjects];
    [self.installedArrayController rearrangeObjects];
    
}
@end
