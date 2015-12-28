//
//  EditNoteViewController.h
//  UnNote
//
//  Created by lysongzi on 15/12/22.
//  Copyright © 2015年 lysongzi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSNote.h"

@interface YSEditNoteViewController : UIViewController

@property (weak, nonatomic) YSNote *note;
@property (assign) bool isAdd;

@end
