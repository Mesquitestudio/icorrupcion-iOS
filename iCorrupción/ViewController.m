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
#import <MZFormSheetController.h>

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ViewCell";
    
    ViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if ([indexPath row] == 0) {
        cell.cellViewImage.image = [UIImage imageNamed:@"denuncia1"];
        cell.backgroundColor = [UIColor colorWithRed:((float) 227.0 / 255.0f) green:((float) 100.0 / 255.0f) blue:((float) 75.0 / 255.0f) alpha:1.0f];
//        [self performSegueWithIdentifier:@"Save" sender:self];
    }
    
    else if ([indexPath row] == 1) {
        cell.cellViewImage.image = [UIImage imageNamed:@"denuncia2"];
        cell.backgroundColor = [UIColor colorWithRed:((float) 233.0 / 255.0f) green:((float) 128.0 / 255.0f) blue:((float) 79.0 / 255.0f) alpha:1.0f];
    }
    
    else if ([indexPath row] == 2) {
        cell.cellViewImage.image = [UIImage imageNamed:@"denuncia3"];
        cell.backgroundColor = [UIColor colorWithRed:((float) 239.0 / 255.0f) green:((float) 157.0 / 255.0f) blue:((float) 82.0 / 255.0f) alpha:1.0f];
    }
    
    else if ([indexPath row] == 3) {
        cell.cellViewImage.image = [UIImage imageNamed:@"denuncia4"];
        cell.backgroundColor = [UIColor colorWithRed:((float) 239.0 / 255.0f) green:((float) 184.0 / 255.0f) blue:((float) 86.0 / 255.0f) alpha:1.0f];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *ID = [segue identifier];
    
    if([ID isEqualToString:@"New"])
    {
//        ComplaintViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"New"];
//        
//        // present form sheet with view controller
//        [self mz_presentFormSheetController:vc animated:YES completionHandler:^(MZFormSheetController *formSheetController) {
//            //do sth
//        }];
//        
    }
//    else if ([ID isEqualToString:@"Save"]){
//        
//    }
//    
//    
}

@end

