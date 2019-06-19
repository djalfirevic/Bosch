//
//  MapViewController.m
//  Map
//
//  Created by Djuro Alfirevic on 6/19/19.
//  Copyright © 2019 Djuro Alfirevic. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreMotion/CoreMotion.h>
#import "Constants.h"
#import "MapViewModel.h"
#import "MotionService.h"
#import "CarAnnotationView.h"

@interface MapViewController() <MapViewModelDelegate, MotionServiceDelegate, MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (strong, nonatomic) MapViewModel *viewModel;
@property (strong, nonatomic) MotionService *motionService;
@property (strong, nonatomic) CarAnnotationView *selectedAnnotationView;
@end

@implementation MapViewController

#pragma mark - View lifecycle
	
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self configureViewModel];
	[self configureMap];
	[self prepareForDeviceMotionUpdates];
}
	
#pragma mark - Private API
	
- (void)configureViewModel {
	self.viewModel = [[MapViewModel alloc] initWithDelegate:self];
}
	
- (void)configureMap {
	self.mapView.showsUserLocation = YES;
	self.mapView.accessibilityIdentifier = MAP_VIEW_IDENTIIER;
	[self.mapView registerClass:CarAnnotationView.class forAnnotationViewWithReuseIdentifier:CAR_ANNOTATION_VIEW_IDENTIIER];
	[self.mapView addAnnotations:[self.viewModel carsArray]];
	
	CLLocation *europe = [[CLLocation alloc] initWithLatitude:54.52 longitude:15.25];
	[self zoomMapToLocation:europe];
}
	
- (void)prepareForDeviceMotionUpdates {
	self.motionService = [[MotionService alloc] initWithDelegate:self];
	[self.motionService startMotionUpdates];
}
	
- (void)zoomMapToLocation:(CLLocation *)location {
	MKCoordinateSpan span = MKCoordinateSpanMake(MAP_LOCATION_DEGREES, MAP_LOCATION_DEGREES);
	MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, span);
	
	[self.mapView setRegion:region animated:YES];
}
	
#pragma mark - MapViewModelDelegate
	
- (void)userUpdatedLocation:(CLLocation *)location andSpeed:(NSString *)speed {
	self.speedLabel.text = speed;
}

#pragma mark - MotionServiceDelegate
	
- (void)deviceUpdatedRoll:(double)roll andPitch:(double)pitch {
	if (self.selectedAnnotationView != nil) {
		[self.selectedAnnotationView updateViewForRoll:roll andPitch:pitch];
	}
}

#pragma mark - MKMapViewDelegate
	
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
	if (![annotation isKindOfClass:MKUserLocation.class]) {
		CarAnnotationView *annotationView = (CarAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:CAR_ANNOTATION_VIEW_IDENTIIER];
		if (annotationView == nil) {
			annotationView = [[CarAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:CAR_ANNOTATION_VIEW_IDENTIIER];
			annotationView.canShowCallout = YES;
			annotationView.draggable = NO;
		} else {
			annotationView.annotation = annotation;
		}
		
		[annotationView setImage:[UIImage imageNamed:@"car-icon.png"]];
		
		return annotationView;
	}
	
	MKPinAnnotationView *userAnnotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:USER_ANNOTATION_VIEW_IDENTIIER];
	userAnnotationView.annotation = annotation;
	
	return userAnnotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
	if (![view.annotation isKindOfClass:MKUserLocation.class]) {
		self.selectedAnnotationView = (CarAnnotationView *)view;
	}
}
	
@end
