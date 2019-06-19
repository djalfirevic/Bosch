//
//  CarAnnotationView.h
//  Map
//
//  Created by Djuro Alfirevic on 6/19/19.
//  Copyright © 2019 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarAnnotationView : MKAnnotationView
- (void)setImage:(UIImage * _Nullable)image;
- (void)updateViewForRoll:(double)roll andPitch:(double)pitch;
@end

NS_ASSUME_NONNULL_END
