//
//  OfficeViewController.m
//  iCorrupción
//
//  Created by Mesquitestudio on 10/6/14.
//  Copyright (c) 2014 com.mesquitestudio. All rights reserved.
//

#import "OfficeViewController.h"
#import "OfficeCell.h"
#import "IAClient.h"
#import "Office.h"
#import <UIImageView+AFNetworking.h>
#import <MapKit/MapKit.h>

@interface OfficeViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong) NSMutableArray *officeArray;

@end

#pragma mark - UIViewController

@implementation OfficeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Init
    self.officeArray = [[NSMutableArray alloc] init];
    
    //Navigation
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"atras"]
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(back)];
    [self.navigationItem setLeftBarButtonItem:leftBtn];
    
    //Get Office Service
    [[IAClient sharedClient] getOfficeOnCompletion:^(NSDictionary *responseObject, NSError *responseError) {
        if(!responseError){
            NSError *error;
            for (NSDictionary *officeDic in [responseObject objectForKey:@"office"]) {
                Office *office = [MTLJSONAdapter modelOfClass:[Office class]
                                           fromJSONDictionary:officeDic
                                                        error:&error];
                [self.officeArray addObject:office];
                [self.tableView reloadData];
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Actions

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Methods

- (void)callOffice:(NSString *)office{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",office]];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)openMap:(CLLocationCoordinate2D)coor{
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coor addressDictionary:nil];
    MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:placemark];
    [item openInMapsWithLaunchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving}];
}

- (void)openInfo:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Informacion"
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.officeArray.count != 0) {
        return self.officeArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"OfficeCell";
    
    OfficeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Office *office = [self.officeArray objectAtIndex:indexPath.row];
    [[cell officeImage] setImageWithURL:[NSURL URLWithString:office.image] placeholderImage:[UIImage imageNamed:@"anonimo"]];
    
    [cell setDidTapPhoneButtonBlock:^(id sender) {
        [self callOffice:office.phone];
    }];
    
    [cell setDidTapLocationButtonBlock:^(id sender) {
        CLLocationCoordinate2D endingCoord = CLLocationCoordinate2DMake(office.latitude, office.longitude);
        [self openMap:endingCoord];
    }];
    
    [cell setDidTapInfoButtonBlock:^(id sender) {
        [self openInfo:office.timetable];
    }];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 168.0f;
}

@end
