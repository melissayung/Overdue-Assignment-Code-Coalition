//
//  AMYAddTaskViewController.m
//  OverdueAssignment
//
//  Created by Melissa Yung on 04/11/13.
//
//

#import "AMYAddTaskViewController.h"
#import "AMYPersistentTaskManager.h"
#import "AMYTask.h"

NSString * const TASKLIST = @"AddTaskTaskList";
//NSString * const TASKNAME = @"AddTaskTaskName";
//NSString * const TASKDETAILS = @"AddTaskTaskDetails";
//NSString * const TASKDATE = @"AddTaskTaskDate";

@interface AMYAddTaskViewController ()
@end

@implementation AMYAddTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.taskNameTextField.delegate = self;
    self.taskDetailsTextView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TEXTFIELD AND TEXTVIEW DELEGATE METHODS
-(BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        [self.taskDetailsTextView resignFirstResponder];
        return NO;
    }
    else {
        return YES;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.taskNameTextField resignFirstResponder];
    return NO;
}

#pragma mark - UI LISTENERS METHODS
- (IBAction)addTaskBtnPressed:(UIButton *)sender {

    // validate input
    if (![self minInputLenghtValidated])
        return;
    
    NSDate *taskDate = self.datePicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *taskDateAsString = [formatter stringFromDate:taskDate];
    
    int nextTaskId = [[AMYPersistentTaskManager sharedInstance] nextTaskId];
    
    AMYTask *newTask = [[AMYTask alloc] initWithIdentifier:[NSNumber numberWithInt:nextTaskId] name:self.taskNameTextField.text details:self.taskDetailsTextView.text timestamp:taskDateAsString complete:NO];
    
    // store persistently
    [[AMYPersistentTaskManager sharedInstance] addTask:newTask];
    
    // call delegate
    [self.delegate taskAddedInAddTaskView:newTask];
}

- (IBAction)cancelBtnPressed:(UIButton *)sender {
    [self.delegate cancelBtnPressedInAddTaskView];
}

#pragma mark - Helper Methods

-(BOOL) minInputLenghtValidated
{
    if ((self.taskNameTextField.text.length >= 1) && self.taskDetailsTextView.text.length >=1) {
        return YES;
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Input" message:@"Task name and details require a min length before you can add a task!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return NO;
    }
}


@end
