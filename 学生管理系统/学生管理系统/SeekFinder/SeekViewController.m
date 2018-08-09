//
//  SeekViewController.m
//  学生管理系统
//
//  Created by 姜凯文 on 2018/8/8.
//  Copyright © 2018年 姜凯文. All rights reserved.
//

#import "SeekViewController.h"
#import "ShowViewController.h"
#import "JKWTableViewCell.h"
#define JKWDeviceWidth [UIScreen mainScreen].bounds.size.width
#define JKWDeviceHeight [UIScreen mainScreen].bounds.size.height
@interface SeekViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@end

@implementation SeekViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"查找";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 0, 25,25);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back_img"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, JKWDeviceHeight * 0.825, JKWDeviceWidth, JKWDeviceHeight * 0.1)];
    bottomView.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f];
    [self.view addSubview:bottomView];
    
    _idTextField = [[UITextField alloc] initWithFrame:CGRectMake(JKWDeviceWidth * 0.1, JKWDeviceHeight * 0.025, JKWDeviceWidth * 0.6, JKWDeviceHeight * 0.05)];
    _idTextField.backgroundColor = [UIColor whiteColor];
    _idTextField.placeholder = @"请输入学生ID(8位数字)";
    _idTextField.delegate = self;
    _idTextField.keyboardType = UIKeyboardTypeNumberPad;
    [bottomView addSubview:_idTextField];
    
    UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(JKWDeviceWidth * 0.75, JKWDeviceHeight * 0.025, JKWDeviceWidth * 0.15, JKWDeviceHeight * 0.05)];
    confirmButton.backgroundColor = [UIColor colorWithRed:0.49f green:0.79f blue:1.00f alpha:1.00f];
    confirmButton.titleLabel.numberOfLines = 0;
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(confirmPass) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:confirmButton];
    
    _studentSystem = [[StudentSystem alloc] init];
    _studentSystem.studentNSM = _temp1;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, JKWDeviceWidth, JKWDeviceHeight * 0.775 + 50) style:UITableViewStylePlain];
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

- (void) confirmPass {
    [self.view endEditing:YES];
    //NSLog(@"%lu", _studentSystem.studentNSM.count);
    int j = [_studentSystem seekStudentInArray:_idTextField.text];
    _idTextField.text = @"";
    if (j == -1) {
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
        NSLog(@"%d", j);
        UIAlertController *seekSheet = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
        [seekSheet addAction:cancelAction];
        
        UIAlertAction *nameAction = [UIAlertAction actionWithTitle:seekSlectStudent.nameString style:UIAlertActionStyleDefault handler:nil];
        [seekSheet addAction:nameAction];
        
        UIAlertAction *idAction = [UIAlertAction actionWithTitle:seekSlectStudent.ID style:UIAlertActionStyleDefault handler:nil];
        [seekSheet addAction:idAction];
        
        UIAlertAction *gradeAction = [UIAlertAction actionWithTitle:stringGrade style:UIAlertActionStyleDefault handler:nil];
        [seekSheet addAction:gradeAction];
        
        UIAlertAction *ageAction = [UIAlertAction actionWithTitle:stringAge style:UIAlertActionStyleDefault handler:nil];
        [seekSheet addAction:ageAction];
        
        UIAlertAction *scoreAction = [UIAlertAction actionWithTitle:stringScore style:UIAlertActionStyleDefault handler:nil];
        [seekSheet addAction:scoreAction];
        
        [self presentViewController:seekSheet animated:YES completion:nil];
    }
    
}

- (void)leftBarBtnClicked:(UIButton *)btn
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
    if ([_seekViewControllerDelegate respondsToSelector:@selector(passSeekNSM:)]) {
        [_seekViewControllerDelegate passSeekNSM:_studentSystem.studentNSM];
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
