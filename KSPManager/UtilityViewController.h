//
//  UtilityViewController.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/16/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "KSPViewController.h"

@interface UtilityViewController : KSPViewController
@property (strong) IBOutlet NSLevelIndicator *graphicsQualityIndicator;
@property (strong) IBOutlet NSButton *fullScreenCheckBox;
@property (strong) IBOutlet NSComboBox *heightComboBox;
@property (strong) IBOutlet NSComboBox *widthComboBox;
@property (strong) IBOutlet NSButton *linkCheckBox;
@property (strong) IBOutlet NSButton *deletePrefsButton;
@property (strong) IBOutlet NSButton *yesIUnderstandButton;

@property (strong, nonatomic,readonly) NSMutableDictionary *userPrefs;

@property (assign, nonatomic,getter = isFullScreenMode) BOOL fullScreenMode;
@property (assign, nonatomic) NSInteger screenHeight;
@property (assign, nonatomic) NSInteger screenWidth;
@property (assign, nonatomic) NSInteger graphicsQuality;
@property (assign, nonatomic) BOOL linkScreenDimensions;


- (IBAction)fullScreenCheckBoxDidChange:(NSButton *)sender;
- (IBAction)heightDidChange:(NSComboBox *)sender;
- (IBAction)widthDidChange:(NSComboBox *)sender;
- (IBAction)linkDidChange:(NSButton *)sender;
- (IBAction)graphicsQualityDidChange:(NSLevelIndicator *)sender;
- (IBAction)deletePrefsButtonPushed:(NSButton *)sender;
- (IBAction)yesIUnderstandChanged:(NSButtonCell *)sender;




@end
