//
//  DPWebConnector.m
//  DPWebConnector
//
//  Created by David Pflugpeil on 24.03.14.
//  Copyright (c) 2014 David Pflugpeil. All rights reserved.
//

#import "DPWebConnector.h"

@implementation DPWebConnector

+ (void)connectionWithURLString:(NSString *)webURLString
{
    NSURL *webURL = [NSURL URLWithString:webURLString];
    
    NSMutableURLRequest *webRequest = [NSMutableURLRequest requestWithURL:webURL];
    [webRequest setHTTPMethod:@"GET"];
    [webRequest setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:webRequest delegate:self];
    [connection start];
}


@end
