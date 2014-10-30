//
//  IAClient.h
//
//  Copyright (c) 2014 Kiawetech. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import <CoreLocation/CoreLocation.h>

typedef void (^FetchDataCompletionBlock)(NSDictionary *responseObject, NSError *responseError);

@interface IAClient : AFHTTPSessionManager

+ (IAClient *)sharedClient;

#pragma mark - send Complaint
-(void)sendComplaintWithParams:(NSDictionary *)paramsDict image:(UIImage *)image video:(NSData *)video onCompletion:(FetchDataCompletionBlock)completionBlock;

@end
