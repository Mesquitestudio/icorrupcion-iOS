//
//  MapDropPinViewController.m
//  Integrapp
//
//  Created by Mesquitestudio on 10/6/14.
//  Copyright (c) 2014 com.mesquitestudio. All rights reserved.
//

#import "MapDropPinViewController.h"
#import "ComplaintViewController.h"

@interface MapDropPinViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *theMapView;
@property (strong) CustomAnnotation *theAnnocation;
@property (strong) NSString *pinTitle;
@property (strong) CLLocationManager *locManager;

@end

@implementation MapDropPinViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPinTitle:(NSString *)pinTitle
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.pinTitle = pinTitle;
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andCoordinates:(CLLocationCoordinate2D)coordinates andPinTitle:(NSString *)pinTitle
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CustomAnnotation *entityPositionAnnotation = [[CustomAnnotation alloc] initWithTitle:pinTitle subtitle:nil identifier:[NSNumber numberWithInt:1] andCoordinate:coordinates];
        self.fixedEntityAnnotation = entityPositionAnnotation;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Navigation Styl
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    self.title = NSLocalizedString(@"Arrastra y suelta", @"Titulo de vista al posicionar pin");
    if (self.fixedEntityAnnotation) {
        self.title = NSLocalizedString(@"Ubicación", @"Titulo de vista al ver un pin");
    }

    
    
    //Get current position coordinates
    self.locManager = [[CLLocationManager alloc]init];
    [self.locManager startUpdatingLocation];
    
    CLLocation *loc = [self.locManager location];
    CLLocationCoordinate2D coordinate = [loc coordinate];
    
    /// Place annotation in Map
    CustomAnnotation *currentPosAnnotation = [[CustomAnnotation alloc] initWithTitle:self.pinTitle subtitle:nil identifier:[NSNumber numberWithInt:1] andCoordinate:coordinate];
    self.theAnnocation = currentPosAnnotation;
    
    
    
    if(self.fixedEntityAnnotation){ //when displaying the position of an Entity.. READ ONLY
        [self.theMapView addAnnotation:self.fixedEntityAnnotation];
        [self zoomMapViewToCoordinates:self.fixedEntityAnnotation.coordinate];
    }
    else{ // WHEN CREATING A NEW ENTITY AND SPECIFING ITS LOCATION... default is current location
        [self.theMapView addAnnotation:currentPosAnnotation];
        [self zoomMapViewToCoordinates:currentPosAnnotation.coordinate];
    }
    
    
    //LISTO Button
    if (self.fixedEntityAnnotation == nil) {
        NSString *saveString = NSLocalizedString(@"Listo", @"Titulo de boton para marcar como terminado la geoposicion");
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:saveString
                                                                        style:UIBarButtonItemStyleDone  target:self action:@selector(saveClicked)];
        self.navigationItem.rightBarButtonItem = rightButton;
    }
    
    //CERRAR Button
    NSString *cancelString = NSLocalizedString(@"Cancelar", @"Titulo de boton para cancelar");
    if (self.fixedEntityAnnotation) {
        cancelString = NSLocalizedString(@"Cerrar", @"Cerrar");
    }
    
    //Navigation Items
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:cancelString
                                                                    style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(close)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    
    //Map
    [self.theMapView setDelegate:self];

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
-(void)close{
    [[self backViewController] mapDroPinCancel];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)zoomMapViewToCoordinates:(CLLocationCoordinate2D )coord{
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coord, 400, 400);
    MKCoordinateRegion adjustedRegion = [self.theMapView regionThatFits:viewRegion];
    [self.theMapView setRegion:adjustedRegion animated:YES];
    //self.theMapView.showsUserLocation = YES;
}

-(void)saveClicked{
    [[self backViewController] mapDropPinDidFinish:self.theAnnocation]; // Update My entities and pop back
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - MapView Delegates

- (MKAnnotationView *) mapView: (MKMapView *) mapView viewForAnnotation: (id<MKAnnotation>) annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;  //return nil to use default blue dot view
    
    MKPinAnnotationView *pin = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier: @"myPin"];
    if (pin == nil) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: @"myPin"];
    } else {
        pin.annotation = annotation;
    }
    
    [pin setCanShowCallout:YES];
    [pin setSelected:YES];
    [pin setAnimatesDrop:YES];
    [pin setDraggable:YES];
    
    return pin;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateEnding)
    {
        self.theAnnocation = annotationView.annotation;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ComplaintViewController *)backViewController {
    NSArray * stack = self.navigationController.viewControllers;
    
    for (int i=stack.count-1; i > 0; --i)
        if (stack[i] == self)
            return stack[i-1];
    
    return nil;
}

@end
