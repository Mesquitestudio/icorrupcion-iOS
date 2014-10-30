//
//  CustomAnnotation.m
//  VADoc
//
//  Created by Mesquitestudio on 10/6/14.
//  Copyright (c) 2014 com.mesquitestudio. All rights reserved.
//

#import "CustomAnnotation.h"

@implementation CustomAnnotation

@synthesize title;
@synthesize subtitle;
@synthesize identifier;
@synthesize coordinate;

- (id)initWithTitle:(NSString *)atitle subtitle:(NSString *)sub identifier:(NSNumber *)ide andCoordinate:(CLLocationCoordinate2D)coord
{
    if ((self = [super init])) {
        self.title = atitle;
        self.subtitle = sub;
        self.identifier = ide;
        self.coordinate = coord;
    }
    return self;
}

@end
