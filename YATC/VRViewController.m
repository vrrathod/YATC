//
//  VRViewController.m
//  YATC
//
//  Created by personal on 2/27/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

#import "VRViewController.h"
#import "VRSettingsViewController.h"
#import "VRConstants.h"
#pragma mark - Constants & Enums


typedef NS_ENUM(NSUInteger, quality){
    eQualityBad,
    eQualityOk,
    eQualityGood,
    eQualityLovedIt,
} ;

#pragma mark - Private Methods
@interface VRViewController ()

@end


#pragma mark - Implementation
@implementation VRViewController

#pragma mark - pre-existing methods
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initDefaultValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI behavior util
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - Helpers
- (Float32) valueForQuality:(quality) inQuality {
    Float32 returnValue = 0;
    switch (inQuality) {
        case eQualityBad:       returnValue = 5;    break;
        case eQualityOk:        returnValue = 7.5;  break;
        case eQualityGood:      returnValue = 10;   break;
        case eQualityLovedIt:   returnValue = 12.5; break;
        default:
            NSLog(@"invalid enum value received");
            break;
    }
    return returnValue;
}

- (void) setTipText:(Float32) tip {
    [self.txtTipAmount setText:[NSString stringWithFormat:@"%.02f", tip]];
    [self setStepperValue:tip];
    if( [self shouldSaveTip] ) {
        [self saveLastTipValue];
    }
}

- (void) setSplitLabel:(NSUInteger) split {
    [self.labelSplitCount setText:[NSString stringWithFormat:@"%lu", (unsigned long)split]];
}

- (void) setTotalText:(Float32) amount {
    [self.labelFinalAmount setText:[NSString stringWithFormat:@"Total = %.02f", amount/self.stepperSplitCount.value]];
}

- (void) setStepperValue:(Float32) tip {
    self.stepperTip.value = tip;
}

- (Float32) computeTotal {
    Float32 amount = [self.txtOriginalAmount.text floatValue];
    Float32 tip = [self.txtTipAmount.text floatValue];
    return ( amount * ( 1 + (tip / 100) ) );
}

- (Float32) calculateTipPercent {
    quality food = [self.segmentFoodQuality selectedSegmentIndex];
    quality service = [self.segmentServiceQuality selectedSegmentIndex];
    self.stepperTip.value = [self valueForQuality:food] + [self valueForQuality:service];
    return self.stepperTip.value;
}

- (void) initDefaultValues {
    
    [self checkAndCreateLastTipKey];
    
    [self.txtOriginalAmount setText:@"100"];

    if( [self shouldSaveTip] ) {
        [self.segmentFoodQuality setSelectedSegmentIndex:[self lastFoodQualityValue]];
        [self.segmentServiceQuality setSelectedSegmentIndex:[self lastServiceQualityValue]];
        [self setTipText:[self lastTipValue]];
    } else {
        [self.segmentFoodQuality setSelectedSegmentIndex:eQualityOk];
        [self.segmentServiceQuality setSelectedSegmentIndex:eQualityOk];
        [self setTipText:[self calculateTipPercent]];
    }
    [self setTotalText:[self computeTotal]];
    self.stepperSplitCount.value = 1;
}


#pragma mark - UI interaction methods

- (IBAction)amountChanged:(id)sender {
    [self setTotalText:[self computeTotal]];
}

- (IBAction)qualityValueChanged:(id)sender {
    [self setTipText:[self calculateTipPercent]];
    [self setTotalText:[self computeTotal]];
}

- (IBAction)tipValueChanged:(id)sender {
    [self setStepperValue:[self.txtTipAmount.text floatValue]];
    [self setTotalText:[self computeTotal]];
    // remember
    if( [self shouldSaveTip] ) {
        [self saveLastTipValue];
    }
}

- (IBAction)tipStepperChanged:(id)sender {
    [self setTipText:(Float32)self.stepperTip.value];
    [self setTotalText: [self computeTotal]];
}

- (IBAction)splitValueChanged:(id)sender {
    [self setSplitLabel:self.stepperSplitCount.value];
    Float32 total = [self computeTotal];
    [self setTotalText:total];
}

#pragma mark - Protocol Methods -

- (BOOL) shouldSaveTip {
    return [[NSUserDefaults standardUserDefaults] integerForKey:USERDEFAULTS_REMEMBERLASTTIP_SETTINGS_NAME] ;
}

- (void) saveLastTipValue {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    // save the tip value
    [defaults setValue:self.txtTipAmount.text forKey:USERDEFAULTS_LASTTIP_VALUE_NAME];
    // save the food and service quality rating
    quality food = [self.segmentFoodQuality selectedSegmentIndex];
    [defaults setObject:[NSNumber numberWithUnsignedInt:food]
                 forKey:USERDEFAULTS_FOOD_QUALITY_NAME];
    
    quality service = [self.segmentServiceQuality selectedSegmentIndex];
    [defaults setObject:[NSNumber numberWithUnsignedInt:service]
                 forKey:USERDEFAULTS_SERVICE_QUALITY_NAME];
    
    [defaults synchronize];
}

- (void) removeLastTipeValue {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:USERDEFAULTS_LASTTIP_VALUE_NAME];
    [defaults synchronize];
}

- (void) checkAndCreateLastTipKey {
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSArray* keys = [[defaults dictionaryRepresentation] allKeys];
    
    if( ! [keys containsObject:USERDEFAULTS_REMEMBERLASTTIP_SETTINGS_NAME] ) {
        // by default we want to remember
        [defaults setValue:@"YES" forKey:USERDEFAULTS_REMEMBERLASTTIP_SETTINGS_NAME];
        [defaults synchronize];
    }
}

- (Float32) lastTipValue {
    return [[[NSUserDefaults standardUserDefaults] valueForKey:USERDEFAULTS_LASTTIP_VALUE_NAME] floatValue];
}

- (NSUInteger) lastFoodQualityValue {
    return [[[NSUserDefaults standardUserDefaults] valueForKey:USERDEFAULTS_FOOD_QUALITY_NAME] unsignedIntegerValue];
}

- (NSUInteger) lastServiceQualityValue {
    return [[[NSUserDefaults standardUserDefaults] valueForKey:USERDEFAULTS_SERVICE_QUALITY_NAME] unsignedIntegerValue];
}

#pragma mark - Segue Method -
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if( [[segue identifier] isEqualToString:SEGUE_NAME_SETTINGS] ) {
        VRSettingsViewController* targetViewController = [segue destinationViewController];
        [targetViewController setMainViewControllerDelegate:self];
    }
}
@end
