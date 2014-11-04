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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setTitle:self.complaint.title];
    [self.complaintsTextField setText:self.complaint.complaints];
    [self.folioLabel setText:[NSString stringWithFormat:@"Num. Folio: %@", self.complaint.id]];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
