//
//  StudentSystem.h
//  学生管理系统
//
//  Created by 姜凯文 on 2018/8/8.
//  Copyright © 2018年 姜凯文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StudentNSObject.h"

@interface StudentSystem : NSObject

@property (nonatomic, strong) NSMutableArray *studentNSM;

- (BOOL) addStudentArray:(StudentNSObject *)tempStudent;

- (void) deleteStudentArray:(int)deleteStudentID;

- (int) seekStudentInArray:(NSString *)studentID;

- (BOOL) modifierStudentArray:(StudentNSObject *)tempStudent modifierStudentCount:(int) NSMcount;

@end
