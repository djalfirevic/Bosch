//
//  MapViewModel.m
//  Map
//
//  Created by Djuro Alfirevic on 6/19/19.
//  Copyright © 2019 Djuro Alfirevic. All rights reserved.
//

#import "MapViewModel.h"
#import "Constants.h"
#import "LocationService.h"
#import "CLLocation+Utilities.h"
#import "Car.h"

@implementation MapViewModel
	
#pragma mark - Designated Initializer
	
- (instancetype)initWithDelegate:(id<MapViewModelDelegate>)delegate {
	if (self = [super init]) {
		self.delegate = delegate;
		[self prepareForLocationUpdate];
	}
	
	return self;
}

#pragma mark - Public API
	
- (NSArray *)carsArray {
	Car *first = [[Car alloc] init];
	first.coordinate = CLLocationCoordinate2DMake(51.16, 10.46);
	first.title = @"Germany";
	first.rotationType = kRoll;
	
	Car *second = [[Car alloc] init];
	second.coordinate = CLLocationCoordinate2DMake(46.22, 2.21);
	second.title = @"France";
	second.rotationType = kPitch;
	
	return @[first, second];
}
	
#pragma mark - Private API
	
- (void)prepareForLocationUpdate {
	[[NSNotificationCenter defaultCenter] addObserverForName:USER_LOCATION_UPDATED_NOTIFICATION
													  object:nil
													   queue:[NSOperationQueue mainQueue]
												  usingBlock:^(NSNotification * _Nonnull note)
	 {
		 self.userLocation = [[LocationService shared] userLocation];
		 [self.delegate userUpdatedLocation:self.userLocation andSpeed:[self.userLocation formattedSpeed]];
	 }];
	
	[[LocationService shared] startMonitoringLocationUpdate];
}
	
@end
