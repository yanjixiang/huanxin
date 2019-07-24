//
//  YzTableViewCell.h
//  chat
//
//  Created by 闫继祥 on 2018/8/6.
//  Copyright © 2018年 闫继祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YzTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView *image;
@property (nonatomic,strong)UILabel *name;
@property (nonatomic,strong)UILabel *detail;
@property (nonatomic,strong)UIButton *agree;
@property (nonatomic,strong)UIButton *disAgree;
@property(nonatomic, strong)UIView *line;
@end
