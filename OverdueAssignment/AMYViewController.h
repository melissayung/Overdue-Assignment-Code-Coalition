//
//  AMYViewController.h
//  OverdueAssignment
//
//  Created by Melissa Yung on 04/11/13.
//
//

@import UIKit;

#import "AMYAddTaskViewController.h"

@interface AMYViewController : UIViewController<AMYAddTaskViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tasksTable;
- (IBAction)reorderTasksBtnPressed:(UIBarButtonItem *)sender;

@end
