//
//  PacketViewController.h
//  Aaarriba
//
//  Created by David Pflugpeil on 03.04.14.
//  Copyright (c) 2014 wunderfactory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PacketViewController : UIViewController

@property (readonly, nonatomic) AVCaptureSession *session;
@property (readonly, nonatomic) AVCaptureDevice *device;
@property (readonly, nonatomic) AVCaptureDeviceInput *input;
@property (readonly, nonatomic) AVCaptureMetadataOutput *output;
@property (readonly, nonatomic) AVCaptureVideoPreviewLayer *prevLayer;

@property (weak, nonatomic) IBOutlet UILabel *outputLabel;

@end
