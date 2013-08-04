//
//  Run.h
//  LongboardBuddy v2
//
//  Created by JonKalfayan on 8/3/13.
//  Copyright (c) 2013 Jonk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Run : NSObject

@property (nonatomic, strong) NSString *maxSpeed;
@property (nonatomic, strong) NSString *averageSpeed;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *maxAccel;
@property (nonatomic, strong) NSString *maxDecel;
@property (nonatomic, strong) NSString *maxGrade;
@property (nonatomic, strong) NSString *verticalDrop;
@property (nonatomic, strong) NSString *time;

- (void)addRunWithMaxSpeed:(NSString *)maxSpeed
              averageSpeed:(NSString *)averageSpeed
                  distance:(NSString *)distance
                  maxAccel:(NSString *)maxAccel
                  maxDecel:(NSString *)maxDecel
                  maxGrade:(NSString *)maxGrade
              verticalDrop:(NSString *)verticalDrop
                      time:(NSString *)time;


@end
