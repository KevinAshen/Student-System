//
//  AddViewController.m
//  学生管理系统
//
//  Created by 姜凯文 on 2018/8/8.
//  Copyright © 2018年 姜凯文. All rights reserved.
//


#import "AddViewController.h"
#import "AllNavigationController.h"
#import "ShowViewController.h"
#import "JKWTableViewCell.h"
#import "StudentSystem.h"
#import "StudentNSObject.h"
#define JKWDeviceWidth [UIScreen mainScreen].bounds.size.width
#define JKWDeviceHeight [UIScreen mainScreen].bounds.size.height
@interface AddViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"增加";
    self.view.backgroundColor = [UIColor whiteColor];
   
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, JKWDeviceHeight * 0.525, JKWDeviceWidth, JKWDeviceHeight * 0.4)];
    bottomView.backgroundColor = [UIColor colorWithRed:1.00f green:0.51f blue:0.15f alpha:1.00f];
    [self.view addSubview:bottomView];
    
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(JKWDeviceWidth * 0.1, JKWDeviceHeight * 0.025, JKWDeviceWidth * 0.6, JKWDeviceHeight * 0.05)];
    _nameTextField.backgroundColor = [UIColor whiteColor];
    _nameTextField.placeholder = @"请输入学生姓名";
    [bottomView addSubview:_nameTextField];
    
    _idTextField = [[UITextField alloc] initWithFrame:CGRectMake(JKWDeviceWidth * 0.1, JKWDeviceHeight * 0.1, JKWDeviceWidth * 0.6, JKWDeviceHeight * 0.05)];
    _idTextField.backgroundColor = [UIColor whiteColor];
    _idTextField.placeholder = @"请输入学生ID";
    [bottomView addSubview:_idTextField];
    
    _gradeTextField = [[UITextField alloc] initWithFrame:CGRectMake(JKWDeviceWidth * 0.1, JKWDeviceHeight * 0.175, JKWDeviceWidth * 0.6, JKWDeviceHeight * 0.05)];
    _gradeTextField.backgroundColor = [UIColor whiteColor];
    _gradeTextField.placeholder = @"请输入学生年级";
    [bottomView addSubview:_gradeTextField];
    
    _ageTextField = [[UITextField alloc] initWithFrame:CGRectMake(JKWDeviceWidth * 0.1, JKWDeviceHeight * 0.25, JKWDeviceWidth * 0.6, JKWDeviceHeight * 0.05)];
    _ageTextField.backgroundColor = [UIColor whiteColor];
    _ageTextField.placeholder = @"请输入学生年龄";
    [bottomView addSubview:_ageTextField];
    
    _scoreTextField = [[UITextField alloc] initWithFrame:CGRectMake(JKWDeviceWidth * 0.1, JKWDeviceHeight * 0.325, JKWDeviceWidth * 0.6, JKWDeviceHeight * 0.05)];
    _scoreTextField.backgroundColor = [UIColor whiteColor];
    _scoreTextField.placeholder = @"请输入学生成绩";
    [bottomView addSubview:_scoreTextField];
    
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

- (void) confirmPass {
    StudentNSObject *tempConfirmStudent = [[StudentNSObject alloc] init];
    int intGrade= [_gradeTextField.text intValue];
    int intAge = [_ageTextField.text intValue];
    float floatScore = [_scoreTextField.text floatValue];
    tempConfirmStudent.nameString = _nameTextField.text;
    tempConfirmStudent.ID = _idTextField.text;
    tempConfirmStudent.grade = intGrade;
    tempConfirmStudent.age = intAge;
    tempConfirmStudent.score = floatScore;
    
    if ([_studentSystem addStudentArray:tempConfirmStudent] == NO) {
        NSLog(@"wrong!");
    }
    else {
         [_tableView reloadData];
        NSLog(@"OK");
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
