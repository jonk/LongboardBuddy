//
//  LocationController.m
//  LongboardBuddy
//
//  Created by JonKalfayan on 12/25/12.
//  Copyright (c) 2012 JonKalfayan. All rights reserved.
//

#import "LocationController.h"

@implementation LocationController
@synthesize locationManager = _locationManager;
@synthesize delegate = _delegate;

- (id)init {
    self = [super init];
    
    if (self != nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    if ([self.delegate conformsToProtocol:@protocol(CoreLocationControllerDelegate)]) {
        [self.delegate locationUpdate:locations.lastObject];
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    if ([self.delegate conformsToProtocol:@protocol(CoreLocationControllerDelegate)]) {
        [self.delegate locationError:error];
    }
}


@end
