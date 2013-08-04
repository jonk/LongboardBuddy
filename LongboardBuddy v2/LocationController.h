//
//  LocationController.h
//  LongboardBuddy
//
//  Created by JonKalfayan on 12/25/12.
//  Copyright (c) 2012 JonKalfayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol CoreLocationControllerDelegate <NSObject>
@required
- (void)locationUpdate:(CLLocation *)location;
- (void)locationError:(NSError *)error;

@end

@interface LocationController : NSObject <CLLocationManagerDelegate> {
    CLLocation *locationManager;
    id delegate;
}

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign) id delegate;

@end
