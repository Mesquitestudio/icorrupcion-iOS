//
//  ComplaintViewController.m
//  iCorrupción
//
//  Created by Mesquitestudio on 10/6/14.
//  Copyright (c) 2014 com.mesquitestudio. All rights reserved.
//

#import "ComplaintViewController.h"
#import "MapDropPinViewController.h"
#import "SIAlertView.h"

@interface ComplaintViewController () <MapDropPinViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UIButton *btnAnonymous;
@property (strong, nonatomic) IBOutlet UIButton *btnAttachment;
@property (strong, nonatomic) IBOutlet UIButton *btnLocation;
@property (strong, nonatomic) IBOutlet UIButton *btnVideo;
@property (strong, nonatomic) IBOutlet UIButton *btnPhoto;
@property (strong, nonatomic) IBOutlet UIButton *btnSite;
@property (strong, nonatomic) IBOutlet UITextField *txtTitle;
@property (strong, nonatomic) IBOutlet UITextField *txtDescription;

@property (strong) UIImage *ComplaintImage;
@property (strong) NSData *ComplaintVideo;
@property CLLocationCoordinate2D ComplaintCoordinate;
@property (strong) NSString *ComplaintSiteLatitude;
@property (strong) NSString *ComplaintSiteLongitude;

@property (strong) CLLocationManager *locationManager;
@property (strong) UIImagePickerController *cameraPicker;
@property (strong) UIImagePickerController *videoPicker;

@property BOOL bolAnonymouse;
@property BOOL bolVideo;
@property BOOL bolLocation;
@property BOOL bolSite;
@property BOOL bolErrorLocation;

@end

@implementation ComplaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //**** Return to Menu ****//
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cancelar"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self.navigationItem setLeftBarButtonItem:leftBtn];
    
    //**** Camera Picker ****//
    self.cameraPicker = [[UIImagePickerController alloc] init];
    self.cameraPicker.delegate = self;
    
    //**** Video Picker ****//
    self.videoPicker = [[UIImagePickerController alloc] init];
    self.videoPicker.delegate = self;
    
    //**** Location ****//
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    //**** Textfield delegate ****//
    self.txtTitle.delegate = self;
    self.txtDescription.delegate = self;
    
    //**** Hide Keyboard ****//
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(finishEditing)]];
    
    //**** Initial Colors ****//
    [self.btnAnonymous setBackgroundColor:[UIColor colorWithRed:166/255.0 green:168/255.0 blue:171/255.0 alpha:1]];
    [self.btnAttachment setBackgroundColor:[UIColor colorWithRed:166/255.0 green:168/255.0 blue:171/255.0 alpha:1]];
    [self.btnLocation setBackgroundColor:[UIColor colorWithRed:166/255.0 green:168/255.0 blue:171/255.0 alpha:1]];
    [self.btnVideo setBackgroundColor:[UIColor colorWithRed:166/255.0 green:168/255.0 blue:171/255.0 alpha:1]];
    [self.btnPhoto setBackgroundColor:[UIColor colorWithRed:166/255.0 green:168/255.0 blue:171/255.0 alpha:1]];
    [self.btnSite setBackgroundColor:[UIColor colorWithRed:166/255.0 green:168/255.0 blue:171/255.0 alpha:1]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *ID = [segue identifier];
    
    if([ID isEqualToString:@"Location"])
    {
        MapDropPinViewController *mapPinVC = [[MapDropPinViewController alloc] initWithNibName:@"MapDropPinViewController" bundle:nil andPinTitle:NSLocalizedString(@"Ubicación de Feedback", @"Titulo de pin en mapa al dar de alta")];
        mapPinVC.delegate = self;
    }
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    
    if (self.bolSite) {
        self.bolSite = false;
        return NO;
    }
    else{
        self.bolSite = true;
        return YES;
    }
}

#pragma mark - Actions

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnAnonymous:(id)sender {
    if (self.bolAnonymouse) {
        self.bolAnonymouse = false;
        [self.btnAnonymous setBackgroundColor:[UIColor colorWithRed:166/255.0 green:168/255.0 blue:171/255.0 alpha:1]];
    }
    else
    {
        [self personAlert];
        [self.btnAnonymous setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:184/255.0 blue:86/255.0 alpha:1]];
    }
}

- (IBAction)btnAttachment:(id)sender {
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Alerta" message:@"La funcionalidad de Adjunto estará lista para la siguiente fase." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
    
    //[self.btnAttachment setBackgroundColor:[UIColor colorWithRed:239/255.0 green:157/255.0 blue:82/255.0 alpha:1]];
}

- (IBAction)btnLocation:(id)sender {
    if (!self.bolLocation && !self.bolErrorLocation)
    {
        [self locationAlert];
        [self.btnLocation setBackgroundColor:[UIColor colorWithRed:233/255.0 green:128/255.0 blue:79/255.0 alpha:1]];
    }
    else if (self.bolErrorLocation)
    {
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle:@"Alerta" message:@"Error al obtener tu ubicación" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
    }
    else
    {
        self.bolLocation = false;
        [self.btnLocation setBackgroundColor:[UIColor colorWithRed:166/255.0 green:168/255.0 blue:171/255.0 alpha:1]];
    }
}

- (IBAction)btnVideo:(id)sender {
    self.bolVideo = TRUE;
    [self captureVideo];
    [self.btnVideo setBackgroundColor:[UIColor colorWithRed:227/255.0 green:100/255.0 blue:75/255.0 alpha:1]];
}

- (IBAction)btnPhoto:(id)sender {
    self.bolVideo = FALSE;
    [self capturePhoto];
    [self.btnPhoto setBackgroundColor:[UIColor colorWithRed:240/255.0 green:89/255.0 blue:72/255.0 alpha:1]];
}

- (IBAction)btnSite:(id)sender {
    if (self.bolSite) {
        [self.btnSite setBackgroundColor:[UIColor colorWithRed:166/255.0 green:168/255.0 blue:171/255.0 alpha:1]];
    }
    else
    {
        [self.btnSite setBackgroundColor:[UIColor colorWithRed:214/255.0 green:76/255.0 blue:55/255.0 alpha:1]];
    }
}

-(void)locationAlert{
    SIAlertView *alert = [[SIAlertView alloc] initWithTitle:NSLocalizedString(@"Aviso", @"Titulo de alerta cuando se va agregar ubicación")
                                                 andMessage:NSLocalizedString(@"¿Deseas enviar tu ubicación actual?", @"Titulo de alerta cuando se va agregar ubicación")];
    
    [alert addButtonWithTitle:NSLocalizedString(@"Si", @"Opcion Si")
                         type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                             CLLocation *loc = [self.locationManager location];
                             self.ComplaintCoordinate = [loc coordinate];
                             NSLog(@"%f", self.ComplaintCoordinate.longitude);
                             NSLog(@"%f", self.ComplaintCoordinate.latitude);
                             self.bolLocation = true;
                         }];
    
    [alert addButtonWithTitle:NSLocalizedString(@"No", @"Opcion No")
                         type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                             [self.btnLocation setBackgroundColor:[UIColor colorWithRed:166/255.0 green:168/255.0 blue:171/255.0 alpha:1]];
                         }];
    
    [alert show];
}

-(void)personAlert{
    SIAlertView *alert = [[SIAlertView alloc] initWithTitle:NSLocalizedString(@"Aviso", @"Titulo de alerta cuando se va agregar ubicación")
                                                 andMessage:NSLocalizedString(@"¿Deseas compartir tus datos?", @"Titulo de alerta cuando se va agregar ubicación")];
    
    [alert addButtonWithTitle:NSLocalizedString(@"Si", @"Opcion Si")
                         type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                             self.bolAnonymouse = true;
                             
                         }];
    
    [alert addButtonWithTitle:NSLocalizedString(@"No", @"Opcion No")
                         type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                             [self.btnAnonymous setBackgroundColor:[UIColor colorWithRed:166/255.0 green:168/255.0 blue:171/255.0 alpha:1]];
                         }];
    
    [alert show];
}

-(void)capturePhoto{
    SIAlertView *alert = [[SIAlertView alloc] initWithTitle:NSLocalizedString(@"Agregar foto", @"Titulo de alerta cuando se va agregar una foto")
                                                 andMessage:NSLocalizedString(@"Escoje una fuente", @"Mensaje de alerta cunado se agrega una foto")];
    
    [alert addButtonWithTitle:NSLocalizedString(@"Carrete", @"Opcion Carrete")
                         type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                             self.cameraPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary | UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                             [self presentViewController:self.cameraPicker animated:YES completion:Nil];
                         }];
    
    [alert addButtonWithTitle:NSLocalizedString(@"Cámara", @"Opcion Camara")
                         type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                             self.cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                             [self presentViewController:self.cameraPicker animated:YES completion:Nil];
                         }];
    
    if (self.ComplaintImage != nil)
    {
        [alert addButtonWithTitle:NSLocalizedString(@"Eliminar", @"Opcion Borrar")
                             type:SIAlertViewButtonTypeDestructive
                          handler:^(SIAlertView *alertView) {
                              self.ComplaintImage = nil;
                              [self.btnPhoto setBackgroundColor:[UIColor colorWithRed:166/255.0 green:168/255.0 blue:171/255.0 alpha:1]];
                          }];
    }
    
    [alert addButtonWithTitle:NSLocalizedString(@"Cancelar", @"Opcion Cancelar")
                         type:SIAlertViewButtonTypeCancel handler:^(SIAlertView *alertView) {
                             if (self.ComplaintImage == nil) {
                                 [self.btnPhoto setBackgroundColor:[UIColor colorWithRed:166/255.0 green:168/255.0 blue:171/255.0 alpha:1]];
                             }
                         }];
    
    [alert show];
}

-(void)captureVideo{
    SIAlertView *alert = [[SIAlertView alloc] initWithTitle:NSLocalizedString(@"Agregar video", @"Titulo de alerta cuando se va agregar una foto")
                                                 andMessage:NSLocalizedString(@"Escoje una fuente", @"Mensaje de alerta cunado se agrega una foto")];
    
    [alert addButtonWithTitle:NSLocalizedString(@"Carrete", @"Opcion Carrete")
                         type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                             self.videoPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                             self.videoPicker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
                             [self presentViewController:self.videoPicker animated:YES completion:Nil];
                         }];
    
    [alert addButtonWithTitle:NSLocalizedString(@"Grabar Video", @"Opcion Video")
                         type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                             self.videoPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                             [self presentViewController:self.videoPicker animated:YES completion:Nil];
                         }];
    
    if (self.ComplaintVideo != nil)
    {
        [alert addButtonWithTitle:NSLocalizedString(@"Eliminar", @"Opcion Borrar")
                             type:SIAlertViewButtonTypeDestructive
                          handler:^(SIAlertView *alertView) {
                              self.ComplaintVideo = nil;
                              [self.btnVideo setBackgroundColor:[UIColor colorWithRed:166/255.0 green:168/255.0 blue:171/255.0 alpha:1]];
                          }];
    }
    
    [alert addButtonWithTitle:NSLocalizedString(@"Cancelar", @"Opcion Cancelar")
                         type:SIAlertViewButtonTypeCancel handler:^(SIAlertView *alertView) {
                             [self.btnVideo setBackgroundColor:[UIColor colorWithRed:166/255.0 green:168/255.0 blue:171/255.0 alpha:1]];
                         }];
    
    [alert show];
}

#pragma mark - UIImagePickerControllerDelegate
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (self.bolVideo) {
        NSURL *videoURL = [info objectForKey: UIImagePickerControllerMediaURL];
        NSError *error = nil;
        self.ComplaintVideo = [NSData dataWithContentsOfFile:[videoURL path] options:0 error:&error];
        if(self.ComplaintVideo == nil && error!=nil) {
            NSLog(@"Failed !!");
        }
        else
            NSLog(@"Saved !!");
    }
    else
    {
        self.ComplaintImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (self.ComplaintVideo == nil)
        [self.btnVideo setBackgroundColor:[UIColor colorWithRed:166/255.0 green:168/255.0 blue:171/255.0 alpha:1]];
    
    if (self.ComplaintImage == nil)
        [self.btnPhoto setBackgroundColor:[UIColor colorWithRed:166/255.0 green:168/255.0 blue:171/255.0 alpha:1]];

    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)myMovieFinishedCallback:(NSNotification*)aNotification {
    [self dismissMoviePlayerViewControllerAnimated];
    MPMoviePlayerController* theMovie = [aNotification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    self.bolErrorLocation = true;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    self.bolErrorLocation = false;
}

#pragma mark - Map Location delegates
-(void)mapDropPinDidFinish:(CustomAnnotation *)annotation{
    self.ComplaintSiteLatitude = [NSString stringWithFormat:@"%f", annotation.coordinate.latitude];
    self.ComplaintSiteLongitude = [NSString stringWithFormat:@"%f", annotation.coordinate.longitude];
}

-(void)mapDroPinCancel{
    self.bolSite = false;
    [self.btnSite setBackgroundColor:[UIColor colorWithRed:166/255.0 green:168/255.0 blue:171/255.0 alpha:1]];
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



