//
//  IAClient.m
//
//  Copyright (c) 2014 Kiawetech. All rights reserved.
//

#import "IAClient.h"
#import "Complaints.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif


static NSString *const kApplaudorAPIBaseURLString = @"http://icorrupcion.mesquitestudio.com/ws";

@interface IAClient()

@property (strong) NSURLSessionDataTask *currentEntitySearchTask;

@end

@implementation IAClient

+ (IAClient *)sharedClient { 
    static IAClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // Session configuration setup
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024     // 10MB. memory cache
                                                          diskCapacity:50 * 1024 * 1024     // 50MB. on disk cache
                                                              diskPath:nil];
        
        sessionConfiguration.URLCache = cache;
        sessionConfiguration.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
        
        //Make Instance
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kApplaudorAPIBaseURLString] sessionConfiguration:sessionConfiguration];
        
    });
    
    return _sharedClient;
}

#pragma mark - Complaint

- (void)sendComplaintWithParams:(NSDictionary *)paramsDict image:(UIImage *)image video:(NSData *)video onCompletion:(FetchDataCompletionBlock)completionBlock{
    NSString *path = @"complaint";
    
    [self POST:path parameters:paramsDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if(image != nil){
            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.6) name:@"image" fileName:@"image.jpg" mimeType:@"image/jpeg"];
        }
        
        if(video != nil){
            [formData appendPartWithFileData:video name:@"video" fileName:@"video.mov" mimeType:@"video/quicktime"];
        }
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if (image != nil) {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        }
        completionBlock(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completionBlock(nil, error);
    }];
}

#pragma mark - Rate

- (void)sendRateWithParams:(NSDictionary *)paramsDict onCompletion:(FetchDataCompletionBlock)completionBlock{
    
    NSString *path = [NSString stringWithFormat:@"ranking"];
    
    [self POST:path parameters:paramsDict success:^(NSURLSessionDataTask *task, id responseObject) {
        completionBlock(responseObject,nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completionBlock(nil, error);
    }];
}

#pragma mark - Office

- (void)getOfficeOnCompletion:(FetchDataCompletionBlock)completionBlock{
    
    NSString *path = [NSString stringWithFormat:@"office"];
    
    [self GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        completionBlock(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completionBlock(nil, error);
    }];
}


#pragma mark - Methods

- (UIImage *)imageByScalingProportionally:(UIImage *)theImage ToSize:(CGSize)targetSize
{
    
    UIImage *sourceImage = theImage;
    UIImage *newImage = nil;
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor < heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        
        if (widthFactor < heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor > heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    // this is actually the interesting part:
    UIGraphicsBeginImageContext(CGSizeMake(scaledWidth, scaledHeight));
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero; //thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(newImage == nil) NSLog(@"could not scale image");
    
    
    return newImage ;
}

@end
