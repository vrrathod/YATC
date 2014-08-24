//
//  VRSettingsViewController.h
//  YATC
//
//  Created by personal on 2/28/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VRSettingsViewController : UIViewController
// ---- control ----
@property (weak, nonatomic) IBOutlet UISwitch *switchRememberTip;

// ---- action ----
- (IBAction)switchRememberTipChanged:(id)sender;

// -- delegation setup --
- (void) setMainViewControllerDelegate:(id) delegate;
@end
