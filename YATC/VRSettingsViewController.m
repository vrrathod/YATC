//
//  VRSettingsViewController.m
//  YATC
//
//  Created by personal on 2/28/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

#import "VRSettingsViewController.h"
#import "VRViewController.h"

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
    if( [[NSUserDefaults standardUserDefaults] integerForKey:@"rememberLastTipValue"] ) {
        [self.switchRememberTip setOn:YES];
    } else {
        [self.switchRememberTip setOn:NO];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)switchRememberTipChanged:(id)sender {
    VRViewController* mainController = (VRViewController*) [[[UIApplication sharedApplication] keyWindow] rootViewController];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:[self.switchRememberTip isOn] forKey:@"rememberLastTipValue"];
    [defaults synchronize];
    
    [mainController saveLastTipValue];
}
@end
