//
//  RateViewController.m
//  iCorrupción
//
//  Created by Mesquitestudio on 10/6/14.
//  Copyright (c) 2014 com.mesquitestudio. All rights reserved.
//

#import "RateViewController.h"
#import "IAClient.h"

@interface RateViewController ()

@property (weak, nonatomic) IBOutlet EDStarRating *starRatingImage;
@property (strong, nonatomic) IBOutlet UITextField *txtTitle;
@property (strong, nonatomic) IBOutlet UITextField *txtDescription;
@property (strong, nonatomic) IBOutlet UIButton *btnSend;
@property (strong) NSString *strRate;

@end

@implementation RateViewController

@synthesize starRatingImage = _starRatingImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //**** Return to Menu ****//
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"atras"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self.navigationItem setLeftBarButtonItem:leftBtn];
    
    //**** Star - rate ****//
    _starRatingImage.starImage = [UIImage imageNamed:@"estrellagris.png"];
    _starRatingImage.starHighlightedImage = [UIImage imageNamed:@"estrella.png"];
    _starRatingImage.maxRating = 5.0;
    _starRatingImage.delegate = self;
    _starRatingImage.horizontalMargin = 12;
    _starRatingImage.editable=YES;
    _starRatingImage.rating= 0.0;
    _starRatingImage.displayMode=EDStarRatingDisplayAccurate;
    [self starsSelectionChanged:_starRatingImage rating:0.0];
    _starRatingImage.returnBlock = ^(float rating )
    {
        [self starsSelectionChanged:_starRatingImage rating:rating];
    };
    
    //**** Textfield delegate ****//
    self.txtTitle.delegate = self;
    self.txtDescription.delegate = self;
    
    //**** Hide Keyboard ****//
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(finishEditing)]];
}

- (void)viewDidUnload{
    [super viewDidUnload];
    [self setStarRatingImage:nil];
    // Release any retained subviews of the main view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - save

- (BOOL)validateRate
{
    if(self.txtTitle.text.length == 0 && self.txtDescription.text.length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Aviso", @"Titulo de alerta para nombre faltante en entidad") message:NSLocalizedString(@"El título y el comentario no pueden estar vacíos", @"Aviso") delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    return YES;
}

- (IBAction)btnSend:(id)sender {
    
    if ([self validateRate]) {

    NSMutableDictionary *paramsDict = [NSMutableDictionary dictionaryWithDictionary:
                                       @{@"title":self.txtTitle.text,
                                         @"description":self.txtDescription.text,
                                         @"score": [NSString stringWithFormat:@"%d", (int) _starRatingImage.rating]
                                         }];
    
    [[IAClient sharedClient] sendRateWithParams:paramsDict onCompletion:^(NSDictionary *responseObject, NSError *responseError){

        if(!responseError){
            NSLog(@"enviado");
        }else{
            NSLog(@"no enviado");
        }
        
    }];
    }

}


- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)starsSelectionChanged:(EDStarRating *)control rating:(float)rating
{
     self.strRate = [NSString stringWithFormat:@"Rating: %.1f", rating];
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
