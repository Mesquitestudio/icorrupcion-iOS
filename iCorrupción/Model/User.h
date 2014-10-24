//
//  User.h
//
//  Copyright (c) 2014 Kiawetech. All rights reserved.
//

#import <Mantle.h>

typedef void (^FetchDataCompletionBlock)(NSDictionary *responseObject, NSError *responseError);

@interface User : MTLModel <MTLJSONSerializing>

@property (strong) NSNumber *Id;
@property (strong) NSString *name;
@property (strong) NSNumber *telephone;
@property (strong) NSString *address;
@property (strong) NSString *email;
@end
