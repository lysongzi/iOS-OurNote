//
//  YsNoteTableViewCell.h
//  UnNote
//
//  Created by lysongzi on 15/12/27.
//  Copyright © 2015年 lysongzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSNoteTableViewCell : UITableViewCell

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *title;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *content;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *date;

@end
