//
//  AMYAddTaskViewController.h
//  OverdueAssignment
//
//  Created by Melissa Yung on 04/11/13.
//
//

#import <UIKit/UIKit.h>
@class AMYTask;

extern NSString * const TASKLIST;

@protocol AMYAddTaskViewControllerDelegate <NSObject>
@required
- (void) taskAddedInAddTaskView:(AMYTask *)task;
- (void) cancelBtnPressedInAddTaskView;
@end

@interface AMYAddTaskViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate>
- (IBAction)addTaskBtnPressed:(UIButton *)sender;
- (IBAction)cancelBtnPressed:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskDetailsTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) id<AMYAddTaskViewControllerDelegate> delegate;
@end
