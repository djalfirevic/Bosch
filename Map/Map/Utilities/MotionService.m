//
//  MotionService.m
//  Map
//
//  Created by Djuro Alfirevic on 6/19/19.
//  Copyright © 2019 Djuro Alfirevic. All rights reserved.
//

#import "MotionService.h"
#import "Constants.h"
#import <CoreMotion/CoreMotion.h>

@interface MotionService()
@property (strong, nonatomic) CMMotionManager *motionManager;
@end

@implementation MotionService
	
#pragma mark - Initializer
	
- (instancetype)initWithDelegate:(id<MotionServiceDelegate>)delegate {
	if (self = [super init]) {
		self.delegate = delegate;
		[self configureMotionManager];
	}
	
	return self;
}
	
#pragma mark - Public API
	
- (void)startMotionUpdates {
	[self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]
											withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error)
	{
		if (error) {
			NSLog(@"CMMotionManager error: %@", error.localizedDescription);
		} else {
			[self handleDeviceMotionUpdate:motion];
		}
	}];
}
	
- (void)stopMotionUpdates {
	[self.motionManager stopDeviceMotionUpdates];
}
	
#pragma mark - Private API
	
- (void)configureMotionManager {
	self.motionManager = [[CMMotionManager alloc] init];
	self.motionManager.deviceMotionUpdateInterval = DEVICE_MOTION_UPDATE_INTERVAL;
	
	NSString *availability = [self.motionManager isDeviceMotionAvailable] ? @"✅" : @"🛑";
	NSLog(@"Device Motion availability: %@", availability);
}

- (void)handleDeviceMotionUpdate:(CMDeviceMotion *)deviceMotion {
	CMAttitude *attitude = deviceMotion.attitude;
	
	[self.delegate deviceUpdatedRoll:attitude.roll andPitch:attitude.roll];
}
	
@end
