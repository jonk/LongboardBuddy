//
//  ListOfRunsDataSourceProtocol.h
//  LongboardBuddy v2
//
//  Created by JonKalfayan on 1/1/14.
//  Copyright (c) 2014 Jonk. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ListOfRunsDataSourceProtocol <NSObject>

- (int)numberofRuns;
@property (nonatomic, strong) NSMutableArray *listOfRuns;
@property (nonatomic, strong) id delegate;

@end
