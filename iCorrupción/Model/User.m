//
//  User.m
//
//  Copyright (c) 2014 Kiawetech. All rights reserved.
//

#import "User.h"

@implementation User

#pragma mark - NSValueTransformer

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"Id": @"user.id_u",
             @"name": @"user.name",
             @"telephone": @"user.telephone",
             @"address": @"user.address",
             @"email": @"user.email"
             };
}

@end
