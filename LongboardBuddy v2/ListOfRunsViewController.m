//
//  ListOfRunsViewController.m
//  LongboardBuddy v2
//
//  Created by JonKalfayan on 8/3/13.
//  Copyright (c) 2013 Jonk. All rights reserved.
//

#import "ListOfRunsViewController.h"
#import "Run.h"
#import "RunLoggerViewController.h"
#import "RunDetailViewController.h"

@interface ListOfRunsViewController ()

@property (nonatomic, strong) RunLoggerViewController *loggerVC;

@end

@implementation ListOfRunsViewController

- (RunLoggerViewController *)loggerVC
{
    if (!_loggerVC) {
        if ([[self.tabBarController.viewControllers objectAtIndex:0] isKindOfClass:[RunLoggerViewController class]]) {
            RunLoggerViewController *runLoggerVC = (RunLoggerViewController *)[self.tabBarController.viewControllers objectAtIndex:0];
            _loggerVC = runLoggerVC;
        }
    }
    return _loggerVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[self.tabBarController.viewControllers objectAtIndex:0] isKindOfClass:[RunLoggerViewController class]]) {
        self.loggerVC = (RunLoggerViewController *)[self.tabBarController.viewControllers objectAtIndex:0];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.loggerVC.numberOfRuns;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RunCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Run *run = [self.loggerVC getRunAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Date: %@", run.date];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", run.time];
    
    return cell;
}

#pragma mark - Table view delegate

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[RunDetailViewController class]]) {
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        RunDetailViewController *rdvc = (RunDetailViewController *)segue.destinationViewController;
        rdvc.run = [self.loggerVC getRunAtIndex:path.row];
    }
}


@end
