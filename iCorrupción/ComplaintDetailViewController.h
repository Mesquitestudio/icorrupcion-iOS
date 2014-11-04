//
//  ComplaintDetailViewController.h
//  iCorrupción
//
//  Created by Arturo Buentello on 11/3/14.
//  Copyright (c) 2014 com.mesquitestudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Complaints.h"

@interface ComplaintDetailViewController : UIViewController

@property Complaints *complaint;

@property (weak, nonatomic) IBOutlet UITextView *complaintsTextField;
@property (weak, nonatomic) IBOutlet UILabel *folioLabel;

@end
