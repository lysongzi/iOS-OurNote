//
//  YSNote.m
//  UnNote
//
//  Created by lysongzi on 15/12/27.
//  Copyright © 2015年 lysongzi. All rights reserved.
//

#import "YSNote.h"

@implementation YSNote

- (instancetype)initWithTitle:(NSString *)title Content:(NSString *)content
{
    return [self initWithTitle:title Content:content createDate:nil updateDate:nil];
}

- (instancetype)initWithTitle:(NSString *)title Content:(NSString *)content createDate:(NSDate *)createDate updateDate:(NSDate *)updateDate
{
    self = [super init];
    if (self)
    {
        _title = title;
        _content = content;
        _createDate = createDate;
        _updateDate = updateDate;
    }
    return self;
}

@end
