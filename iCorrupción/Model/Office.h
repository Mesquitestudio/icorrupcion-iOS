//
//  Office.h
//  iCorrupción
//
//  Created by Mauricio Quezada on 03/11/14.
//  Copyright (c) 2014 com.mesquitestudio. All rights reserved.
//

#import <Mantle.h>

@interface Office : MTLModel <MTLJSONSerializing>

@property (strong) NSString *name;
@property (strong) NSString *phone;
@property (strong) NSString *manager;
@property (strong) NSString *image;
@property (strong) NSString *timetable;
@property (assign) float latitude;
@property (assign) float longitude;

@end
