//
//  VRViewController.h
//  YATC
//
//  Created by personal on 2/27/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VRViewController : UIViewController

// ---- outlets ----
@property (weak, nonatomic) IBOutlet UITextField *txtOriginalAmount;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentFoodQuality;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentServiceQuality;
@property (weak, nonatomic) IBOutlet UITextField *txtTipAmount;
@property (weak, nonatomic) IBOutlet UIStepper *stepperTip;
@property (weak, nonatomic) IBOutlet UILabel *labelSplitCount;
@property (weak, nonatomic) IBOutlet UIStepper *stepperSplitCount;
@property (weak, nonatomic) IBOutlet UILabel *labelFinalAmount;

// ---- UI interaction methods
- (IBAction)amountChanged:(id)sender;
- (IBAction)qualityValueChanged:(id)sender;
- (IBAction)tipValueChanged:(id)sender;
- (IBAction)tipStepperChanged:(id)sender;
- (IBAction)splitValueChanged:(id)sender;

// ---- Methods
- (BOOL) shouldSaveTip ;

- (void) saveLastTipValue ;


@end
