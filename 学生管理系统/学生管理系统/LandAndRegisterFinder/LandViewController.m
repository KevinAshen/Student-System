//
//  LandViewController.m
//  学生管理系统
//
//  Created by 姜凯文 on 2018/8/7.
//  Copyright © 2018年 姜凯文. All rights reserved.
//

#import "LandViewController.h"
#import "RegisterViewController.h"
#import "ShowViewController.h"
#import "AddViewController.h"
#import "DeleteViewController.h"
#import "ModifierViewController.h"
#import "SeekViewController.h"
#import "AllNavigationController.h"
#define JKWDeviceWidth [UIScreen mainScreen].bounds.size.width
#define JKWDeviceHeight [UIScreen mainScreen].bounds.size.height
@interface LandViewController ()<UITextFieldDelegate, RegisterViewControllerDelegate>

@end

@implementation LandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _accountAndPasswordNSM = [[NSMutableArray alloc] init];
    [_accountAndPasswordNSM addObjectsFromArray:@[@[@"123", @"456"], @[@"789", @"888"],]];
    
    //self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *backGroundImage = [UIImage imageNamed:@"land.jpg"];
    self.view.layer.contents = (id) backGroundImage.CGImage;
    self.view.layer.backgroundColor = [UIColor clearColor].CGColor;
    
//    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(JKWDeviceWidth * 0.2, JKWDeviceHeight * 0.2, JKWDeviceWidth * 0.6, JKWDeviceHeight * 0.3)];
//    welcomeLabel.font = [UIFont systemFontOfSize:55];
//    welcomeLabel.numberOfLines = 0;
//    welcomeLabel.text = @"欢    迎";
//    welcomeLabel.textAlignment = NSTextAlignmentCenter;
//    welcomeLabel.textColor = [UIColor colorWithRed:0.37f green:0.39f blue:0.61f alpha:1.00f];
//    [self.view addSubview:welcomeLabel];
    
    _accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(JKWDeviceWidth * 0.2, JKWDeviceHeight * 0.5, JKWDeviceWidth * 0.6, JKWDeviceWidth * 0.1)];
    _accountTextField.backgroundColor = [UIColor whiteColor];
    _accountTextField.placeholder = @"请输入您的账号";
    _accountTextField.borderStyle = UITextBorderStyleNone;
    _accountTextField.delegate = self;
    _accountTextField.backgroundColor = [UIColor colorWithRed:0.82f green:0.82f blue:0.82f alpha:1.00f];
    [self.view addSubview:_accountTextField];
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(JKWDeviceWidth * 0.2, JKWDeviceHeight * 0.6, JKWDeviceWidth * 0.6, JKWDeviceWidth * 0.1)];
    _passwordTextField.backgroundColor = [UIColor colorWithRed:0.82f green:0.82f blue:0.82f alpha:1.00f];
    _passwordTextField.placeholder = @"请输入您的密码";
    _passwordTextField.borderStyle = UITextBorderStyleNone;
    _passwordTextField.delegate = self;
    _passwordTextField.secureTextEntry = YES;
    [self.view addSubview:_passwordTextField];
    
    UIButton *landButton = [[UIButton alloc] initWithFrame:CGRectMake(JKWDeviceWidth * 0.25, JKWDeviceHeight * 0.71, JKWDeviceWidth * 0.2, JKWDeviceWidth * 0.1)];
    landButton.layer.masksToBounds = YES;
    landButton.layer.cornerRadius = 3;
    landButton.backgroundColor = [UIColor colorWithRed:0.72f green:0.54f blue:0.64f alpha:1.00f];
    [landButton setTitle:@"登录" forState:UIControlStateNormal];
    [landButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [landButton addTarget:self action:@selector(touchLand) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:landButton];
    
    UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake(JKWDeviceWidth * 0.55, JKWDeviceHeight * 0.71, JKWDeviceWidth * 0.2, JKWDeviceWidth * 0.1)];
    registerButton.layer.masksToBounds = YES;
    registerButton.layer.cornerRadius = 3;
    registerButton.backgroundColor = [UIColor colorWithRed:0.72f green:0.54f blue:0.64f alpha:1.00f];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(touchRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisAppear:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWillDisAppear:(NSNotification *)notification{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    [UIView animateWithDuration:1 animations:^{self.view.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height-keyboardY);}];
}

- (void)keyboardWillAppear:(NSNotification *)notification{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    [UIView animateWithDuration:1.0 animations:^{self.view.transform = CGAffineTransformMakeTranslation(0, keyboardY - self.view.frame.size.height);}];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)passAccount:(NSString *)accountString passPassword:(NSString *)passwordString {
    _accountTextField.text = accountString;
    _passwordTextField.text = passwordString;
    NSMutableArray *tempNSM = [[NSMutableArray alloc] init];
    [tempNSM addObject:accountString];
    [tempNSM addObject:passwordString];
    [_accountAndPasswordNSM addObject:tempNSM];
}
- (void) touchLand {
    [self.view endEditing:YES];
    for (int i = 0; i < _accountAndPasswordNSM.count; i++) {
        if ([_accountTextField.text isEqualToString:_accountAndPasswordNSM[i][0]] && [_passwordTextField.text isEqualToString:_accountAndPasswordNSM[i][1]]) {
            ShowViewController *showViewController = [[ShowViewController alloc] init];
            AllNavigationController *showNav = [[AllNavigationController alloc] initWithRootViewController:showViewController];
            [self presentViewController:showNav animated:YES completion:nil];
        }
    }
    UIAlertController *wrongAlertController = [UIAlertController alertControllerWithTitle:@"登录失败" message:@"账户或密码错误" preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *returnAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
    [wrongAlertController addAction:returnAction];
     [self presentViewController:wrongAlertController animated:YES completion:nil];
}

- (void) touchRegister {
    [self.view endEditing:YES];
    RegisterViewController *registerViewController = [[RegisterViewController alloc] init];
    registerViewController.registerDelegate = self;
    [self presentViewController:registerViewController animated:YES completion:nil];
    registerViewController.accountAndPasswordNSM = _accountAndPasswordNSM;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
