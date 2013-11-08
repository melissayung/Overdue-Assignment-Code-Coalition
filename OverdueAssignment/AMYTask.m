//
//  AMYTask.m
//  OverdueAssignment
//
//  Created by Melissa Yung on 04/11/13.
//
//

#import "AMYTask.h"

NSDateFormatter *dateFormatter ;

@implementation AMYTask

-(id) initWithIdentifier:(NSNumber *)identifier
                    name:(NSString *)name
                 details:(NSString *)details
               timestamp:(NSString *)timestamp
                complete:(BOOL)complete {
    _identifier = identifier;
    _name = name;
    _details = details;
    _timestamp = timestamp;
    _complete = complete;
    return self;
}

// when we retrieve it from NSUserDefaults as a dictionary, we want to parse the info and initialise the object
-(id) initWithDictionary:(NSDictionary *)dictionary {
    _identifier = [dictionary objectForKey:TASKIDENTIFIER];
    _name = [dictionary objectForKey:TASKNAME];
    _details = [dictionary objectForKey:TASKDETAILS];
    _timestamp = [dictionary objectForKey:TASKTIMESTAMP];
    _complete = [[dictionary objectForKey:TASKCOMPLETE] boolValue];
    return self;
}

-(NSMutableDictionary *) taskAsAPropertyList {

    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                        _identifier, TASKIDENTIFIER,
                                        _name, TASKNAME,
                                        _details, TASKDETAILS,
                                        _timestamp, TASKTIMESTAMP,
                                        [NSNumber numberWithBool:_complete], TASKCOMPLETE, nil];
    return dictionary;
}

-(BOOL)isEqual:(id)object {
    AMYTask *task = object;
    
    return (task.identifier == _identifier &&
            [task.name isEqualToString:_name] &&
            [task.details isEqualToString:_details] &&
            [task.timestamp isEqualToString:_timestamp] &&
            task.complete == _complete);
}


@end
