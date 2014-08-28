//
//  VRSettingsViewController.m
//  YATC
//
//  Created by personal on 2/28/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

#import "VRSettingsViewController.h"
#import "VRUserDefaults.h"
#import "VRConstants.h"

@interface VRSettingsViewController ()
/// delegate
@property (weak) id<VRUserDefaults> vrMainViewController;

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
    if( [[NSUserDefaults standardUserDefaults] integerForKey:USERDEFAULTS_REMEMBERLASTTIP_SETTINGS_NAME] ) {
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

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // if current setting is to save it, save it
    if( [self.switchRememberTip isOn] ){
        [defaults setInteger:[self.switchRememberTip isOn] forKey:USERDEFAULTS_REMEMBERLASTTIP_SETTINGS_NAME];
        [self.vrMainViewController saveLastTipValue];
    } else if( ! [self.switchRememberTip isOn] ) {
        [defaults removeObjectForKey:USERDEFAULTS_REMEMBERLASTTIP_SETTINGS_NAME];
        [self.vrMainViewController removeLastTipeValue];
    }
    [defaults synchronize];
}

#pragma mark -- delegate --
- (void) setMainViewControllerDelegate:(id) delegate {
    
    do {
        // reset delegate
        self.vrMainViewController = nil;
        
        if( !delegate ) {
            break;
        } else if( ! [delegate respondsToSelector:@selector(saveLastTipValue)] ) {
            break;
        } else if( ! [delegate respondsToSelector:@selector(removeLastTipeValue)] ) {
            break;
        }
        self.vrMainViewController = delegate;
    } while (0);
    
}
@end
