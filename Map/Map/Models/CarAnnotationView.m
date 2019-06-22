//
//  CarAnnotationView.m
//  Map
//
//  Created by Djuro Alfirevic on 6/19/19.
//  Copyright © 2019 Djuro Alfirevic. All rights reserved.
//

#import "CarAnnotationView.h"
#import "Car.h"
#import <CoreGraphics/CoreGraphics.h>

#define IMAGE_COORDINATE 30.0
#define IMAGE_SIZE 60.0

@interface CarAnnotationView()
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation CarAnnotationView

#pragma mark - Initializer
	
- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
		CGRect containerViewRect = CGRectMake(-IMAGE_COORDINATE, -IMAGE_COORDINATE, IMAGE_SIZE, IMAGE_SIZE);
		
		UIView* containerView = [[UIView alloc] initWithFrame:containerViewRect];
		[self addSubview:containerView];
		
		UIImageView* imageView = [[UIImageView alloc] initWithFrame:containerViewRect];
		imageView.contentMode = UIViewContentModeScaleAspectFit;
		[self addSubview:imageView];
		
		self.imageView = imageView;
	}
	
	return self;
}
	
#pragma mark - Public API
	
- (void)setImage:(UIImage *)image {
	self.imageView.image = image;
}

- (void)updateViewForRoll:(double)roll andPitch:(double)pitch {
	if ([self.annotation isKindOfClass:Car.class]) {
		Car *car = (Car *)self.annotation;
		
		if (car.rotationType == kRoll) {
			self.imageView.layer.transform = CATransform3DMakeRotation([self degrees:roll], 1.0, 0.0, 0.0);
		} else {
			self.imageView.layer.transform = CATransform3DMakeRotation([self degrees:pitch], 0.0, 1.0, 0.0);
		}
	}
}

#pragma mark - Private API

- (double)degrees:(double)radians {
	return 180 / M_PI * radians;
}
	
@end
