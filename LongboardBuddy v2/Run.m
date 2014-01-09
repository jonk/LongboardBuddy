//
//  Run.m
//  LongboardBuddy v2
//
//  Created by JonKalfayan on 8/3/13.
//  Copyright (c) 2013 Jonk. All rights reserved.
//

#import "Run.h"

@interface Run()
@end

@implementation Run

- (void)addRunWithMaxSpeed:(NSString *)maxSpeed
              averageSpeed:(NSString *)averageSpeed
                      time:(NSString *)time {
    
    self.maxSpeed = maxSpeed;
    self.averageSpeed = averageSpeed;
    self.time = time;
    
}


@end
