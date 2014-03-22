//
//  LoginViewController.m
//  Aaarriba
//
//  Created by David Pflugpeil on 18.03.14.
//  Copyright (c) 2014 wunderfactory. All rights reserved.
//

#import "LoginViewController.h"
#import "PricingViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"userIsLoggedIn"] == YES) {
            [self presentViewController:[PricingViewController alloc] animated:NO completion:^{
                NSLog(@"view is presented");
            }];
        }
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



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)loginButtonAction:(id)sender {
    
    
    // if login response is YES
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"userIsLoggedIn"];
    
    [self performSegueWithIdentifier:@"loginToPricingViewController" sender:self];
}


@end
