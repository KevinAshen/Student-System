//
//  StudentNSObject.m
//  学生管理系统
//
//  Created by 姜凯文 on 2018/8/8.
//  Copyright © 2018年 姜凯文. All rights reserved.
//

#import "StudentNSObject.h"

@implementation StudentNSObject



//- (void) setNameString:(NSString *)nameString {
//    if ([nameString length] > 5 || [nameString length] < 2) {
//        return;
//    }
//    else {
//        _nameString = nameString;
//    }
//}
//
//- (void) setID:(NSString *)ID {
//    if ([ID length] != 8) {
//        return;
//    }
//    else {
//        _ID = ID;
//    }
//}
//
//- (void) setGrade:(int)grade {
//    if (grade < 1 || grade > 4) {
//        return;
//    }
//    else {
//        _grade = grade;
//    }
//}
//
//- (void) setAge:(int)age {
//    if (age < 16 || age > 25) {
//        return;
//    }
//    else {
//        _age = age;
//    }
//}
//
//- (void) setScore:(float)score {
//    if (score < 1 || score > 100) {
//        return;
//    }
//    else {
//        _score = score;
//    }
//}

- (void) printStudent {
    NSLog(@"姓名:%@ ID:%@ 年龄:%d 成绩:%f 年级:%d", self.nameString, self.ID, self.age, self.score, self.grade);
}

@end
