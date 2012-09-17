//
//  UtilityViewController.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/16/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "UtilityViewController.h"

@interface UtilityViewController ()

@end

@implementation UtilityViewController

@synthesize graphicsQualityIndicator;
@synthesize fullScreenCheckBox;
@synthesize heightComboBox;
@synthesize widthComboBox;
@synthesize linkCheckBox;
@synthesize graphicsQuality;
@synthesize deletePrefsButton;
@synthesize yesIUnderstandButton;
@synthesize userPrefs = _userPrefs;
@synthesize linkScreenDimensions = _linkScreenDimensions;


- (void)awakeFromNib
{
    
    [self.fullScreenCheckBox setState:self.isFullScreenMode];
    [self.heightComboBox addItemWithObjectValue:[NSNumber numberWithInteger:self.screenHeight]];
    [self.heightComboBox selectItemAtIndex:0];
    [self.widthComboBox addItemWithObjectValue:[NSNumber numberWithInteger:self.screenWidth]];
    [self.widthComboBox selectItemAtIndex:0];
    [self.graphicsQualityIndicator setIntegerValue:self.graphicsQuality];

    [self addObserver:self
           forKeyPath:@"userPrefs"
              options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
              context:nil];

    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if( object == self.userPrefs ) {
        [self.userPrefs writeToURL:self.ksp.userPreferencesPlist atomically:YES];
        NSLog(@"userPrefs = %@",self.userPrefs);
        return ;
    }
    
}

- (NSMutableDictionary *)userPrefs
{
    if( _userPrefs == nil ) {
        _userPrefs = [NSMutableDictionary dictionaryWithContentsOfURL:self.ksp.userPreferencesPlist];
        NSLog(@"userPrefs = %@",_userPrefs);
    }
    return _userPrefs;
}

- (void)setFullScreenMode:(BOOL)fullScreenMode
{
    [self.userPrefs setValue:[NSNumber numberWithBool:fullScreenMode]
                      forKey:kKSPPreferencesKeyIsFullscreenMode];
    [self.userPrefs writeToURL:self.ksp.userPreferencesPlist atomically:YES];
}

- (BOOL)isFullScreenMode
{
    NSNumber *mode = [self.userPrefs valueForKey:kKSPPreferencesKeyIsFullscreenMode];
    if( mode )
        return mode.boolValue;
    return NO;
}

- (void)setScreenHeight:(NSInteger)screenHeight
{
    [self.userPrefs setValue:[NSNumber numberWithInteger:screenHeight] forKey:kKSPPreferencesKeyResolutionHeight];
    [self.userPrefs writeToURL:self.ksp.userPreferencesPlist atomically:YES];
}

- (NSInteger)screenHeight
{
    NSNumber *sh = [self.userPrefs valueForKey:kKSPPreferencesKeyResolutionHeight];
    
    if( sh )
        return sh.integerValue;
    return -1;
}

- (void)setScreenWidth:(NSInteger)screenWidth
{
    [self.userPrefs setValue:[NSNumber numberWithInteger:screenWidth] forKey:kKSPPerferencesKeyResolutionWidth];
    [self.userPrefs writeToURL:self.ksp.userPreferencesPlist atomically:YES];
}

- (NSInteger)screenWidth
{
    NSNumber *sw = [self.userPrefs valueForKey:kKSPPerferencesKeyResolutionWidth];
    if( sw )
        return sw.integerValue;
    return -1;
}


- (void)setGraphicsQuality:(NSInteger)gQ
{
    [self.userPrefs setValue:[NSNumber numberWithInteger:gQ] forKey:kKSPPreferencesKeyGraphicsQuality];
    [self.userPrefs writeToURL:self.ksp.userPreferencesPlist atomically:YES];
}

- (NSInteger)graphicsQuality
{
    NSNumber *gq = [self.userPrefs valueForKey:kKSPPreferencesKeyGraphicsQuality];
    if( gq == nil ) {
        self.graphicsQuality = 3;
        return 3;
    }
    return gq.integerValue;
}

- (IBAction)fullScreenCheckBoxDidChange:(NSButton *)sender
{
    self.fullScreenMode = sender.integerValue;
}

- (IBAction)heightDidChange:(NSComboBox *)sender
{
    self.screenHeight = sender.integerValue;
}

- (IBAction)widthDidChange:(NSComboBox *)sender
{
    self.screenWidth = sender.integerValue;
}

- (IBAction)linkDidChange:(NSButton *)sender
{
    self.linkScreenDimensions = sender.integerValue;
}

- (IBAction)deletePrefsButtonPushed:(NSButton *)sender
{
    NSError *error = nil;
    
    _userPrefs = nil;
    
    [[NSFileManager defaultManager] removeItemAtURL:self.ksp.userPreferencesPlist
                                              error:&error];
    
    // XXX and then?
}

- (IBAction)yesIUnderstandChanged:(NSButtonCell *)sender
{
    
    [self.deletePrefsButton setEnabled:sender.integerValue];
    
}







- (IBAction)graphicsQualityDidChange:(NSLevelIndicator *)sender
{
    self.graphicsQuality = sender.integerValue;

}
@end
