//
//  Complaint.h
//  iCorrupción
//
//  Created by Benjamin Gonzalez on 10/31/14.
//  Copyright (c) 2014 com.mesquitestudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Complaint : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * complaints;

@end
