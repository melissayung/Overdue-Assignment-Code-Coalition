//
//  AMYTask.h
//  OverdueAssignment
//
//  Created by Melissa Yung on 04/11/13.
//
//

#import <Foundation/Foundation.h>

//NSString * const TASKIDENTIFIER = @"AMYTaskIdentifier";
//NSString * const TASKNAME = @"AMYTaskName";
//NSString * const TASKDETAILS = @"AMYTaskDetails";
//NSString * const TASKTIMESTAMP = @"AMYTaskTimestamp";
//NSString * const TASKCOMPLETE = @"AMYTaskComplete";

@interface AMYTask : NSObject

@property (strong, nonatomic) NSNumber *identifier;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *details;
@property (strong, nonatomic) NSString *timestamp;
@property (nonatomic) BOOL complete;

-(id) initWithIdentifier:(NSNumber *)identifier
                    name:(NSString *)name
                 details:(NSString *)details
               timestamp:(NSString *)timestamp
                complete:(BOOL)complete;

-(id) initWithDictionary:(NSDictionary *)dictionary;

// we should only have to use this in the AMYPersistentTaskManager
// all the other classes should just use the AMYTask class and don't need to be aware
// of the need to convert to a dictionary to store in NSUserDefaults
-(NSMutableDictionary *) taskAsAPropertyList;

@end
