//
//  FrientListTableViewCell.m
//  ZhuoTopSearchrReplacement
//
//  Created by 闫继祥 on 2019/4/29.
//  Copyright © 2019 闫继祥. All rights reserved.
//

#import "FrientListTableViewCell.h"

@implementation FrientListTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameL = [[UILabel alloc] init];
        self.nameL.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.nameL];
        
        self.img = [[UIImageView alloc] init];
        self.img.backgroundColor = [UIColor whiteColor];
        self.img.userInteractionEnabled = YES;
        [self.contentView addSubview:self.img];
        self.img.contentMode=UIViewContentModeScaleAspectFill;
        self.img.clipsToBounds=YES;
        
        self.line = [[UIView alloc] init];
        self.line.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
        [self.contentView addSubview:self.line];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
   
    self.img.frame = CGRectMake(10, 10, 40, 40);
    self.img.layer.cornerRadius = 20;
    
    self.nameL.frame = CGRectMake(self.img.width+self.img.x+15, 0, self.contentView.width-35-self.img.width, self.contentView.height-1.0);
    self.line.frame = CGRectMake(0, self.contentView.height - 1.0, self.contentView.width, 1.0);
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
