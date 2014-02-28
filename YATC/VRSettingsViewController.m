//
//  VRSettingsViewController.m
//  YATC
//
//  Created by personal on 2/28/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

#import "VRSettingsViewController.h"

@interface VRSettingsViewController ()

@end

@implementation VRSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)switchRememberTipChanged:(id)sender {
    if( [sender isKindOfClass:[UISwitch class]] ) {
        UISwitch* shouldRememberLastTip = (UISwitch*) sender;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setInteger:[shouldRememberLastTip isOn] forKey:@"rememberLastTipValue"];
        [defaults synchronize];
    }
}
@end
