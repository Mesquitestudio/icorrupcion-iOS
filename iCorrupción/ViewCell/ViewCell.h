//
//  ViewCell.h
//  iCorrupción
//
//  Created by Mesquitestudio on 10/6/14.
//  Copyright (c) 2014 com.mesquitestudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *cellViewName;
@property (strong, nonatomic) IBOutlet UILabel *cellViewDate;
@property (strong, nonatomic) IBOutlet UIImageView *cellViewImage;

@end
