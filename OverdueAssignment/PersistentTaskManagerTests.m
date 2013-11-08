//
//  OverdueAssignment - PersistentTaskManagerTests.m
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//
//  Created by: Melissa Yung
//

    // Class under test
#import "AMYPersistentTaskManager.h"
#import "AMYTask.h"

    // Collaborators

    // Test support
#import <XCTest/XCTest.h>

// Uncomment the next two lines to use OCHamcrest for test assertions:
#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>

// Uncomment the next two lines to use OCMockito for mock objects:
#define MOCKITO_SHORTHAND
#import <OCMockitoIOS/OCMockitoIOS.h>


@interface PersistentTaskManagerTests : XCTestCase
@end

@implementation PersistentTaskManagerTests
{
    // test fixture ivars go here
    AMYTask *expectedTaskA;
    AMYTask *expectedTaskB;
    int testTaskIdentifierA;
    int testTaskIdentifierB;
}

-(void) setUp
{
    testTaskIdentifierA = 2;
    NSString *testTaskNameA = @"TestTaskNameA";
    NSString *testTaskDetailsA = @"TestTaskDetailsA";
    NSString *testTaskTimestampA = @"2013-11-05";
    
    testTaskIdentifierB = 3;
    NSString *testTaskNameB = @"TestTaskNameB";
    NSString *testTaskDetailsB = @"TestTaskDetailsB";
    NSString *testTaskTimestampB = @"2013-11-05";
    
    
    expectedTaskA = [[AMYTask alloc] initWithIdentifier:[NSNumber numberWithInt:testTaskIdentifierA]
                                                            name:testTaskNameA
                                                         details:testTaskDetailsA
                                                       timestamp:testTaskTimestampA
                                                        complete:YES];
    
    expectedTaskB = [[AMYTask alloc] initWithIdentifier:[NSNumber numberWithInt:testTaskIdentifierB]
                                                            name:testTaskNameB
                                                         details:testTaskDetailsB
                                                       timestamp:testTaskTimestampB
                                                        complete:YES];
}

-(void) tearDown
{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

-(void) testTasksListAsDictionary
{
    AMYPersistentTaskManager *sut = [[AMYPersistentTaskManager alloc] init];
    
    NSDictionary *expectedDictionary = @{[NSString stringWithFormat:@"%d",testTaskIdentifierA]:expectedTaskA};
    
    [sut addTask:expectedTaskA];
    
    NSDictionary *resultDictionary = [sut tasksListAsDictionary];
    
    assertThat(resultDictionary, equalTo(expectedDictionary));
}

-(void) testTasksListAsArray
{
    
}

-(void) testAddRetrieveTask
{
    AMYPersistentTaskManager *sut = [[AMYPersistentTaskManager alloc] init];
    
    [sut addTask:expectedTaskA];
    
    AMYTask *result = [sut retrieveTask:testTaskIdentifierA];
    
    assertThat(result , equalTo(expectedTaskA));
}

-(void) testAddRetrieveMultipleTasks
{
    AMYPersistentTaskManager *sut = [[AMYPersistentTaskManager alloc] init];
    
    [sut addTask:expectedTaskA];
    [sut addTask:expectedTaskB];
    
    AMYTask *resultB = [sut retrieveTask:testTaskIdentifierB];
    assertThat(resultB , equalTo(expectedTaskB));
    
    AMYTask *resultA = [sut retrieveTask:testTaskIdentifierA];
    assertThat(resultA , equalTo(expectedTaskA));
}


// we add two tasks and verify if we get the count of 2 back
-(void) testNumberOfTasks
{
    AMYPersistentTaskManager *sut = [[AMYPersistentTaskManager alloc] init];
    
    [sut addTask:expectedTaskA];
    [sut addTask:expectedTaskB];
    
    assert([sut numberOfTasks] == 2);
}


-(void) testTaskId
{
    AMYPersistentTaskManager *sut = [[AMYPersistentTaskManager alloc] init];
    
    [sut addTask:expectedTaskB];
    
    // it's one more than the identifier for expectedTaskB which is set to 3
    assert([sut nextTaskId] == 4);
    
    // now let's simulate more task and check if we are still ok, returning one more than the last task identifier
    [sut addTask:expectedTaskA];
    [sut addTask:expectedTaskB];
    
    int testTaskIdentifier = 10;
    NSString *testTaskName = @"TestTaskName";
    NSString *testTaskDetails = @"TestTaskDetails";
    NSString *testTaskTimestamp = @"2013-11-05";
    
    AMYTask *expectedTask = [[AMYTask alloc] initWithIdentifier:[NSNumber numberWithInt:testTaskIdentifier]
                                                   name:testTaskName
                                                details:testTaskDetails
                                              timestamp:testTaskTimestamp
                                               complete:YES];
    
  
    [sut addTask:expectedTask];
    assert([sut nextTaskId] == 11);
}

@end
