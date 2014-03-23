//
//  PricingViewController.h
//  Aaarriba
//
//  Created by David Pflugpeil on 18.03.14.
//  Copyright (c) 2014 wunderfactory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PricingViewController : UIViewController


#pragma -
#pragma Methods

- (void)loadPricingData;
- (void)createContents;



#pragma Packet size

- (IBAction)zehnkgButton:(id)sender;
- (IBAction)zwanzigkgButton:(id)sender;
- (IBAction)dreissigkgButton:(id)sender;
- (IBAction)vierzigkgButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *zehnkgButton;
@property (weak, nonatomic) IBOutlet UIButton *zwanzigkgButton;
@property (weak, nonatomic) IBOutlet UIButton *dreissigkgButton;
@property (weak, nonatomic) IBOutlet UIButton *vierzigkgButton;


- (IBAction)resetAnimationButton:(id)sender;






#pragma Locate user

@property (weak, nonatomic) IBOutlet UITextField *packetRouteBeginTextField;
@property (weak, nonatomic) IBOutlet UITextField *packetRouteEndTextField;
- (IBAction)packetRouteBeginTextField:(id)sender;
- (IBAction)packetRouteEndTextField:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *locateStartButton;
@property (weak, nonatomic) IBOutlet UIButton *locateEndButton;
- (IBAction)locateStartButton:(id)sender;
- (IBAction)locateEndButton:(id)sender;




@end
