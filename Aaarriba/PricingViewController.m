//
//  PricingViewController.m
//  Aaarriba
//
//  Created by David Pflugpeil on 18.03.14.
//  Copyright (c) 2014 wunderfactory. All rights reserved.
//

#import "PricingViewController.h"
#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface PricingViewController () <UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, ABPeoplePickerNavigationControllerDelegate>

@property (strong, nonatomic) NSMutableDictionary *zehnKGDictionary;
@property (strong, nonatomic) NSMutableDictionary *zwanzigKGDictionary;
@property (strong, nonatomic) NSMutableDictionary *dreissigKGDictionary;
@property (strong, nonatomic) NSMutableDictionary *vierzigKGDictionary;

@property (strong, nonatomic) ABPeoplePickerNavigationController *addressBookStartController;
@property (strong, nonatomic) ABPeoplePickerNavigationController *addressBookEndController;
@property (strong, nonatomic) NSString *addressContactStartString;

@property BOOL addressStartEnd;

@property NSInteger kgInteger;

@property (strong, nonatomic) UIButton *weightButton;


@end


@implementation PricingViewController

@synthesize zehnKGDictionary, zwanzigKGDictionary, dreissigKGDictionary, vierzigKGDictionary, locateStartButton, locateEndButton, packetRouteBeginTextField, packetRouteEndTextField, startLocationLatitude, startLocationLongitude, endLocationLatitude, endLocationLongitude, calculatePriceButton, kgInteger, priceLabel, packetSizeButton, addressBookStartController, addressBookEndController, addressContactStartString, addressStartEnd, contactsBeginButton, contactsEndButton, weightButton, weightScrollView, backgroundImageView;





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



#pragma mark Methods

- (void)loadPricingData
{
    zehnKGDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                        [NSNumber numberWithFloat:12.50], @"5km",
                        [NSNumber numberWithFloat:18.00], @"10km",
                        [NSNumber numberWithFloat:24.00], @"15km",
                        [NSNumber numberWithFloat:30.50], @"20km",
                        [NSNumber numberWithFloat:37.50], @"25km",
                        [NSNumber numberWithFloat:43.50], @"30km",
                        [NSNumber numberWithFloat:49.50], @"35km",
                        [NSNumber numberWithFloat:7.50], @"grundpreis",
                        nil];
    
    
    zwanzigKGDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithFloat:13.50], @"5km",
                           [NSNumber numberWithFloat:19.00], @"10km",
                           [NSNumber numberWithFloat:25.00], @"15km",
                           [NSNumber numberWithFloat:31.50], @"20km",
                           [NSNumber numberWithFloat:38.50], @"25km",
                           [NSNumber numberWithFloat:44.50], @"30km",
                           [NSNumber numberWithFloat:50.50], @"35km",
                           [NSNumber numberWithFloat:8.50], @"grundpreis",
                           nil];
    
    dreissigKGDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithFloat:20.00], @"5km",
                            [NSNumber numberWithFloat:27.00], @"10km",
                            [NSNumber numberWithFloat:34.50], @"15km",
                            [NSNumber numberWithFloat:42.00], @"20km",
                            [NSNumber numberWithFloat:50.00], @"25km",
                            [NSNumber numberWithFloat:57.50], @"30km",
                            [NSNumber numberWithFloat:64.00], @"35km",
                            [NSNumber numberWithFloat:15.00], @"grundpreis",
                            nil];
    
    vierzigKGDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithFloat:30.00], @"5km",
                           [NSNumber numberWithFloat:37.00], @"10km",
                           [NSNumber numberWithFloat:44.50], @"15km",
                           [NSNumber numberWithFloat:52.00], @"20km",
                           [NSNumber numberWithFloat:60.00], @"25km",
                           [NSNumber numberWithFloat:67.00], @"30km",
                           [NSNumber numberWithFloat:77.50], @"35km",
                           [NSNumber numberWithFloat:25.00], @"grundpreis",
                           nil];
}




- (void)createContents
{
    // Hide UI Elements
    
    [weightScrollView setHidden:YES];
    
    
    
    // Hide user location buttons
    
    [locateStartButton setHidden:YES];
    [locateEndButton setHidden:YES];
    
    [contactsBeginButton setHidden:YES];
    [contactsEndButton setHidden:YES];
    
    
    
    [priceLabel setHidden:YES];
    [calculatePriceButton setHidden:YES];
    
    
    
    if (kgInteger == 0) {
        [packetRouteBeginTextField setHidden:YES];
        [packetRouteEndTextField setHidden:YES];
    }
    
    else {
        packetRouteBeginTextField.text = addressContactStartString;
    }
    
    
    
    [self createScrollMenu];
    
    
    
    
    // Load TextFields with stored User Address
    
    packetRouteBeginTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userStartAddress"];
    packetRouteEndTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userEndAddress"];
    
    
    
    
    
    
    // MOTION EFFECT
    
    
    // Max & Min values
    CGFloat leftRightMin = -55.0f;
    CGFloat leftRightMax = 55.0f;
    
    // UIMotionEffect
    UIInterpolatingMotionEffect *leftRight = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    leftRight.minimumRelativeValue = @(leftRightMin);
    leftRight.maximumRelativeValue = @(leftRightMax);
    
    
    
    
    // Max & Min values
    CGFloat upDfownMin = -35.0f;
    CGFloat upDownhtMax = 35.0f;
    
    // UIMotionEffect
    UIInterpolatingMotionEffect *upDown = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    leftRight.minimumRelativeValue = @(upDfownMin);
    leftRight.maximumRelativeValue = @(upDownhtMax);
    
    
    
    
    
    UIMotionEffectGroup *motionEffectGroup = [[UIMotionEffectGroup alloc] init];
    motionEffectGroup.motionEffects = @[leftRight, upDown];
    
    [backgroundImageView addMotionEffect:motionEffectGroup];
}





#pragma mark Scroll menu

- (void)createScrollMenu
{
    weightScrollView.delegate = self;
    
    int x = 0;
    for (int i = 1; i < 41; i++) {
        weightButton = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, 100, 100)];
        [weightButton setTitle:[NSString stringWithFormat:@"%dkg", i] forState:UIControlStateNormal];
        [weightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [weightButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        weightButton.tag = i;
        
        [weightScrollView addSubview:weightButton];
        
        x += weightButton.frame.size.width;
    }
    
    weightScrollView.contentSize = CGSizeMake(x, weightScrollView.frame.size.height);
    weightScrollView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:158.0/255.0 blue:224.0/255.0 alpha:1.0];
}





// Setting the value

- (void)buttonPressed:(UIButton *)button
{
    kgInteger = button.tag;
    packetSizeButton.titleLabel.text = [NSString stringWithFormat:@"%ldkg", (long)kgInteger];
    
    
    
    
    // Hide TextFields only when the Button is empty ("Gewicht")
    
    if (![packetSizeButton.titleLabel.text isEqualToString:@"Gewicht"]) {
        [packetRouteBeginTextField setHidden:NO];
    }
    if (![packetRouteBeginTextField.text isEqualToString:@""]) {
        [packetRouteEndTextField setHidden:NO];
    }
}








- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Hide UI Elements (TextFields, UIPickerView, etc.) when user touches the view
    
    [packetRouteBeginTextField resignFirstResponder];
    [packetRouteEndTextField resignFirstResponder];
    [weightScrollView setHidden:YES];
    
    
    

    
    // Hide price buttons when user is selecting the size of his packet
    
    if (![packetRouteBeginTextField.text isEqualToString:@""] && ![packetRouteEndTextField.text isEqualToString:@""]) {
        if (weightScrollView.isHidden == YES) {
            [calculatePriceButton setHidden:NO];
            [priceLabel setHidden:NO];
        }
    }
    
    
    
    [locateStartButton setHidden:YES];
    [locateEndButton setHidden:YES];
    [contactsBeginButton setHidden:YES];
    [contactsEndButton setHidden:YES];
    
    
    
    // Hide TextFields only when the Button is empty ("Gewicht")
    
    if (![packetSizeButton.titleLabel.text isEqualToString:@"Gewicht"]) {
        [packetRouteBeginTextField setHidden:NO];
    }
    if (![packetRouteBeginTextField.text isEqualToString:@""]) {
        [packetRouteEndTextField setHidden:NO];
    }
}







#pragma mark Packet size


- (IBAction)packetSizeButton:(id)sender
{
    // Show PickerView as soon as the Button gets touched
    [weightScrollView setHidden:NO];
    
    if (weightScrollView.isHidden == NO) {
        [calculatePriceButton setHidden:YES];
        [priceLabel setHidden:YES];
    }
}






#pragma mark Picker View Data Source

// Setting up the packet PickerView


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSMutableArray *zahlenArray = [NSMutableArray array];
    
    for (int i = 1; i < 41; i++) {
        [zahlenArray addObject:[NSNumber numberWithInt:i]];
    }
    
    return [zahlenArray count];
}


/*
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSMutableArray *zahlenArray = [NSMutableArray array];
    
    for (int i = 1; i < 41; i++) {
        [zahlenArray addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    return [zahlenArray objectAtIndex:row];
}
*/
 


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSMutableArray *zahlenArray = [NSMutableArray array];
    
    for (int i = 1; i < 41; i++) {
        [zahlenArray addObject:[NSNumber numberWithInt:i]];
    }
    
    id kgInt = [zahlenArray objectAtIndex:row];
    kgInteger = [kgInt integerValue];
    
    
    // Set title for PickerView with weight
    
    packetSizeButton.titleLabel.text = [NSString stringWithFormat:@"%@kg", [zahlenArray objectAtIndex:row]];
}








#pragma mark Locate user


- (IBAction)packetRouteBeginTextField:(id)sender {
    
    [locateStartButton setHidden:NO];
    [locateEndButton setHidden:YES];
    
    [contactsBeginButton setHidden:NO];
    [contactsEndButton setHidden:YES];
}

- (IBAction)packetRouteEndTextField:(id)sender {
    
    [locateStartButton setHidden:YES];
    [locateEndButton setHidden:NO];
    
    [contactsBeginButton setHidden:YES];
    [contactsEndButton setHidden:NO];
}




- (IBAction)locateStartButton:(id)sender {
    
    [self performSegueWithIdentifier:@"pricingToMapView" sender:self];
}

- (IBAction)locateEndButton:(id)sender {
    
    [self performSegueWithIdentifier:@"pricingToEndMapView" sender:self];
}







#pragma mark Calculate Price


- (IBAction)calculatePriceButton:(id)sender {
    
    NSDictionary *startDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:@"userStartLocationDict"];
    NSDictionary *endDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:@"userEndLocationDict"];
    
    
    CLLocation *startLocation = [[CLLocation alloc] initWithLatitude:[[startDictionary objectForKey:@"latitude"] doubleValue] longitude:[[startDictionary objectForKey:@"longitude"] doubleValue]];
    CLLocation *endLocation = [[CLLocation alloc] initWithLatitude:[[endDictionary objectForKey:@"latitude"] doubleValue] longitude:[[endDictionary objectForKey:@"longitude"] doubleValue]];
    
    
    
    
    // distance is the beeline
    
    CLLocationDistance distance = [startLocation distanceFromLocation:endLocation];
    
    
    /*
    float startLatitude = [[startDictionary objectForKey:@"latitude"] floatValue];
    float startLongitude = [[startDictionary objectForKey:@"longitude"] floatValue];
    
    float endLatitude = [[endDictionary objectForKey:@"latitude"] floatValue];
    float endLongitude = [[endDictionary objectForKey:@"longitude"] floatValue];
    
    
    
    NSURL *googleDirectionsAPIURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/distancematrix/output?origins=%f,%f&destinations=%f,%f", startLatitude, startLongitude, endLatitude, endLongitude]];
    NSMutableURLRequest *googleDirectionsRequest = [NSMutableURLRequest requestWithURL:googleDirectionsAPIURL];
    [googleDirectionsRequest setHTTPMethod:@"GET"];
    [googleDirectionsRequest setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    NSURLResponse *googleResponse;
    NSData *googleData = [NSURLConnection sendSynchronousRequest:googleDirectionsRequest returningResponse:&googleResponse error:nil];
    
    id jsonData = [NSJSONSerialization JSONObjectWithData:googleData options:0 error:nil];
    NSMutableDictionary *responseDict;
    responseDict = jsonData;
    
    NSLog(@"%@", googleDirectionsAPIURL);
    NSLog(@"%@", responseDict);
    */
    
    
    
    
    
    // Detecting the distance between start position and end position
    // After that, the price gets calculated with the weight of its packet
    
    if (distance < 5000) {
        
        if (kgInteger < 11) {
            
            float price = [self calculatePriceWithWeight:kgInteger basePriceDictionary:zehnKGDictionary withDictionaryKey:@"grundpreis" andDistancePriceDictionary:zehnKGDictionary withDictionaryKey:@"5km"];
            
            priceLabel.text = [NSString stringWithFormat:@"%f", price];
        }
    }
    else if (distance < 10000) {
        
    }
    else if (distance < 15000) {
        
    }
    else if (distance < 20000) {
        
    }
    else if (distance < 25000) {
        
    }
    else if (distance < 30000) {
        
    }
    else if (distance < 35000) {
        
    }
    
    
    /*
    if (kgInteger < 11) {
        
        if (distance < 5000) {
            priceLabel.text = [zehnKGDictionary valueForKey:@"5km"];
        }
        else if (distance < 10000) {
            priceLabel.text = [zehnKGDictionary valueForKey:@"10km"];
        }
        else if (distance < 15000) {
            priceLabel.text = [zehnKGDictionary valueForKey:@"15km"];
        }
        else if (distance < 20000) {
            priceLabel.text = [zehnKGDictionary valueForKey:@"20km"];
        }
        else if (distance < 25000) {
            priceLabel.text = [zehnKGDictionary valueForKey:@"25km"];
        }
        else if (distance < 30000) {
            priceLabel.text = [zehnKGDictionary valueForKey:@"30km"];
        }
        else if (distance < 35000) {
            priceLabel.text = [zehnKGDictionary valueForKey:@"35km"];
        }
    }
            
            
            
    else if (kgInteger < 21) {
        
        if (distance < 5000) {
            priceLabel.text = [zwanzigKGDictionary valueForKey:@"5km"];
        }
        else if (distance < 10000) {
        priceLabel.text = [zwanzigKGDictionary valueForKey:@"10km"];
            }
        else if (distance < 15000) {
            priceLabel.text = [zwanzigKGDictionary valueForKey:@"15km"];
        }
        else if (distance < 20000) {
            priceLabel.text = [zwanzigKGDictionary valueForKey:@"20km"];
        }
        else if (distance < 25000) {
            priceLabel.text = [zwanzigKGDictionary valueForKey:@"25km"];
        }
        else if (distance < 30000) {
            priceLabel.text = [zwanzigKGDictionary valueForKey:@"30km"];
        }
        else if (distance < 35000) {
            priceLabel.text = [zwanzigKGDictionary valueForKey:@"35km"];
        }
    }
        
        
    
    else if (kgInteger < 31) {
        
        if (distance < 5000) {
            priceLabel.text = [dreissigKGDictionary valueForKey:@"5km"];
        }
        else if (distance < 10000) {
            priceLabel.text = [dreissigKGDictionary valueForKey:@"10km"];
        }
        else if (distance < 15000) {
            priceLabel.text = [dreissigKGDictionary valueForKey:@"15km"];
        }
        else if (distance < 20000) {
            priceLabel.text = [dreissigKGDictionary valueForKey:@"20km"];
        }
        else if (distance < 25000) {
            priceLabel.text = [dreissigKGDictionary valueForKey:@"25km"];
        }
        else if (distance < 30000) {
            priceLabel.text = [dreissigKGDictionary valueForKey:@"30km"];
        }
        else if (distance < 35000) {
            priceLabel.text = [dreissigKGDictionary valueForKey:@"35km"];
        }
    }
    
    
    
    else if (kgInteger < 41) {
        
        if (distance < 5000) {
            priceLabel.text = [vierzigKGDictionary valueForKey:@"5km"];
        }
        else if (distance < 10000) {
            priceLabel.text = [vierzigKGDictionary valueForKey:@"10km"];
        }
        else if (distance < 15000) {
            priceLabel.text = [vierzigKGDictionary valueForKey:@"15km"];
        }
        else if (distance < 20000) {
            priceLabel.text = [vierzigKGDictionary valueForKey:@"20km"];
        }
        else if (distance < 25000) {
            priceLabel.text = [vierzigKGDictionary valueForKey:@"25km"];
        }
        else if (distance < 30000) {
            priceLabel.text = [vierzigKGDictionary valueForKey:@"30km"];
        }
        else if (distance < 35000) {
            priceLabel.text = [vierzigKGDictionary valueForKey:@"35km"];
        }
    }*/
}




// Method for calculating the price

- (float)calculatePriceWithWeight:(NSInteger)weightInteger basePriceDictionary:(NSMutableDictionary *)basePriceDictonary withDictionaryKey:(NSString *)baseKey andDistancePriceDictionary:(NSMutableDictionary *)distancePriceDictionary withDictionaryKey:(NSString *)distanceKey
{
    float variance = weightInteger;
    
    // Percentage
    variance = variance * 0.1;
    
    float basePrice = [[basePriceDictonary valueForKey:baseKey] floatValue] * variance;
    
    float distancePrice = [[basePriceDictonary valueForKey:distanceKey] floatValue];
    float price = basePrice + distancePrice;
    
    return price;
}







#pragma mark Contact Address


- (IBAction)contactsBeginButton:(id)sender {
    
    //[self performSegueWithIdentifier:@"pricingToStartAddress" sender:self];
    [self showAddressbook];
    
    addressStartEnd = YES;
}

- (IBAction)contactsEndButton:(id)sender {
    
    //[self performSegueWithIdentifier:@"pricingToEndAddress" sender:self];
    [self showAddressbook];
    
    addressStartEnd = NO;
}



// Addressbook gets presented

- (void)showAddressbook
{
    if (addressStartEnd == YES) {
        addressBookStartController = [[ABPeoplePickerNavigationController alloc] init];
        [addressBookStartController setPeoplePickerDelegate:self];
        [self presentViewController:addressBookStartController animated:YES completion:nil];
    }
    if (addressStartEnd == NO) {
        addressBookEndController = [[ABPeoplePickerNavigationController alloc] init];
        [addressBookEndController setPeoplePickerDelegate:self];
        [self presentViewController:addressBookEndController animated:YES completion:nil];
    }
}


// Case: user cancels UIView

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    if (addressStartEnd == YES) {
        [addressBookStartController dismissViewControllerAnimated:YES completion:nil];
    }
    if (addressStartEnd == NO) {
        [addressBookEndController dismissViewControllerAnimated:YES completion:nil];
    }
}




- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    NSMutableDictionary *contactInfoDictionary = [[NSMutableDictionary alloc] initWithObjects:@[@"", @"", @"", @"", @""] forKeys:@[@"firstName", @"lastName", @"address", @"zip", @"city"]];
    
    
    
    
    // First name
    
    CFTypeRef generalCFObject = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    
    if (generalCFObject) {
        [contactInfoDictionary setObject:(__bridge NSString *)generalCFObject forKey:@"firstname"];
        CFRelease(generalCFObject);
    }
    
    
    
    // Sir name
    
    generalCFObject = ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    if (generalCFObject) {
        [contactInfoDictionary setObject:(__bridge NSString *)generalCFObject forKey:@"lastname"];
        CFRelease(generalCFObject);
    }
    
    
    
    // Address
    
    ABMultiValueRef addressRef = ABRecordCopyValue(person, kABPersonAddressProperty);
    
    if (ABMultiValueGetCount(addressRef) > 0) {
        NSDictionary *addressDict = (__bridge NSDictionary *)ABMultiValueCopyValueAtIndex(addressRef, 0);
        
        [contactInfoDictionary setObject:[addressDict objectForKey:(NSString *)kABPersonAddressStreetKey] forKey:@"address"];
        [contactInfoDictionary setObject:[addressDict objectForKey:(NSString *)kABPersonAddressZIPKey] forKey:@"zipCode"];
        [contactInfoDictionary setObject:[addressDict objectForKey:(NSString *)kABPersonAddressCityKey] forKey:@"city"];
    }
    
    
    CFRelease(generalCFObject);
    
    
    
    
    // Load string with contact information
    
    addressContactStartString = [NSString stringWithFormat:@"%@, %@, %@", [contactInfoDictionary valueForKey:@"address"], [contactInfoDictionary valueForKey:@"zipCode"], [contactInfoDictionary valueForKey:@"city"]];
    
    
    
    if (addressStartEnd == YES) {
        [[NSUserDefaults standardUserDefaults] setObject:addressContactStartString forKey:@"userStartAddress"];
    }
    if (addressStartEnd == NO) {
        [[NSUserDefaults standardUserDefaults] setObject:addressContactStartString forKey:@"userEndAddress"];
    }
    
    
    
    // Dismiss ViewController
    
    [addressBookStartController dismissViewControllerAnimated:YES completion:nil];
    [addressBookEndController dismissViewControllerAnimated:YES completion:nil];
    
    
    return NO;
}


- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}


@end
