//
//  MotionService.h
//  Map
//
//  Created by Djuro Alfirevic on 6/19/19.
//  Copyright © 2019 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MotionServiceDelegate <NSObject>
- (void)deviceUpdatedRoll:(double)roll andPitch:(double)pitch;
@end

@interface MotionService : NSObject
@property (weak, nonatomic) id<MotionServiceDelegate> delegate;
	
- (instancetype)initWithDelegate:(id<MotionServiceDelegate>)delegate;
- (void)startMotionUpdates;
- (void)stopMotionUpdates;
@end
