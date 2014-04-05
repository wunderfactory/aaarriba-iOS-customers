//
//  PricingViewController.m
//  Aaarriba
//
//  Created by David Pflugpeil on 18.03.14.
//  Copyright (c) 2014 wunderfactory. All rights reserved.
//

#import "PricingViewController.h"
#import <MapKit/MapKit.h>

@interface PricingViewController () <UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) NSMutableDictionary *zehnKGDictionary;
@property (strong, nonatomic) NSMutableDictionary *zwanzigKGDictionary;
@property (strong, nonatomic) NSMutableDictionary *dreissigKGDictionary;
@property (strong, nonatomic) NSMutableDictionary *vierzigKGDictionary;

@property NSInteger kgInteger;

@end


@implementation PricingViewController

@synthesize zehnKGDictionary, zwanzigKGDictionary, dreissigKGDictionary, vierzigKGDictionary, locateStartButton, locateEndButton, packetRouteBeginTextField, packetRouteEndTextField, startLocationLatitude, startLocationLongitude, endLocationLatitude, endLocationLongitude, calculatePriceButton, kgInteger, priceLabel, packetSizeButton, packetSizePickerView;





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
    
    
    /*
    zehnKGDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                        @"14,78", @"5km",
                        @"21,42", @"10km",
                        @"28,56", @"15km",
                        @"36,29", @"20km",
                        @"44,62", @"25km",
                        @"51,76", @"30km",
                        @"58,90", @"35km",
                        @"7,50", @"grundpreis",
                        nil];
    
    
    zwanzigKGDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                           @"16,06", @"5km",
                           @"22,61", @"10km",
                           @"29,75", @"15km",
                           @"37,48", @"20km",
                           @"45,81", @"25km",
                           @"52,95", @"30km",
                           @"60,09", @"35km",
                           @"8,50", @"grundpreis",
                           nil];
    
    dreissigKGDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                            @"23,80", @"5km",
                            @"32,13", @"10km",
                            @"41,05", @"15km",
                            @"49,98", @"20km",
                            @"59,50", @"25km",
                            @"67,83", @"30km",
                            @"76,16", @"35km",
                            @"15,00", @"grundpreis",
                            nil];
    
    vierzigKGDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                           @"35,70", @"5km",
                           @"44,03", @"10km",
                           @"52,95", @"15km",
                           @"61,88", @"20km",
                           @"71,40", @"25km",
                           @"79,73", @"30km",
                           @"92,22", @"35km",
                           @"25,00", @"grundpreis",
                           nil];
     */
}




- (void)createContents
{
    kgInteger = 0;
    
    [packetSizePickerView setHidden:YES];
    
    
    
    [packetRouteBeginTextField setHidden:YES];
    [packetRouteEndTextField setHidden:YES];
    
    [locateStartButton setHidden:YES];
    [locateEndButton setHidden:YES];
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userStartAddressCoorddinates"] == nil ||  [[NSUserDefaults standardUserDefaults] objectForKey:@"userEndAddressCoorddinates"] == nil) {
        [calculatePriceButton setHidden:YES];
    }
    else {
        [calculatePriceButton setHidden:NO];
    }
    
    [calculatePriceButton setHidden:NO];
    
    
    packetRouteBeginTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userStartAddress"];
    packetRouteEndTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userEndAddress"];
}





- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [packetRouteBeginTextField resignFirstResponder];
    [packetRouteEndTextField resignFirstResponder];
    [packetSizePickerView setHidden:YES];
    
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
    [packetSizePickerView setHidden:NO];
}



#pragma mark Picker View Data Source

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


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSMutableArray *zahlenArray = [NSMutableArray array];
    
    for (int i = 1; i < 41; i++) {
        [zahlenArray addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    return [zahlenArray objectAtIndex:row];
}



- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSMutableArray *zahlenArray = [NSMutableArray array];
    
    for (int i = 1; i < 41; i++) {
        [zahlenArray addObject:[NSNumber numberWithInt:i]];
    }
    
    id kgInt = [zahlenArray objectAtIndex:row];
    kgInteger = [kgInt integerValue];
    
    packetSizeButton.titleLabel.text = [NSString stringWithFormat:@"%@kg", [zahlenArray objectAtIndex:row]];
}







#pragma mark Locate user


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
}

- (IBAction)locateEndButton:(id)sender {
    
    [self performSegueWithIdentifier:@"pricingToEndMapView" sender:self];
}



- (IBAction)contactsBeginButton:(id)sender {
    
    [self performSegueWithIdentifier:@"pricingToStartAddress" sender:self];
}

- (IBAction)contactsEndButton:(id)sender {

    [self performSegueWithIdentifier:@"pricingToEndAddress" sender:self];
}






#pragma mark Calculate Price


- (IBAction)calculatePriceButton:(id)sender {
    
    NSDictionary *startDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:@"userStartLocationDict"];
    NSDictionary *endDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:@"userEndLocationDict"];
    
    
    CLLocation *startLocation = [[CLLocation alloc] initWithLatitude:[[startDictionary objectForKey:@"latitude"] doubleValue] longitude:[[startDictionary objectForKey:@"longitude"] doubleValue]];
    CLLocation *endLocation = [[CLLocation alloc] initWithLatitude:[[endDictionary objectForKey:@"latitude"] doubleValue] longitude:[[endDictionary objectForKey:@"longitude"] doubleValue]];
    
    
    
    
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


- (float)calculatePriceWithWeight:(int)weightInteger basePriceDictionary:(NSMutableDictionary *)basePriceDictonary withDictionaryKey:(NSString *)baseKey andDistancePriceDictionary:(NSMutableDictionary *)distancePriceDictionary withDictionaryKey:(NSString *)distanceKey
{
    float variance = weightInteger;
    // Percentage
    variance = variance * 0.1;
    
    float basePrice = [[basePriceDictonary valueForKey:baseKey] floatValue] * variance;
    
    float distancePrice = [[basePriceDictonary valueForKey:distanceKey] floatValue];
    float price = basePrice + distancePrice;
    
    return price;
}


@end
