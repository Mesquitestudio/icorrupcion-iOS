//
//  MyDataViewController.m
//  iCorrupción
//
//  Created by Mesquitestudio on 10/6/14.
//  Copyright (c) 2014 com.mesquitestudio. All rights reserved.
//

#import "MyDataViewController.h"

@interface MyDataViewController ()
@property (strong, nonatomic) IBOutlet UIButton *btnSave;
@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtAddress;
@property (strong, nonatomic) IBOutlet UITextField *txtPhone;

@end

@implementation MyDataViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //**** Return to Menu ****//
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"atras"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self.navigationItem setLeftBarButtonItem:leftBtn];
    
    //**** Textfield delegate ****//
    self.txtName.delegate = self;
    self.txtEmail.delegate = self;
    self.txtAddress.delegate = self;
    self.txtPhone.delegate = self;
    
    //**** Hide Keyboard ****//
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(finishEditing)]];
    
    //**** Set User Data ****//
    NSMutableDictionary  *UserDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserDictionary"];
    NSLog(@"Dict: %@", UserDictionary);
    self.txtName.text = [UserDictionary objectForKey:@"uname"];
    self.txtEmail.text = [UserDictionary objectForKey:@"uemail"];
    self.txtAddress.text = [UserDictionary objectForKey:@"uaddress"];
    self.txtPhone.text = [UserDictionary objectForKey:@"uphone"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSave:(id)sender {
    NSMutableDictionary *UserDictionary = [NSMutableDictionary dictionaryWithDictionary:
                                       @{@"uname":self.txtName.text,
                                         @"uemail":self.txtEmail.text,
                                         @"uaddress":self.txtAddress.text,
                                         @"uphone":self.txtPhone.text
                                         }];
    
    NSLog(@"Dict: %@", UserDictionary);
    
    [[NSUserDefaults standardUserDefaults] setObject:UserDictionary forKey:@"UserDictionary"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - UITextField delegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

-(void)finishEditing
{
    [self.view endEditing:YES];
}

@end
