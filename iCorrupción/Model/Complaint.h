//
//  Entity.h
//
//  Copyright (c) 2014 Kiawetech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTLModel.h"
#import "User.h"

typedef void (^FetchDataCompletionBlock)(NSDictionary *responseObject, NSError *responseError);

@interface Complaint : MTLModel <MTLJSONSerializing>

@property (strong) NSNumber *Id;
@property (strong) NSString *name;
@property (strong) NSString *description;
@property (strong) NSString *latitude;
@property (strong) NSString *longitude;
@property (strong) NSString *latitudeUser;
@property (strong) NSString *longitudeUser;
@property (strong) UIImage *photo;
@property (strong) UIImage *video;
@property (strong) NSURL *photoURL;
@property (strong) NSURL *videoURL;
@property (strong) User *user;
@property (strong) NSDate *recordDate;

@end

