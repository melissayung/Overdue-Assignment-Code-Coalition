//
//  AMYPersistentTaskManager.h
//  OverdueAssignment
//
//  Created by AMY on 04/11/13.
//
//

#import <Foundation/Foundation.h>
@class AMYTask;

@interface AMYPersistentTaskManager : NSObject

+(AMYPersistentTaskManager *) sharedInstance;

-(NSDictionary *) tasksListAsDictionary;
-(NSArray *) tasksListAsArray;
-(void) addTask:(AMYTask *)task;
-(void) editTask:(AMYTask *)task;
-(void) deleteTask:(int)identifier;
-(AMYTask *) retrieveTask:(int) identifier;
-(int) nextTaskId;
-(int) numberOfTasks;

@end
