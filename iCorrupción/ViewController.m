//
//  ViewController.m
//  iCorrupción
//
//  Created by Mesquitestudio on 10/6/14.
//  Copyright (c) 2014 com.mesquitestudio. All rights reserved.
//

#import "ViewController.h"
#import "ViewCell.h"
#import "ComplaintViewController.h"
#import "ComplaintDetailViewController.h"
#import <MZFormSheetController.h>
#import "Complaints.h"
#import <CoreData+MagicalRecord.h>

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong) NSArray *complaintsArray;

@end

@implementation ViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.complaintsArray = [Complaints MR_findAll];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.complaintsArray = [Complaints MR_findAll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //NSString *ID = [segue identifier];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.complaintsArray.count != 0) {
        return self.complaintsArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ViewCell";
    
    ViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Complaints *complaint = [self.complaintsArray objectAtIndex:indexPath.row];
    
    switch ([complaint.type intValue]) {
        case 2:{
            cell.cellViewImage.image = [UIImage imageNamed:@"denuncia2"];
            cell.backgroundColor = [UIColor colorWithRed:((float) 233.0 / 255.0f) green:((float) 128.0 / 255.0f) blue:((float) 79.0 / 255.0f) alpha:1.0f];
            break;
        }
        case 3:{
            cell.cellViewImage.image = [UIImage imageNamed:@"denuncia3"];
            cell.backgroundColor = [UIColor colorWithRed:((float) 239.0 / 255.0f) green:((float) 157.0 / 255.0f) blue:((float) 82.0 / 255.0f) alpha:1.0f];
            break;
        }
        case 4:{
            cell.cellViewImage.image = [UIImage imageNamed:@"denuncia4"];
            cell.backgroundColor = [UIColor colorWithRed:((float) 239.0 / 255.0f) green:((float) 184.0 / 255.0f) blue:((float) 86.0 / 255.0f) alpha:1.0f];
            break;
        }
        default:
            cell.cellViewImage.image = [UIImage imageNamed:@"denuncia1"];
            cell.backgroundColor = [UIColor colorWithRed:((float) 227.0 / 255.0f) green:((float) 100.0 / 255.0f) blue:((float) 75.0 / 255.0f) alpha:1.0f];
            break;
    }
    cell.cellViewName.text = complaint.title;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Complaints *complaint = [self.complaintsArray objectAtIndex:indexPath.row];
    ComplaintDetailViewController *complaintDetailVC = [[self storyboard] instantiateViewControllerWithIdentifier:@"ComplaintDetailViewController"];
    [complaintDetailVC setComplaint:complaint];
    [[self navigationController] pushViewController:complaintDetailVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

