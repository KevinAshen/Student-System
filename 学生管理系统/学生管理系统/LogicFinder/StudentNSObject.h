//
//  StudentNSObject.h
//  学生管理系统
//
//  Created by 姜凯文 on 2018/8/8.
//  Copyright © 2018年 姜凯文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudentNSObject : NSObject

@property (nonatomic, copy) NSString *nameString;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, assign) int grade;
@property (nonatomic, assign) int age;
@property (nonatomic, assign) float score;

- (void) printStudent;
- (BOOL)checkIsAllNum:(NSString *)myString;
@end
