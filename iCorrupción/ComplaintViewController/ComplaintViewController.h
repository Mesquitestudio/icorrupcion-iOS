//
//  ComplaintViewController.h
//  iCorrupción
//
//  Created by Mesquitestudio on 10/6/14.
//  Copyright (c) 2014 com.mesquitestudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <MediaPlayer/MediaPlayer.h>
#import "CustomAnnotation.h"

@interface ComplaintViewController : UIViewController <UIImagePickerControllerDelegate, CLLocationManagerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>
-(void)mapDropPinDidFinish:(CustomAnnotation *)annotation;
-(void)mapDroPinCancel;
@end
