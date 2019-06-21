//
//  CLLocation+Utilities.m
//  Map
//
//  Created by Djuro Alfirevic on 6/19/19.
//  Copyright © 2019 Djuro Alfirevic. All rights reserved.
//

#import "CLLocation+Utilities.h"

@implementation CLLocation (Utilities)

#pragma mark - Public API
	
- (NSString *)formattedSpeed {
	if (self.speed < 0.0) {
		return @"0 km/h";
	}
	
	return [NSString stringWithFormat:@"%.2f km/h", self.speed * 3.6];
}
	
@end
