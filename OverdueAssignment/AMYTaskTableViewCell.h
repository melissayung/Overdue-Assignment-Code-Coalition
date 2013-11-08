//
//  AMYTaskTableViewCell.h
//  OverdueAssignment
//
//  Created by Melissa Yung on 05/11/13.
//
//

#import <UIKit/UIKit.h>

@interface AMYTaskTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *taskNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskTimestampLabel;
@property (strong, nonatomic) IBOutlet UIImageView *taskImageView;

@end
