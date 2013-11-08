//
//  AMYViewController.m
//  OverdueAssignment
//
//  Created by Melissa Yung on 04/11/13.
//
//

#import "AMYViewController.h"
#import "AMYPersistentTaskManager.h"
#import "AMYTaskTableViewCell.h"
#import "AMYDetailTaskViewController.h"
#import "AMYTask.h"

@interface AMYViewController () {
    NSMutableArray *tasksList;
}

@end

@implementation AMYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    tasksList = [[[AMYPersistentTaskManager sharedInstance] tasksListAsArray] mutableCopy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HELPER METHODS
- (void) addToTasksList:(AMYTask *)task {
    [tasksList addObject:task];
}

-(BOOL) isDate:(NSDate *)today greaterThanDate:(NSDate *)dueDate {
    // today is later than due date
    if ([today compare:dueDate] == NSOrderedDescending) {
        return YES;
    }
    
    return NO;
}

#pragma mark - UI LISTENER METHODS
- (IBAction)addTaskBtnPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"mainViewToAddTaskViewModalSegue" sender:sender];
}

- (IBAction)reorderTasksBtnPressed:(UIBarButtonItem *)sender {
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[AMYAddTaskViewController class]]) {
            // set the delegate
        AMYAddTaskViewController *addTaskViewController = segue.destinationViewController;
        addTaskViewController.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"mainViewToDetailTaskViewPushSegue"]) {
        // we have clicked on the table cell and want to display the details of the task
        AMYDetailTaskViewController *detailTaskViewController = segue.destinationViewController;
        NSIndexPath *path = [self.tasksTable indexPathForCell:sender];
        AMYTask *selectedTask = tasksList[path.row];
        detailTaskViewController.task = selectedTask;
    }
}

#pragma mark - TABLEVIEW DATASOURCE PROTOCOL METHODS
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"taskCell";
    AMYTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    AMYTask *task = tasksList[indexPath.row];
    // Configure the cell...
    cell.taskNameLabel.text = task.name;
    cell.taskTimestampLabel.text = task.timestamp;
    
    //TODO shoud prob move this somewhere else
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:task.timestamp];

    if (task.complete) {
        cell.backgroundColor = [UIColor greenColor];
    }
    else {
        if ([self isDate:[NSDate date] greaterThanDate:dateFromString]) {
        // still have time to complete task, not overdue colour
        cell.backgroundColor = [UIColor redColor];
        }
        else {
            cell.backgroundColor = [UIColor yellowColor];
        }
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tasksList count];
}

#pragma mark -TABLEVIEW DELEGATE PROTOCOL METHODS
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark - ADDTASKVIEW PROTOCOL METHODS
- (void)cancelBtnPressedInAddTaskView {
    // when the cancel btn is pressed on the add task we just segued to, we need to dismiss that view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)taskAddedInAddTaskView:(AMYTask *)task {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // add the task to our table and reload
    [self addToTasksList:task];
    [self.tasksTable reloadData];
}

@end
