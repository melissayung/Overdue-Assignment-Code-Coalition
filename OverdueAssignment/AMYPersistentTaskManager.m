//
//  AMYPersistentTaskManager.m
//  OverdueAssignment
//
//  Created by AMY on 04/11/13.
//
//

#import "AMYPersistentTaskManager.h"
#import "AMYTask.h"

@implementation AMYPersistentTaskManager

+(AMYPersistentTaskManager *)sharedInstance {
    static AMYPersistentTaskManager * _taskManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _taskManager = [[self alloc] init];
    });
    return _taskManager;
}

// get the 'tasks list' as a dictionary of AMYTask objects
- (NSDictionary *) tasksListAsDictionary {
    
    // get the dictionary of dictionaries (format required to store in NSUserDefaults)
    NSMutableDictionary *dictionaryList = [[NSUserDefaults standardUserDefaults] objectForKey:TASKSLIST];
    if (dictionaryList) {
        NSMutableDictionary *tasksList = [[NSMutableDictionary alloc] init];
        // let's convert all the contained AMYTask (currently in dictionary format) into AMYTask objects
        for (id dicKey in dictionaryList) {
            AMYTask *task = [[AMYTask alloc] initWithDictionary:[dictionaryList objectForKey:dicKey]];
            [tasksList  setValue:task forKey:[task.identifier stringValue]];
        }
        return tasksList;
    }
    return nil;
}

// get the 'tasks list' as an array of AMYTask objects
// makes it easier to work in some cases eg in the table view
-(NSArray *) tasksListAsArray {
    // get the dictionary of AMYTask objects
    NSDictionary *tasksListDictionary = [self tasksListAsDictionary];
    if (tasksListDictionary) {
        NSArray *tasksListArray = [tasksListDictionary allValues];
        return tasksListArray;
    }
    else {
        return [[NSArray alloc] init];
    }
}

-(void) addTask:(AMYTask *)task {
    
    NSMutableDictionary *taskDictionary = [task taskAsAPropertyList];
    NSMutableDictionary *tasksList = [[[NSUserDefaults standardUserDefaults] objectForKey:TASKSLIST] mutableCopy];
    if (!tasksList) {
        // let's create one
        tasksList = [[NSMutableDictionary alloc] init];
    }
    
    // let's add the task entry
    [tasksList setObject:taskDictionary forKey:[task.identifier stringValue]];
    
    // let's save the 'tasks list dictionary' with the new entry
    [[NSUserDefaults standardUserDefaults] setObject:tasksList forKey:TASKSLIST];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void) editTask:(AMYTask *)task {
    
}

-(void) deleteTask:(int)identifier {
    
}

-(AMYTask *) retrieveTask:(int) identifier {
    
    // get the 'tasks list' dictionary
    NSDictionary *tasksList = [self tasksListAsDictionary];

    AMYTask *task = [tasksList objectForKey:[NSString stringWithFormat:@"%d", identifier]];
    return task;
}

// work out the last current task id and return one greater
-(int) nextTaskId {
    
    // get the 'tasks list' dictionary
    NSArray *tasksListArray = [self tasksListAsArray];
    
    if ([tasksListArray count] > 0) {
        AMYTask *currentLastTask = tasksListArray[tasksListArray.count -1];
        int currentLastTaskId = [currentLastTask.identifier intValue];
        NSLog(@"current last task id: %i", currentLastTaskId);
        return currentLastTaskId+1;
    }
    else {
        return 1;
    }
}

// returns the number of tasks so that the table delegate can know how many rows are needed
-(int) numberOfTasks {
    return [[self tasksListAsDictionary] count];
}


@end
