//
//  StudentSystem.m
//  学生管理系统
//
//  Created by 姜凯文 on 2018/8/8.
//  Copyright © 2018年 姜凯文. All rights reserved.
//

#import "StudentSystem.h"


@implementation StudentSystem

- (id) init {
    if (self = [super init]) {
        _studentNSM = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BOOL) addStudentArray:(StudentNSObject *)tempStudent{
//    for (tempStudent in _studentNSM) {
//        for (StudentNSObject *tempSystemStudent in _studentNSM) {
//            if ([tempSystemStudent.ID isEqualToString:tempStudent.ID]) {
//                return NO;
//            }
//        }
//    }
//    NSString *stringGrade = [NSString stringWithFormat:@"%d", tempStudent.grade];
//    NSString *stringAge = [NSString stringWithFormat:@"%d", tempStudent.age];
//    NSString *stringScore = [NSString stringWithFormat:@"%f", tempStudent.score];
//    if (tempStudent.nameString.length == 0 || tempStudent.ID.length == 0 || stringGrade.length == 0 || stringAge.length == 0 || stringScore.length == 0) {
//        return NO;
//    }
//    else {
        NSLog(@"%@", tempStudent.nameString);
        [_studentNSM addObject:tempStudent];
        return YES;
//    }
}
@end
