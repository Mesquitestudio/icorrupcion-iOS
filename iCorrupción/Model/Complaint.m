//
//  Entity.m
//
//  Copyright (c) 2014 Kiawetech. All rights reserved.
//

#import "Complaint.h"

@interface Complaint ()

@property (strong) NSURLSessionDataTask *currentFeebackSearchTask;

@end

@implementation Complaint

#pragma mark - NSValueTransformer

//+ (NSDictionary *)JSONKeyPathsByPropertyKey {
//    return @{
//             @"Id": @"entity.id_aentity",
//             @"name": @"entity.name",
//             @"keyword1": @"entity.key1",
//             @"keyword2": @"entity.key2",
//             @"keyword3": @"entity.key3",
//             @"keyword4": @"entity.key4",
//             @"imageProfile":@"entity.imagepri",
//             @"imageOptional":@"entity.imagesec",
//             @"appl" : @"entity.appl",
//             @"dueDate":@"entity.dueDate",
//             @"user": @"entity.username",
//             @"username": @"entity.username",
//             @"recordDate":@"entity.recordDate"
//             };
//}

+ (NSValueTransformer *)typeJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return @([str intValue]);
    } reverseBlock:^(NSNumber *number) {
        return [number stringValue];
    }];
}

+ (NSValueTransformer *)recordDateJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.dateFormatterReceiving dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [self.dateFormatterReceiving stringFromDate:date];
    }];
}

+ (NSValueTransformer *)imageProfileJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)imageOptionalJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSDateFormatter *)dateFormatterReceiving
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale currentLocale];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return dateFormatter;
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
