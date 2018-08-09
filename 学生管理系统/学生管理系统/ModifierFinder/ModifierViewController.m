//
//  ModifierViewController.m
//  学生管理系统
//
//  Created by 姜凯文 on 2018/8/8.
//  Copyright © 2018年 姜凯文. All rights reserved.
//

#import "ModifierViewController.h"
#import "ShowViewController.h"
#import "JKWTableViewCell.h"
#define JKWDeviceWidth [UIScreen mainScreen].bounds.size.width
#define JKWDeviceHeight [UIScreen mainScreen].bounds.size.height
@interface ModifierViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@end

@implementation ModifierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"修改";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 0, 25,25);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back_img"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, JKWDeviceHeight * 0.525, JKWDeviceWidth, JKWDeviceHeight * 0.4)];
    bottomView.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f];
    [self.view addSubview:bottomView];
    
    _idTextField = [[UITextField alloc] initWithFrame:CGRectMake(JKWDeviceWidth * 0.1, JKWDeviceHeight * 0.025, JKWDeviceWidth * 0.6, JKWDeviceHeight * 0.05)];
    _idTextField.backgroundColor = [UIColor whiteColor];
    _idTextField.placeholder = @"请输入ID(8位数字)后点击查询";
    _idTextField.delegate = self;
    _idTextField.keyboardType = UIKeyboardTypeNumberPad;
    [bottomView addSubview:_idTextField];
    
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(JKWDeviceWidth * 0.1, JKWDeviceHeight * 0.1, JKWDeviceWidth * 0.6, JKWDeviceHeight * 0.05)];
    _nameTextField.backgroundColor = [UIColor whiteColor];
    _nameTextField.placeholder = @"请输入学生姓名(2~4个字)";
    _nameTextField.delegate = self;
    [bottomView addSubview:_nameTextField];

    _gradeTextField = [[UITextField alloc] initWithFrame:CGRectMake(JKWDeviceWidth * 0.1, JKWDeviceHeight * 0.175, JKWDeviceWidth * 0.6, JKWDeviceHeight * 0.05)];
    _gradeTextField.backgroundColor = [UIColor whiteColor];
    _gradeTextField.placeholder = @"请输入学生年级(1~4)";
    _gradeTextField.delegate = self;
    _gradeTextField.keyboardType = UIKeyboardTypeNumberPad;
    [bottomView addSubview:_gradeTextField];
    
    _ageTextField = [[UITextField alloc] initWithFrame:CGRectMake(JKWDeviceWidth * 0.1, JKWDeviceHeight * 0.25, JKWDeviceWidth * 0.6, JKWDeviceHeight * 0.05)];
    _ageTextField.backgroundColor = [UIColor whiteColor];
    _ageTextField.placeholder = @"请输入学生年龄(16~25)";
    _ageTextField.delegate = self;
    _ageTextField.keyboardType = UIKeyboardTypeNumberPad;
    [bottomView addSubview:_ageTextField];
    
    _scoreTextField = [[UITextField alloc] initWithFrame:CGRectMake(JKWDeviceWidth * 0.1, JKWDeviceHeight * 0.325, JKWDeviceWidth * 0.6, JKWDeviceHeight * 0.05)];
    _scoreTextField.backgroundColor = [UIColor whiteColor];
    _scoreTextField.placeholder = @"请输入学生成绩(1~100)";
    _scoreTextField.delegate = self;
    _scoreTextField.keyboardType = UIKeyboardTypeNumberPad;
    [bottomView addSubview:_scoreTextField];
    
     //CGRectMake(JKWDeviceWidth * 0.1, JKWDeviceHeight * 0.025, JKWDeviceWidth * 0.6, JKWDeviceHeight * 0.05)];
    UIButton *seekButton =[[UIButton alloc] initWithFrame:CGRectMake(JKWDeviceWidth * 0.75, JKWDeviceHeight * 0.025, JKWDeviceWidth * 0.15, JKWDeviceHeight * 0.05)];
    seekButton.backgroundColor = [UIColor colorWithRed:0.49f green:0.79f blue:1.00f alpha:1.00f];
    seekButton.titleLabel.numberOfLines = 0;
    [seekButton setTitle:@"查询" forState:UIControlStateNormal];
    [seekButton addTarget:self action:@selector(seekPass) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:seekButton];
    
    UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(JKWDeviceWidth * 0.75, JKWDeviceHeight * 0.1, JKWDeviceWidth * 0.15, JKWDeviceHeight * 0.2)];
    confirmButton.backgroundColor = [UIColor colorWithRed:0.49f green:0.79f blue:1.00f alpha:1.00f];
    confirmButton.titleLabel.numberOfLines = 0;
    [confirmButton setTitle:@"确\n\n\n认" forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(confirmPass) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:confirmButton];
    
    _studentSystem = [[StudentSystem alloc] init];
    _studentSystem.studentNSM = _temp1;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, JKWDeviceWidth, JKWDeviceHeight * 0.475 + 50) style:UITableViewStylePlain];
    _tableView.showsVerticalScrollIndicator = NO;
    
    [_tableView registerClass:[JKWTableViewCell class] forCellReuseIdentifier:@"cell1"];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JKWDeviceWidth, 40)];
    UILabel *topNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 55, 30)];
    topNameLabel.text = @"姓名";
    UILabel *topIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 10, 90, 30)];
    topIdLabel.text = @"ID";
    UILabel *topGradeLabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 10, 40, 30)];
    topGradeLabel.text = @"年级";
    UILabel *topAgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(245, 10, 45, 30)];
    topAgeLabel.text = @"年龄";
    UILabel *topScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(320, 10, 55, 30)];
    topScoreLabel.text = @"成绩";
    [topView addSubview:topNameLabel];
    [topView addSubview:topIdLabel];
    [topView addSubview:topGradeLabel];
    [topView addSubview:topAgeLabel];
    [topView addSubview:topScoreLabel];
    
    _tableView.tableHeaderView = topView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisAppear:) name:UIKeyboardWillHideNotification object:nil];
}

- (void) seekPass {
    [self.view endEditing:YES];
    //NSLog(@"%lu", _studentSystem.studentNSM.count);
    int j = [_studentSystem seekStudentInArray:_idTextField.text];
    if (j == -1) {
        _idTextField.text = @"";
        UIAlertController *wrongAlertController = [UIAlertController alertControllerWithTitle:@"错误" message:@"查无此人" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *returnAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
        
        [wrongAlertController addAction:returnAction];
        [self presentViewController:wrongAlertController animated:YES completion:nil];
    }
    else {
        StudentNSObject *seekSlectStudent = [[StudentNSObject alloc] init];
        seekSlectStudent = _studentSystem.studentNSM[j];
        NSString *stringGrade = [NSString stringWithFormat:@"%d", seekSlectStudent.grade];
        NSString *stringAge = [NSString stringWithFormat:@"%d", seekSlectStudent.age];
        NSString *stringScore = [NSString stringWithFormat:@"%.1f", seekSlectStudent.score];
        _nameTextField.text = seekSlectStudent.nameString;
        _idTextField.text = seekSlectStudent.ID;
        _gradeTextField.text = stringGrade;
        _ageTextField.text = stringAge;
        _scoreTextField.text = stringScore;
    }
    
}

- (void) confirmPass {
    [self.view endEditing:YES];
    //NSLog(@"%lu", _studentSystem.studentNSM.count);
    int j = [_studentSystem seekStudentInArray:_idTextField.text];
    if (j == -1) {
        UIAlertController *wrongAlertController = [UIAlertController alertControllerWithTitle:@"错误" message:@"查无此人" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *returnAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
        
        [wrongAlertController addAction:returnAction];
        [self presentViewController:wrongAlertController animated:YES completion:nil];
    }
    else {
        StudentNSObject *tempConfirmStudent = [[StudentNSObject alloc] init];
        int intGrade= [_gradeTextField.text intValue];
        int intAge = [_ageTextField.text intValue];
        float floatScore = [_scoreTextField.text floatValue];
        tempConfirmStudent.nameString = _nameTextField.text;
        tempConfirmStudent.ID = _idTextField.text;
        tempConfirmStudent.grade = intGrade;
        tempConfirmStudent.age = intAge;
        tempConfirmStudent.score = floatScore;
        [_nameTextField setText:@""];
        [_idTextField setText:@""];
        [_ageTextField setText:@""];
        [_gradeTextField setText:@""];
        [_scoreTextField setText:@""];
        if ([_studentSystem modifierStudentArray:tempConfirmStudent modifierStudentCount:j] == NO) {
            UIAlertController *wrongAlertController = [UIAlertController alertControllerWithTitle:@"修改失败" message:@"请遵守填写规则且保证ID没有重复" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *returnAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
            [wrongAlertController addAction:returnAction];
            [self presentViewController:wrongAlertController animated:YES completion:nil];
        }
        else {
            UIAlertController *rightAlertController = [UIAlertController alertControllerWithTitle:@"修改成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *returnAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
            [rightAlertController addAction:returnAction];
            [self presentViewController:rightAlertController animated:YES completion:nil];
            [_tableView reloadData];
        }
    }
}

- (void)leftBarBtnClicked:(UIButton *)btn
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
    if ([_modifierViewControllerDelegate respondsToSelector:@selector(passModifierNSM:)]) {
        [_modifierViewControllerDelegate passModifierNSM:_studentSystem.studentNSM];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JKWTableViewCell  *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    _studentNSO = [[StudentNSObject alloc] init];
    _studentNSO = _studentSystem.studentNSM[indexPath.row];
    cell1.nameLabel.text = _studentNSO.nameString;
    cell1.idLabel.text = _studentNSO.ID;
    NSString *stringGrade = [NSString stringWithFormat:@"%d", _studentNSO.grade];
    cell1.gradeLabel.text = stringGrade;
    NSString *stringAge = [NSString stringWithFormat:@"%d", _studentNSO.age];
    cell1.ageLabel.text = stringAge;
    NSString *stringScore = [NSString stringWithFormat:@"%.1f", _studentNSO.score];
    cell1.scoreLabel.text = stringScore;
    return cell1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_studentSystem.studentNSM count];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)keyboardWillDisAppear:(NSNotification *)notification{
    [UIView animateWithDuration:1 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, 0);
        
    }];
}

- (void)keyboardWillAppear:(NSNotification *)notification{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    [UIView animateWithDuration:1.0 animations:^{self.view.transform = CGAffineTransformMakeTranslation(0, keyboardY - self.view.frame.size.height - 60);}];
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
