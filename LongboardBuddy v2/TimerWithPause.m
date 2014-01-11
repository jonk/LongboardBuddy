//
//  TimerWithPause.m
//  LongboardBuddy v2
//
//  Created by JonKalfayan on 1/9/14.
//  Copyright (c) 2014 Jonk. All rights reserved.
//

#import "TimerWithPause.h"

@interface TimerWithPause()
@property (nonatomic) NSTimeInterval startTime;
@property (nonatomic) NSTimeInterval stoppedTime;
@property (nonatomic) BOOL running;
@property (nonatomic, strong) NSString *timerString;
@end

@implementation TimerWithPause

- (void)initialize
{
    self.running = NO;
    self.startTime = [NSDate timeIntervalSinceReferenceDate];
}

/** Performs some simple math to update the timer when it is running using
 *  NS Date. */
- (void)startPressed
{
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    
    if (!self.running) {
        self.running = YES;
        NSTimeInterval elapsed = currentTime - self.stoppedTime;
        self.startTime = elapsed;
    } else {
        currentTime = [NSDate timeIntervalSinceReferenceDate];
        self.running = NO;
    }
}

- (NSString *)getTime
{
    if (!self.running) return self.timerString;
    
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = currentTime - self.startTime;
    self.stoppedTime = elapsed;
    
    int hours = (int) (elapsed / 3600.0);
    elapsed -= hours * 3600.0;
    int mins = (int) (elapsed / 60.0);
    elapsed -= mins * 60;
    int secs = (int) (elapsed);
    elapsed -= secs;
    int fraction = elapsed * 10.0;
    
    self.timerString = [NSString stringWithFormat:@"%u:%02u:%02u.%u", hours, mins, secs, fraction];
    
    return self.timerString;
}
@end
