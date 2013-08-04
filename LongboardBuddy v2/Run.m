//
//  Run.m
//  LongboardBuddy v2
//
//  Created by JonKalfayan on 8/3/13.
//  Copyright (c) 2013 Jonk. All rights reserved.
//

#import "Run.h"

@implementation Run

@synthesize maxSpeed = _maxSpeed;
@synthesize averageSpeed = _averageSpeed;
@synthesize distance = _distance;
@synthesize maxAccel = _maxAccel;
@synthesize maxDecel = _maxDecel;
@synthesize maxGrade = _maxGrade;
@synthesize verticalDrop = _verticalDrop;
@synthesize time = _time;

- (void)addRunWithMaxSpeed:(NSString *)maxSpeed
              averageSpeed:(NSString *)averageSpeed
                  distance:(NSString *)distance
                  maxAccel:(NSString *)maxAccel
                  maxDecel:(NSString *)maxDecel
                  maxGrade:(NSString *)maxGrade
              verticalDrop:(NSString *)verticalDrop
                      time:(NSString *)time {
    
    self.maxSpeed = maxSpeed;
    self.averageSpeed = averageSpeed;
    self.distance = distance;
    self.maxAccel = maxAccel;
    self.maxDecel = maxDecel;
    self.maxGrade = maxGrade;
    self.verticalDrop = verticalDrop;
    self.time = time;
    
}


@end
