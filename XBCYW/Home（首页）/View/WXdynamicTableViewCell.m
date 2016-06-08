//
//  WXdynamicTableViewCell.m
//  XBCYW
//
//  Created by admin on 16/6/8.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WXdynamicTableViewCell.h"

@implementation WXdynamicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
    }
    return self;
}

-(void)addSubviews{
    self.image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
    [self.image setImage:[UIImage imageNamed:@"newsImage1.jpg"]];
    [self addSubview:self.image];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.image.frame)+10, self.image.frame.origin.y, screenWidth-CGRectGetMaxX(self.image.frame)-20, 30)];
    self.titleLabel.text = @"asdkjfaksd";
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.titleLabel];
    
    
    self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.image.frame)+10, CGRectGetMaxY(self.titleLabel.frame), screenWidth-CGRectGetMaxX(self.image.frame)-20, 60)];
    self.detailLabel.text = @"askdjfakjsdfjas;ldkjf;lajkdflakjsdgl;kajsdlgkjal;sdkjfl;askdfljaksd";
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.textColor = [UIColor blackColor];
    self.detailLabel.textAlignment = NSTextAlignmentLeft;
    self.detailLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.detailLabel];
    
    
}


-(void)setNewsModel:(WXNewsModel *)newsModel{
    _newsModel = newsModel;
    
    self.titleLabel.text = newsModel.News_Name;
}

-(void)setImageModel:(WXImageModel *)imageModel{
    _imageModel = imageModel;
    
    [self.image setImage:[UIImage imageNamed:imageModel.Image_ur]];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
