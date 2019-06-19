//
//  LocationService.h
//  Map
//
//  Created by Djuro Alfirevic on 6/19/19.
//  Copyright © 2019 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Constants.h"

@interface LocationService : NSObject
@property (strong, nonatomic) CLLocation *userLocation;
	
+ (instancetype)shared;
- (void)startMonitoringLocationUpdate;
- (void)stopMonitoringLocationUpdate;
@end
