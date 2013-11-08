//
//  AMYEditTaskViewController.h
//  OverdueAssignment
//
//  Created by Melissa Yung on 04/11/13.
//
//

#import <UIKit/UIKit.h>

@interface AMYEditTaskViewController : UIViewController
- (IBAction)saveTaskBtnPressed:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskDetailsTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@end
