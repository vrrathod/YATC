//
//  VRViewController.m
//  YATC
//
//  Created by personal on 2/27/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

#import "VRViewController.h"

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
    for(UIView* v in [self.view subviews]){
        [v endEditing:YES];
    }
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
    if( [self shouldSaveTip] ) {
        [self saveLastTipValue];
    }
    [self.txtTipAmount setText:[NSString stringWithFormat:@"%.02f", tip]];
    [self setStepperValue:tip];
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
    [self.txtOriginalAmount setText:@"100"];
    [self.segmentFoodQuality setSelectedSegmentIndex:eQualityOk];
    [self.segmentServiceQuality setSelectedSegmentIndex:eQualityOk];

    if( [self shouldSaveTip] ) {
        [self setTipText:[self lastTipValue]];
    } else {
        [self setTipText:[self calculateTipPercent]];
    }
    [self setTotalText:[self computeTotal]];
    self.stepperSplitCount.value = 1;
}

- (BOOL) shouldSaveTip {
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"rememberLastTipValue"] ;
}

- (Float32) lastTipValue {
    return [[[NSUserDefaults standardUserDefaults] valueForKey:@"lastTipValue"] floatValue];
}

- (void) saveLastTipValue {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:self.txtTipAmount.text forKey:@"lastTipValue"];
    [defaults synchronize];
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
@end
