//
//  RunDetailViewController.m
//  LongboardBuddy v2
//
//  Created by JonKalfayan on 1/12/14.
//  Copyright (c) 2014 Jonk. All rights reserved.
//

#import "RunDetailViewController.h"

@interface RunDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *maxSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *avgSpeedLabel;

@end

@implementation RunDetailViewController

- (void)viewDidLoad
{
    self.maxSpeedLabel.text = self.run.maxSpeed;
    self.avgSpeedLabel.text = self.run.averageSpeed;
}

@end
