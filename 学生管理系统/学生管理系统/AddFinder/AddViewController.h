//
//  AddViewController.h
//  学生管理系统
//
//  Created by 姜凯文 on 2018/8/8.
//  Copyright © 2018年 姜凯文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentSystem.h"
#import "StudentNSObject.h"
@protocol AddViewControllerDelegate <NSObject>
-(void) passAddNSM:(NSMutableArray *) newNSM;
@end
@interface AddViewController : UIViewController

@property (nonatomic, strong) StudentSystem *studentSystem;
@property (nonatomic, strong) StudentNSObject *studentNSO;

@property (nonatomic, strong) NSMutableArray *temp1;

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *idTextField;
@property (nonatomic, strong) UITextField *gradeTextField;
@property (nonatomic, strong) UITextField *ageTextField;
@property (nonatomic, strong) UITextField *scoreTextField;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, weak)id <AddViewControllerDelegate> addViewControllerDelegate;
@end
