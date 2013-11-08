//
//  AMYDetailTaskViewController.m
//  OverdueAssignment
//
//  Created by Melissa Yung on 04/11/13.
//
//

#import "AMYDetailTaskViewController.h"
#import "AMYTask.h"

@interface AMYDetailTaskViewController ()

@end

@implementation AMYDetailTaskViewController

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
    self.taskDateLabel.text = self.task.timestamp;
    self.taskNameLabel.text = self.task.name;
    self.taskDetailsLabel.text = self.task.details;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
