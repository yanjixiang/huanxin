//
//  YzTableViewCell.m
//  chat
//
//  Created by 闫继祥 on 2018/8/6.
//  Copyright © 2018年 闫继祥. All rights reserved.
//

#import "YzTableViewCell.h"

@implementation YzTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
        //标题
        self.image = [[UIImageView alloc]init];
        self.image.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.image];
        //        self.titleL.textColor = [UIColor lightGrayColor];
        
        
        //价格
        self.name = [[UILabel alloc]init];
//        self.name.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.name];
        
        
        //原价
        self.detail = [[UILabel alloc]init];
        //        self.oldPriceL.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.detail];
        self.detail.font = [UIFont systemFontOfSize:13];
        self.detail.textColor = [UIColor lightGrayColor];

        self.agree = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.agree setTitle:@"同意" forState:(UIControlStateNormal)];
        self.agree.backgroundColor = [UIColor colorWithHexString:@"#1296db"];
        [self.agree setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [self.contentView addSubview:self.agree];
        self.agree.layer.cornerRadius = 3.0;
        self.agree.clipsToBounds = YES;

        
        self.disAgree = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.disAgree setTitle:@"拒绝" forState:(UIControlStateNormal)];
        self.disAgree.backgroundColor = [UIColor lightGrayColor];
        [self.disAgree setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [self.contentView addSubview:self.disAgree];
        self.disAgree.layer.cornerRadius = 3.0;
        self.disAgree.clipsToBounds = YES;
        
        self.line = [[UIView alloc] init];
        self.line.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
        [self.contentView addSubview:self.line];
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.image.frame = CGRectMake(10, 10, 40 , 40);
    
    self.name.frame = CGRectMake(60, 10 , (self.contentView.frame.size.width-125-40), 20);
    self.detail.frame = CGRectMake(60, 35 , (self.contentView.frame.size.width-125-40), 15);
    self.disAgree.frame = CGRectMake(self.contentView.frame.size.width-115, 15, 50, 30);
    self.agree.frame = CGRectMake(self.contentView.frame.size.width-60, 15, 50, 30);
    
    self.line.frame = CGRectMake(0, self.contentView.height-1.0, self.contentView.width, 1.0);
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
