//
//  JKWTableViewCell.m
//  学生管理系统
//
//  Created by 姜凯文 on 2018/8/8.
//  Copyright © 2018年 姜凯文. All rights reserved.
//

#import "JKWTableViewCell.h"

@implementation JKWTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nameLabel];
        
        self.idLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_idLabel];
        
        self.gradeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_gradeLabel];
        
        self.ageLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_ageLabel];
        
        self.scoreLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_scoreLabel];
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    _nameLabel.frame = CGRectMake(20, 10, 55, 30);
    
    _idLabel.frame = CGRectMake(95, 10, 90, 30);
    
    _gradeLabel.frame = CGRectMake(205, 10, 20, 30);
    
    _ageLabel.frame = CGRectMake(255, 10, 45, 30);
    
    _scoreLabel.frame = CGRectMake(320, 10, 55, 30);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
