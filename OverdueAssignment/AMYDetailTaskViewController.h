//
//  AMYDetailTaskViewController.h
//  OverdueAssignment
//
//  Created by Melissa Yung on 04/11/13.
//
//

#import <UIKit/UIKit.h>
@class AMYTask;

@interface AMYDetailTaskViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *taskDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDetailsLabel;
@property (strong, nonatomic) AMYTask *task;
@end
