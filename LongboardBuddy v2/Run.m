//
//  Run.m
//  LongboardBuddy v2
//
//  Created by JonKalfayan on 8/3/13.
//  Copyright (c) 2013 Jonk. All rights reserved.
//

#import "Run.h"

@implementation Run

- (void)addRunWithMaxSpeed:(NSString *)maxSpeed
              averageSpeed:(NSString *)averageSpeed
                  distance:(NSString *)distance
                      time:(NSString *)time {
    
    self.maxSpeed = maxSpeed;
    self.averageSpeed = averageSpeed;
    self.distance = distance;
    self.time = time;
    
}


@end
