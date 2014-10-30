//
//  MapDropPinViewController.h
//  Integrapp
//
//  Created by Mesquitestudio on 10/6/14.
//  Copyright (c) 2014 com.mesquitestudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CustomAnnotation.h"
@protocol MapDropPinViewControllerDelegate;


@interface MapDropPinViewController : UIViewController <MKMapViewDelegate>

@property (assign) id<MapDropPinViewControllerDelegate>delegate;
@property (strong) CustomAnnotation *fixedEntityAnnotation;
@property (assign) BOOL enableEditing;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andCoordinates:(CLLocationCoordinate2D)coordinates andPinTitle:(NSString *)pinTitle;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPinTitle:(NSString *)pinTitle;
@end

@protocol MapDropPinViewControllerDelegate <NSObject>

@optional
-(void)mapDropPinDidFinish:(CustomAnnotation *)annotation;

@end
