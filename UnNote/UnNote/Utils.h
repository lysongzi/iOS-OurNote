//
//  Utils.h
//  UnNote
//
//  Created by lysongzi on 15/12/22.
//  Copyright © 2015年 lysongzi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject

+ (void)jumpToViewController:(NSString *)viewControllerIndentifier
       contextViewController:(UIViewController *)contextViewController
                     handler:(void (^)(void)) handler;

+ (NSString *)md5:(NSString *)str;

@end
