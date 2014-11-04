//
//  ComplaintDetailViewController.m
//  iCorrupción
//
//  Created by Arturo Buentello on 11/3/14.
//  Copyright (c) 2014 com.mesquitestudio. All rights reserved.
//

#import "ComplaintDetailViewController.h"

@interface ComplaintDetailViewController ()

@end

@implementation ComplaintDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self setTitle:self.complaint.title];
    [self.complaintsTextField setText:self.complaint.complaints];
    [self.complaintsTextField setFont:[UIFont fontWithName:@"Helvetica" size:16.0f]];
    [self.folioLabel setText:[NSString stringWithFormat:@"Num. Folio: %@", self.complaint.id]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
