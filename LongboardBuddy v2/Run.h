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
@property (nonatomic, strong) NSString *time;

- (void)addRunWithMaxSpeed:(NSString *)maxSpeed
              averageSpeed:(NSString *)averageSpeed
                  distance:(NSString *)distance
                      time:(NSString *)time;


@end
