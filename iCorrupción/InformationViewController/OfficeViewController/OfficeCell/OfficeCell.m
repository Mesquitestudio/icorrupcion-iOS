//
//  OfficeCell.m
//  iCorrupción
//
//  Created by Mesquitestudio on 10/6/14.
//  Copyright (c) 2014 com.mesquitestudio. All rights reserved.
//

#import "OfficeCell.h"

@interface OfficeCell ()

@property (copy, nonatomic) void (^didTapPhoneButtonBlock)(id sender);
@property (copy, nonatomic) void (^didTapLocationButtonBlock)(id sender);
@property (copy, nonatomic) void (^didTapInfoButtonBlock)(id sender);

@end

@implementation OfficeCell

- (void)awakeFromNib {
    // Initialization code
    [self.officePhone addTarget:self action:@selector(didTapPhoneButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.officeLocation addTarget:self action:@selector(didTapLocationButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.officeInformation addTarget:self action:@selector(didTapInfoButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)didTapPhoneButton:(id)sender
{
    if (self.didTapPhoneButtonBlock) {
        self.didTapPhoneButtonBlock(sender);
    }
}

- (void)didTapLocationButton:(id)sender
{
    if (self.didTapLocationButtonBlock) {
        self.didTapLocationButtonBlock(sender);
    }
}

- (void)didTapInfoButton:(id)sender
{
    if (self.didTapInfoButtonBlock) {
        self.didTapInfoButtonBlock(sender);
    }
}

@end
