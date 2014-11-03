//
//  OfficeCell.h
//  iCorrupción
//
//  Created by Mesquitestudio on 10/6/14.
//  Copyright (c) 2014 com.mesquitestudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfficeCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *officeImage;
@property (strong, nonatomic) IBOutlet UIButton *officePhone;
@property (strong, nonatomic) IBOutlet UIButton *officeLocation;
@property (strong, nonatomic) IBOutlet UIButton *officeInformation;

- (void)setDidTapPhoneButtonBlock:(void (^)(id sender))didTapPhoneButtonBlock;
- (void)setDidTapLocationButtonBlock:(void (^)(id sender))didTapLocationButtonBlock;
- (void)setDidTapInfoButtonBlock:(void (^)(id sender))didTapInfoButtonBlock;

@end
