//
//  Model.h
//  iCorrupción
//
//  Created by Mauricio Quezada on 03/11/14.
//  Copyright (c) 2014 com.mesquitestudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Complaints : NSManagedObject

@property (nonatomic, retain) NSString * complaints;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * media;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * userLat;
@property (nonatomic, retain) NSNumber * userLon;
@property (nonatomic, retain) NSNumber * type;

@end
