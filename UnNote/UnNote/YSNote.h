//
//  YSNote.h
//  UnNote
//
//  Created by lysongzi on 15/12/27.
//  Copyright © 2015年 lysongzi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSNote : NSObject

@property (copy, nonatomic) NSString *oid;
@property (copy, nonatomic) NSString *uid;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *content;
@property (weak, nonatomic) NSDate *createDate;
@property (weak, nonatomic) NSDate *updateDate;
@property (assign) int type;

- (instancetype)initWithTitle:(NSString *)title Content:(NSString *)content;
- (instancetype)initWithTitle:(NSString *)title Content:(NSString *)content createDate:(NSDate *)createDate updateDate:(NSDate *)updateDate;

@end
