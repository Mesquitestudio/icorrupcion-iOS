//
//  ComplaintViewController.m
//  iCorrupción
//
//  Created by Mesquitestudio on 10/6/14.
//  Copyright (c) 2014 com.mesquitestudio. All rights reserved.
//

#import "ComplaintViewController.h"
#import "SIAlertView.h"

@interface ComplaintViewController ()
@property (strong, nonatomic) IBOutlet UIButton *btnAnonymous;
@property (strong, nonatomic) IBOutlet UIButton *btnAttachment;
@property (strong, nonatomic) IBOutlet UIButton *btnLocation;
@property (strong, nonatomic) IBOutlet UIButton *btnVideo;
@property (strong, nonatomic) IBOutlet UIButton *btnPhoto;
@property (strong, nonatomic) IBOutlet UIButton *btnSite;

@property (strong) CLLocationManager *locationManager;
@property (strong) UIImageView *imageSelect;
@property (strong) UIImagePickerController *cameraPicker;
@property (strong, nonatomic) IBOutlet UIView *imageView;
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong) NSData *videoData;
@property (strong) UIImagePickerController *videoPicker;

@property BOOL bolCamera;

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Actions

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnAnonymous:(id)sender {
    [self.btnAnonymous setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:184/255.0 blue:86/255.0 alpha:1]];
}

- (IBAction)btnAttachment:(id)sender {
    [self.btnAttachment setBackgroundColor:[UIColor colorWithRed:239/255.0 green:157/255.0 blue:82/255.0 alpha:1]];
}

- (IBAction)btnLocation:(id)sender {
    CLLocation *loc = [self.locationManager location];
    CLLocationCoordinate2D coordinate = [loc coordinate];
    NSLog(@"%f", coordinate.longitude);
    NSLog(@"%f", coordinate.latitude);
    [self.btnLocation setBackgroundColor:[UIColor colorWithRed:233/255.0 green:128/255.0 blue:79/255.0 alpha:1]];
}

- (IBAction)btnVideo:(id)sender {
    //pendiente
//    self.bolCamera = TRUE;
//    [self captureVideo];
    [self.btnVideo setBackgroundColor:[UIColor colorWithRed:227/255.0 green:100/255.0 blue:75/255.0 alpha:1]];
}

- (IBAction)btnPhoto:(id)sender {
//    self.bolCamera = FALSE;
    self.imageSelect = self.image;
    [self capturePhoto];
    [self.btnPhoto setBackgroundColor:[UIColor colorWithRed:240/255.0 green:89/255.0 blue:72/255.0 alpha:1]];
}

- (IBAction)btnSite:(id)sender {
    [self.btnSite setBackgroundColor:[UIColor colorWithRed:214/255.0 green:76/255.0 blue:55/255.0 alpha:1]];
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
    
    if (self.imageSelect.image != nil)
    {
        [alert addButtonWithTitle:NSLocalizedString(@"Eliminar", @"Opcion Borrar")
                             type:SIAlertViewButtonTypeDestructive
                          handler:^(SIAlertView *alertView) {
                              [self.imageSelect setImage:nil];
                              [self.btnPhoto setBackgroundColor:[UIColor colorWithRed:166/255.0 green:168/255.0 blue:171/255.0 alpha:1]];
                          }];
    }
    
    [alert addButtonWithTitle:NSLocalizedString(@"Cancelar", @"Opcion Cancelar")
                         type:SIAlertViewButtonTypeCancel handler:^(SIAlertView *alertView) {
                             if (self.imageSelect.image == nil) {
                                 [self.btnPhoto setBackgroundColor:[UIColor colorWithRed:166/255.0 green:168/255.0 blue:171/255.0 alpha:1]];
                             }
                         }];
    
    [alert show];
}

//-(void)captureVideo{
//    SIAlertView *alert = [[SIAlertView alloc] initWithTitle:NSLocalizedString(@"Agregar video", @"Titulo de alerta cuando se va agregar una foto")
//                                                 andMessage:NSLocalizedString(@"Escoje una fuente", @"Mensaje de alerta cunado se agrega una foto")];
//    
//    [alert addButtonWithTitle:NSLocalizedString(@"Carrete", @"Opcion Carrete")
//                         type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
//                             self.videoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//                             self.videoPicker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
//                             [self presentViewController:self.videoPicker animated:YES completion:Nil];
//                         }];
//    
//    [alert addButtonWithTitle:NSLocalizedString(@"Cámara", @"Opcion Camara")
//                         type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
//                             self.videoPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//                             [self presentViewController:self.videoPicker animated:YES completion:Nil];
//                         }];
//    
//    if (self.imageSelect.image != nil)
//    {
//        [alert addButtonWithTitle:NSLocalizedString(@"Eliminar", @"Opcion Borrar")
//                             type:SIAlertViewButtonTypeDestructive
//                          handler:^(SIAlertView *alertView) {
//                              [self.imageSelect setImage:nil];
//                          }];
//    }
//    
//    [alert addButtonWithTitle:NSLocalizedString(@"Cancelar", @"Opcion Cancelar")
//                         type:SIAlertViewButtonTypeCancel handler:^(SIAlertView *alertView) {
//                         }];
//    
//    [alert show];
//}


#pragma mark - UIImagePickerControllerDelegate
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//    if (!self.bolCamera) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self.imageSelect setImage:image];
//    }
//    else
//    {
//        NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
//        
//        // Handle a movie capture
//        if (CFStringCompare ((__bridge_retained CFStringRef)mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
//            // 3 - Play the video
//            
//            MPMoviePlayerViewController *theMovie = [[MPMoviePlayerViewController alloc]
//                                                     initWithContentURL:[info objectForKey:UIImagePickerControllerMediaURL]];
//            [self presentMoviePlayerViewControllerAnimated:theMovie];
//            
//            // 4 - Register for the playback finished notification
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myMovieFinishedCallback:)
//                                                         name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
//        }
//    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
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
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        NSLog(@"%f", currentLocation.coordinate.longitude);
        NSLog(@"%f", currentLocation.coordinate.latitude);
    }
}

@end
