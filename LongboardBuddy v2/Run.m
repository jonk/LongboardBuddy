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
                      time:(NSString *)time
                      date:(NSString *)date
{
    
    self.maxSpeed = maxSpeed;
    self.averageSpeed = averageSpeed;
    self.time = time;
    self.date = date;
    
}

- (NSString *)getDate
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    return [dateFormatter stringFromDate:[NSDate date]];
    
}


@end
