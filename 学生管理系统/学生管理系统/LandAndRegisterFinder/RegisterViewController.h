//
//  RegisterViewController.h
//  学生管理系统
//
//  Created by 姜凯文 on 2018/8/7.
//  Copyright © 2018年 姜凯文. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RegisterViewController;
@protocol RegisterViewControllerDelegate<NSObject>  
- (void) passAccount:(NSString *)accountString passPassword:(NSString *)passwordString;
@end

@interface RegisterViewController : UIViewController

@property (nonatomic, strong) UITextField *accountTextField;
@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, weak)id <RegisterViewControllerDelegate> registerDelegate;

@end
