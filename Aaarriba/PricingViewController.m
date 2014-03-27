//
//  PricingViewController.m
//  Aaarriba
//
//  Created by David Pflugpeil on 18.03.14.
//  Copyright (c) 2014 wunderfactory. All rights reserved.
//

#import "PricingViewController.h"

@interface PricingViewController () <UITextViewDelegate>

@property (strong, nonatomic) NSMutableDictionary *zehnKGDictionary;
@property (strong, nonatomic) NSMutableDictionary *zwanzigKGDictionary;
@property (strong, nonatomic) NSMutableDictionary *dreissigKGDictionary;
@property (strong, nonatomic) NSMutableDictionary *vierzigKGDictionary;

@end


@implementation PricingViewController

@synthesize zehnKGDictionary, zwanzigKGDictionary, dreissigKGDictionary, vierzigKGDictionary, zehnkgButton, zwanzigkgButton, dreissigkgButton, vierzigkgButton, locateStartButton, locateEndButton, packetRouteBeginTextField, packetRouteEndTextField;





// 1. Paket Buttons müssen mit Text aus der Datenbank geladen werden - im Moment sind es noch Bilder





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [self createContents];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self loadPricingData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma Methods

- (void)loadPricingData
{
    zehnKGDictionary = [zehnKGDictionary initWithObjectsAndKeys:
                        @"14,78", @"5km",
                        @"21,42", @"10km",
                        @"28,56", @"15km",
                        @"36,29", @"20km",
                        @"44,62", @"25km",
                        @"51,76", @"30km",
                        @"58,90", @"35km",
                        @"7,50", @"grundpreis",
                        nil];
    
    zwanzigKGDictionary = [zwanzigKGDictionary initWithObjectsAndKeys:
                           @"16,06", @"5km",
                           @"22,61", @"10km",
                           @"29,75", @"15km",
                           @"37,48", @"20km",
                           @"45,81", @"25km",
                           @"52,95", @"30km",
                           @"60,09", @"35km",
                           @"8,50", @"grundpreis",
                           nil];
    
    dreissigKGDictionary = [dreissigKGDictionary initWithObjectsAndKeys:
                            @"23,80", @"5km",
                            @"32,13", @"10km",
                            @"41,05", @"15km",
                            @"49,98", @"20km",
                            @"59,50", @"25km",
                            @"67,83", @"30km",
                            @"76,16", @"35km",
                            @"15,00", @"grundpreis",
                            nil];
    
    vierzigKGDictionary = [vierzigKGDictionary initWithObjectsAndKeys:
                           @"35,70", @"5km",
                           @"44,03", @"10km",
                           @"52,95", @"15km",
                           @"61,88", @"20km",
                           @"71,40", @"25km",
                           @"79,73", @"30km",
                           @"92,22", @"35km",
                           @"25,00", @"grundpreis",
                           nil];
}


- (void)createContents
{
    [packetRouteBeginTextField setHidden:YES];
    [packetRouteEndTextField setHidden:YES];
    
    [locateStartButton setHidden:YES];
    [locateEndButton setHidden:YES];
}





- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [packetRouteBeginTextField resignFirstResponder];
    [packetRouteEndTextField resignFirstResponder];
}






- (IBAction)zehnkgButton:(id)sender {
    
    zwanzigkgButton.frame = CGRectMake(175, 164, zwanzigkgButton.bounds.size.width, zwanzigkgButton.bounds.size.height);
    dreissigkgButton.frame = CGRectMake(24, 279, dreissigkgButton.bounds.size.width, dreissigkgButton.bounds.size.height);
    vierzigkgButton.frame = CGRectMake(175, 279, vierzigkgButton.bounds.size.width, vierzigkgButton.bounds.size.height);
    
    [UIView animateWithDuration:1.0 animations:^{
        zehnkgButton.frame = CGRectMake(95, 50, zehnkgButton.bounds.size.width, zehnkgButton.bounds.size.height);
        zwanzigkgButton.frame = CGRectMake(325, 164, zwanzigkgButton.bounds.size.width, zwanzigkgButton.bounds.size.height);
        dreissigkgButton.frame = CGRectMake(-135, 279, dreissigkgButton.bounds.size.width, dreissigkgButton.bounds.size.height);
        vierzigkgButton.frame = CGRectMake(325, 279, vierzigkgButton.bounds.size.width, vierzigkgButton.bounds.size.height);
    }];
    
    [packetRouteBeginTextField setHidden:NO];
    [packetRouteEndTextField setHidden:NO];
}

- (IBAction)zwanzigkgButton:(id)sender {
    
    zehnkgButton.frame = CGRectMake(24, 164, zehnkgButton.bounds.size.width, zehnkgButton.bounds.size.height);
    dreissigkgButton.frame = CGRectMake(24, 279, dreissigkgButton.bounds.size.width, dreissigkgButton.bounds.size.height);
    vierzigkgButton.frame = CGRectMake(175, 279, vierzigkgButton.bounds.size.width, vierzigkgButton.bounds.size.height);
    
    [UIView animateWithDuration:1.0 animations:^{
        zehnkgButton.frame = CGRectMake(-135, 164, zehnkgButton.bounds.size.width, zehnkgButton.bounds.size.height);
        zwanzigkgButton.frame = CGRectMake(95, 50, zwanzigkgButton.bounds.size.width, zwanzigkgButton.bounds.size.height);
        dreissigkgButton.frame = CGRectMake(-135, 279, dreissigkgButton.bounds.size.width, dreissigkgButton.bounds.size.height);
        vierzigkgButton.frame = CGRectMake(325, 279, vierzigkgButton.bounds.size.width, vierzigkgButton.bounds.size.height);
    }];
    
    [packetRouteBeginTextField setHidden:NO];
    [packetRouteEndTextField setHidden:NO];
}

- (IBAction)dreissigkgButton:(id)sender {
    
    zehnkgButton.frame = CGRectMake(24, 164, zehnkgButton.bounds.size.width, zehnkgButton.bounds.size.height);
    zwanzigkgButton.frame = CGRectMake(175, 164, zwanzigkgButton.bounds.size.width, zwanzigkgButton.bounds.size.height);
    vierzigkgButton.frame = CGRectMake(175, 279, vierzigkgButton.bounds.size.width, vierzigkgButton.bounds.size.height);
    
    [UIView animateWithDuration:1.0 animations:^{
        zehnkgButton.frame = CGRectMake(-135, 164, zehnkgButton.bounds.size.width, zehnkgButton.bounds.size.height);
        zwanzigkgButton.frame = CGRectMake(325, 164, zwanzigkgButton.bounds.size.width, zwanzigkgButton.bounds.size.height);
        dreissigkgButton.frame = CGRectMake(95, 50, dreissigkgButton.bounds.size.width, dreissigkgButton.bounds.size.height);
        vierzigkgButton.frame = CGRectMake(325, 279, vierzigkgButton.bounds.size.width, vierzigkgButton.bounds.size.height);
    }];
    
    [packetRouteBeginTextField setHidden:NO];
    [packetRouteEndTextField setHidden:NO];
}

- (IBAction)vierzigkgButton:(id)sender {
    
    zehnkgButton.frame = CGRectMake(24, 164, zehnkgButton.bounds.size.width, zehnkgButton.bounds.size.height);
    zwanzigkgButton.frame = CGRectMake(175, 164, zwanzigkgButton.bounds.size.width, zwanzigkgButton.bounds.size.height);
    dreissigkgButton.frame = CGRectMake(24, 279, dreissigkgButton.bounds.size.width, dreissigkgButton.bounds.size.height);
    
    [UIView animateWithDuration:1.0 animations:^{
        zehnkgButton.frame = CGRectMake(-135, 164, zehnkgButton.bounds.size.width, zehnkgButton.bounds.size.height);
        zwanzigkgButton.frame = CGRectMake(325, 164, zwanzigkgButton.bounds.size.width, zwanzigkgButton.bounds.size.height);
        dreissigkgButton.frame = CGRectMake(-135, 279, dreissigkgButton.bounds.size.width, dreissigkgButton.bounds.size.height);
        vierzigkgButton.frame = CGRectMake(95, 50, vierzigkgButton.bounds.size.width, vierzigkgButton.bounds.size.height);
    }];
    
    [packetRouteBeginTextField setHidden:NO];
    [packetRouteEndTextField setHidden:NO];
}



- (IBAction)resetAnimationButton:(id)sender {
    
    [UIView animateWithDuration:1.0 animations:^{
        zehnkgButton.frame = CGRectMake(24, 164, zehnkgButton.bounds.size.width, zehnkgButton.bounds.size.height);
        zwanzigkgButton.frame = CGRectMake(175, 164, zwanzigkgButton.bounds.size.width, zwanzigkgButton.bounds.size.height);
        dreissigkgButton.frame = CGRectMake(24, 279, dreissigkgButton.bounds.size.width, dreissigkgButton.bounds.size.height);
        vierzigkgButton.frame = CGRectMake(175, 279, vierzigkgButton.bounds.size.width, vierzigkgButton.bounds.size.height);
    }];
    
    [packetRouteBeginTextField setHidden:YES];
    [packetRouteEndTextField setHidden:YES];
    
    [locateStartButton setHidden:YES];
    [locateEndButton setHidden:YES];
}





- (IBAction)packetRouteBeginTextField:(id)sender {
    
    [locateStartButton setHidden:NO];
    [locateEndButton setHidden:YES];
}

- (IBAction)packetRouteEndTextField:(id)sender {
    
    [locateStartButton setHidden:YES];
    [locateEndButton setHidden:NO];
}




- (IBAction)locateStartButton:(id)sender {
    
    [self performSegueWithIdentifier:@"pricingToMapView" sender:self];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"startButtonTappedToMapView"];
}

- (IBAction)locateEndButton:(id)sender {
    
    [self performSegueWithIdentifier:@"pricingToMapView" sender:self];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"startButtonTappedToMapView"];
}



- (IBAction)contactsBeginButton:(id)sender {
    
    [self performSegueWithIdentifier:@"pricingToAdressbook" sender:self];
}

- (IBAction)contactsEndButton:(id)sender {

    [self performSegueWithIdentifier:@"pricingToAdressbook" sender:self];
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


@end
