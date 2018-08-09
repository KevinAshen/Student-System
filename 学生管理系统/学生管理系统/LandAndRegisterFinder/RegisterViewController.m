//
//  RegisterViewController.m
//  学生管理系统
//
//  Created by 姜凯文 on 2018/8/7.
//  Copyright © 2018年 姜凯文. All rights reserved.
//

#import "RegisterViewController.h"
#define JKWDeviceWidth [UIScreen mainScreen].bounds.size.width
#define JKWDeviceHeight [UIScreen mainScreen].bounds.size.height

@interface RegisterViewController ()<UITextFieldDelegate>

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _accountAndPasswordNSM = [[NSMutableArray alloc] init];
    
    UIImage *backGroundImage = [UIImage imageNamed:@"register1.jpg"];
    self.view.layer.contents = (id) backGroundImage.CGImage;
    self.view.layer.backgroundColor = [UIColor clearColor].CGColor;
    
//    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(JKWDeviceWidth * 0.2, JKWDeviceHeight * 0.2, JKWDeviceWidth * 0.6, JKWDeviceHeight * 0.3)];
//    welcomeLabel.font = [UIFont systemFontOfSize:55];
//    welcomeLabel.numberOfLines = 0;
//    welcomeLabel.text = @"注    册";
//    welcomeLabel.textAlignment = NSTextAlignmentCenter;
//    welcomeLabel.textColor = [UIColor colorWithRed:0.37f green:0.39f blue:0.61f alpha:1.00f];
//    [self.view addSubview:welcomeLabel];
    
    _accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(JKWDeviceWidth * 0.2, JKWDeviceHeight * 0.5, JKWDeviceWidth * 0.6, JKWDeviceWidth * 0.1)];
    _accountTextField.backgroundColor = [UIColor colorWithRed:0.82f green:0.82f blue:0.82f alpha:1.00f];
    _accountTextField.placeholder = @"请输入您的账号";
    _accountTextField.borderStyle = UITextBorderStyleNone;
    _accountTextField.delegate = self;
    [self.view addSubview:_accountTextField];
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(JKWDeviceWidth * 0.2, JKWDeviceHeight * 0.6, JKWDeviceWidth * 0.6, JKWDeviceWidth * 0.1)];
    _passwordTextField.backgroundColor = [UIColor colorWithRed:0.82f green:0.82f blue:0.82f alpha:1.00f];
    _passwordTextField.placeholder = @"请输入您的密码";
    _passwordTextField.borderStyle = UITextBorderStyleNone;
    _passwordTextField.delegate = self;
    _passwordTextField.secureTextEntry = YES;
    [self.view addSubview:_passwordTextField];
    
    UIButton *returnLandButton = [[UIButton alloc] initWithFrame:CGRectMake(JKWDeviceWidth * 0.3, JKWDeviceHeight * 0.71, JKWDeviceWidth * 0.4, JKWDeviceWidth * 0.1)];
    returnLandButton.layer.masksToBounds = YES;
    returnLandButton.layer.cornerRadius = 3;
    returnLandButton.backgroundColor = [UIColor colorWithRed:0.72f green:0.54f blue:0.64f alpha:1.00f];
    [returnLandButton setTitle:@"确认注册" forState:UIControlStateNormal];
    [returnLandButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [returnLandButton addTarget:self action:@selector(returnLand) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnLandButton];
    
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

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void) returnLand {
    [self.view endEditing:YES];
    NSLog(@"first %lu", _accountAndPasswordNSM.count);
    if (_accountTextField.text.length == 0 || _passwordTextField.text.length == 0) {
        UIAlertController *faultAlertController = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"输入不得为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *returnAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
        [faultAlertController addAction:returnAction];
        [self presentViewController:faultAlertController animated:YES completion:nil];
        return;
    }
    for (int i = 0; i < _accountAndPasswordNSM.count; i++) {
        if ([_accountTextField.text isEqualToString:_accountAndPasswordNSM[i][0]]) {
            UIAlertController *faultAlertController = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"账户重复" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *returnAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
            [faultAlertController addAction:returnAction];
            [self presentViewController:faultAlertController animated:YES completion:nil];
            return;
        }
    }
    NSMutableArray *tempNSM = [[NSMutableArray alloc] init];
    [tempNSM addObject:_accountTextField.text];
    [tempNSM addObject:_passwordTextField.text];
    [_accountAndPasswordNSM addObject:tempNSM];
    NSLog(@"second %lu", _accountAndPasswordNSM.count);
    [self dismissViewControllerAnimated:YES completion:nil];
    if ([_registerDelegate respondsToSelector:@selector(passAccount:passPassword:)]) {
        [_registerDelegate passAccount:_accountTextField.text passPassword:_passwordTextField.text];
    }
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
