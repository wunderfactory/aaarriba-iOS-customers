//
//  ContactsViewController.m
//  Aaarriba
//
//  Created by David Pflugpeil on 23.03.14.
//  Copyright (c) 2014 wunderfactory. All rights reserved.
//

#import "ContactsViewController.h"

@interface ContactsViewController ()

@property (strong, nonatomic) NSMutableArray *contactsArray;
@property (strong, nonatomic) ABPeoplePickerNavigationController *addressBookController;

- (void)showAddressbook;

@end


@implementation ContactsViewController

@synthesize contactsArray, addressBookController;



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

    
    contactsArray = [[NSMutableArray alloc] init];
    
    sleep(5);
    
    [self showAddressbook];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)showAddressbook
{
    addressBookController = [[ABPeoplePickerNavigationController alloc] init];
    [addressBookController setPeoplePickerDelegate:self];
    [self presentViewController:addressBookController animated:YES completion:nil];
}

-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [addressBookController dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    NSMutableDictionary *contactInfoDictionary = [[NSMutableDictionary alloc] initWithObjects:@[@"", @"", @"", @"", @""] forKeys:@[@"firstName", @"lastName", @"address", @"zip", @"city"]];
    
    CFTypeRef generalCFObject = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    
    if (generalCFObject) {
        [contactInfoDictionary setObject:(__bridge NSString *)generalCFObject forKey:@"firstname"];
        CFRelease(generalCFObject);
    }
    
    
    
    generalCFObject = ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    if (generalCFObject) {
        [contactInfoDictionary setObject:(__bridge NSString *)generalCFObject forKey:@"lastname"];
        CFRelease(generalCFObject);
    }
    
    
    
    ABMultiValueRef addressRef = ABRecordCopyValue(person, kABPersonAddressProperty);
    
    if (ABMultiValueGetCount(addressRef) > 0) {
        NSDictionary *addressDict = (__bridge NSDictionary *)ABMultiValueCopyValueAtIndex(addressRef, 0);
        
        [contactInfoDictionary setObject:[addressDict objectForKey:(NSString *)kABPersonAddressStreetKey] forKey:@"address"];
        [contactInfoDictionary setObject:[addressDict objectForKey:(NSString *)kABPersonAddressZIPKey] forKey:@"zipCode"];
        [contactInfoDictionary setObject:[addressDict objectForKey:(NSString *)kABPersonAddressCityKey] forKey:@"city"];
    }
    
    CFRelease(generalCFObject);
    
    
    
    [contactsArray addObject:contactInfoDictionary];
    
    NSLog(@"%@", contactsArray);
    
    [addressBookController dismissViewControllerAnimated:YES completion:nil];
    
    
    return NO;
}

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
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
