//
//  CustomAnnotation.h
//  VADoc
//
//  Created by Mesquitestudio on 10/6/14.
//  Copyright (c) 2014 com.mesquitestudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CustomAnnotation : NSObject <MKAnnotation>{
    NSString *title;
    NSString *subtitle;
    NSNumber *identifier;
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;

- (id)initWithTitle:(NSString *)title subtitle:(NSString *)sub identifier:(NSNumber *)ide andCoordinate:(CLLocationCoordinate2D)coord;

@end
