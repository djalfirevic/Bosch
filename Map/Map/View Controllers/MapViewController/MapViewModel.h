//
//  MapViewModel.h
//  Map
//
//  Created by Djuro Alfirevic on 6/19/19.
//  Copyright © 2019 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol MapViewModelDelegate <NSObject>
- (void)userUpdatedLocation:(CLLocation * _Nullable)location andSpeed:(NSString * _Nullable)speed;
@end

NS_ASSUME_NONNULL_BEGIN

@interface MapViewModel : NSObject
@property (strong, nonatomic) CLLocation *userLocation;
@property (weak, nonatomic) id<MapViewModelDelegate> delegate;
	
- (instancetype)initWithDelegate:(id<MapViewModelDelegate>)delegate;
- (NSArray *)carsArray;
@end

NS_ASSUME_NONNULL_END
