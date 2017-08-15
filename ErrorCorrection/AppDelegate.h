//
//  AppDelegate.h
//  ErrorCorrection
//
//  Created by wln100-IOS1 on 17/7/4.
//  Copyright © 2017年 TianXing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
/**
 标记是否可以旋转
 */
@property (nonatomic, assign) BOOL allowRotation;

@end

