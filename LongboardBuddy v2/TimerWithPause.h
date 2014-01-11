//
//  TimerWithPause.h
//  LongboardBuddy v2
//
//  Created by JonKalfayan on 1/9/14.
//  Copyright (c) 2014 Jonk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimerWithPause : NSObject 

- (void)initialize;
- (void)startPressed;
- (NSString *)getTime;

@end
