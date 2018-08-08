//
//  ShowViewController.m
//  学生管理系统
//
//  Created by 姜凯文 on 2018/8/7.
//  Copyright © 2018年 姜凯文. All rights reserved.
//

#import "StudentNSObject.h"
#import "StudentSystem.h"
#import "ShowViewController.h"
#import "AllNavigationController.h"
#import "AddViewController.h"
#import "DeleteViewController.h"
#import "ModifierViewController.h"
#import "SeekViewController.h"
#define JKWDeviceWidth [UIScreen mainScreen].bounds.size.width
#define JKWDeviceHeight [UIScreen mainScreen].bounds.size.height
@interface ShowViewController ()

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.title = @"展示";
    self.view.backgroundColor = [UIColor colorWithRed:0.97f green:0.51f blue:0.06f alpha:1.00f];
    
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(JKWDeviceWidth * 0.2, JKWDeviceHeight * 0.2, JKWDeviceWidth * 0.6, JKWDeviceHeight * 0.1)];
    addButton.tag = 100;
    [addButton setTitle:@"增   加" forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont systemFontOfSize:40];
    addButton.layer.masksToBounds = YES;
    addButton.layer.cornerRadius = 3;
    addButton.backgroundColor = [UIColor colorWithRed:0.49f green:0.80f blue:1.00f alpha:1.00f];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(pushAll:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
    UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(JKWDeviceWidth * 0.2, JKWDeviceHeight * 0.35, JKWDeviceWidth * 0.6, JKWDeviceHeight * 0.1)];
    deleteButton.tag = 101;
    [deleteButton setTitle:@"删   除" forState:UIControlStateNormal];
    deleteButton.titleLabel.font = [UIFont systemFontOfSize:40];
    deleteButton.layer.masksToBounds = YES;
    deleteButton.layer.cornerRadius = 3;
    deleteButton.backgroundColor = [UIColor colorWithRed:0.49f green:0.80f blue:1.00f alpha:1.00f];
    [deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(pushAll:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteButton];
    
    UIButton *modifierButton = [[UIButton alloc] initWithFrame:CGRectMake(JKWDeviceWidth * 0.2, JKWDeviceHeight * 0.5, JKWDeviceWidth * 0.6, JKWDeviceHeight * 0.1)];
    modifierButton.tag = 102;
    [modifierButton setTitle:@"修   改" forState:UIControlStateNormal];
    modifierButton.titleLabel.font = [UIFont systemFontOfSize:40];
    modifierButton.layer.masksToBounds = YES;
    modifierButton.layer.cornerRadius = 3;
    modifierButton.backgroundColor = [UIColor colorWithRed:0.49f green:0.80f blue:1.00f alpha:1.00f];
    [modifierButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [modifierButton addTarget:self action:@selector(pushAll:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:modifierButton];
    
    UIButton *seekButton = [[UIButton alloc] initWithFrame:CGRectMake(JKWDeviceWidth * 0.2, JKWDeviceHeight * 0.65, JKWDeviceWidth * 0.6, JKWDeviceHeight * 0.1)];
    seekButton.tag = 103;
    [seekButton setTitle:@"查   找" forState:UIControlStateNormal];
    seekButton.titleLabel.font = [UIFont systemFontOfSize:40];
    seekButton.layer.masksToBounds = YES;
    seekButton.layer.cornerRadius = 3;
    seekButton.backgroundColor = [UIColor colorWithRed:0.49f green:0.80f blue:1.00f alpha:1.00f];
    [seekButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [seekButton addTarget:self action:@selector(pushAll:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:seekButton];
    
    NSArray *nameArray = @[@"刘备", @"关羽", @"张飞", @"诸葛亮", @"曹操", @"贾诩", @"许诸"];
    NSArray *idArray = @[@"04173030", @"04173031", @"04173032", @"04173033", @"04173034", @"04173035", @"04173036"];
    NSArray *gradeArray = @[@"1", @"2", @"3", @"4", @"1", @"2", @"3"];
    NSArray *ageArray = @[@"16", @"17", @"18", @"19", @"20", @"16", @"18"];
    NSArray *scoreArray = @[@"33.5", @"44.7", @"22.3", @"99.1", @"13.5", @"28.6", @"53.7"];
    _studentOriginalNSM = [[NSMutableArray alloc] init];
    for (int i = 0; i < 7; i++) {
        int intGrade= [gradeArray[i] intValue];
        int intAge = [ageArray[i] intValue];
        float floatScore = [scoreArray[i] floatValue];
        StudentNSObject *tempStudentNSO = [[StudentNSObject alloc] init];
        tempStudentNSO.nameString = nameArray[i];
        tempStudentNSO.ID = idArray[i];
        tempStudentNSO.grade = intGrade;
        tempStudentNSO.age = intAge;
        tempStudentNSO.score = floatScore;
        [_studentOriginalNSM addObject:tempStudentNSO];
    }
}

- (void) pushAll:(UIButton *)btn {
    if (btn.tag == 100) {
        AddViewController *addViewController = [[AddViewController alloc] init];
        [self.navigationController pushViewController:addViewController animated:YES];
        addViewController.temp1 = _studentOriginalNSM;
    }
    else if (btn.tag == 101) {
        DeleteViewController *deleteViewController = [[DeleteViewController alloc] init];
        [self.navigationController pushViewController:deleteViewController animated:YES];
    }
    else if (btn.tag == 102) {
        ModifierViewController *modifierViewController = [[ModifierViewController alloc] init];
        [self.navigationController pushViewController:modifierViewController animated:YES];
    }
    else {
        SeekViewController *seekViewController = [[SeekViewController alloc] init];
        [self.navigationController pushViewController:seekViewController animated:YES];
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
