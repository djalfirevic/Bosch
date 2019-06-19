//
//  LocationService.m
//  Map
//
//  Created by Djuro Alfirevic on 6/19/19.
//  Copyright © 2019 Djuro Alfirevic. All rights reserved.
//

#import "LocationService.h"

@interface LocationService() <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation LocationService

#pragma mark - Initializer
	
- (instancetype)init {
	if (self = [super init]) {
		[self configureLocationManager];
	}
	
	return self;
}
	
+ (LocationService *)shared {
	static LocationService *sharedService;
	
	@synchronized (self) {
		if (sharedService == nil) {
			sharedService = [[LocationService alloc] init];
		}
	}
	
	return sharedService;
}
	
#pragma mark - Public API
	
- (void)startMonitoringLocationUpdate {
	NSLog(@"Location Manager status: ✅");
	[self.locationManager startUpdatingLocation];
}
	
- (void)stopMonitoringLocationUpdate {
	NSLog(@"Location Manager status: 🛑");
	[self.locationManager stopUpdatingLocation];
}
	
#pragma mark - Private API
	
- (void)configureLocationManager {
	CLLocationManager *manager = [[CLLocationManager alloc] init];
	manager.desiredAccuracy = kCLLocationAccuracyBest;
	manager.delegate = self;
	[manager requestWhenInUseAuthorization];
	
	self.locationManager = manager;
}
	
#pragma mark - CLLocationManagerDelegate
	
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
	if (locations.count > 0) {
		CLLocation *location = locations.firstObject;
		self.userLocation = location;
		
		[[NSNotificationCenter defaultCenter] postNotificationName:USER_LOCATION_UPDATED_NOTIFICATION object:nil];
	}
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSLog(@"Location Service error: %@", error.localizedDescription);
}
	
@end
