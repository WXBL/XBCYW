//
//  WXHomeTableViewCell.m
//  XBCYW
//
//  Created by admin on 16/6/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WXHomeTableViewCell.h"
#import "UILabel+WXStringFrame.h"

@implementation WXHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
     
        [self addSubviews];
        
        //点击cell时不变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)addSubviews{
//    UIView *cellView = [[UIView alloc]init];
//    
//    cellView.frame = CGRectMake(0, 0, screenWidth , 180);
//    cellView.backgroundColor = [UIColor whiteColor];
//    [self addSubview:cellView];
    self.frame = CGRectMake(0, 0, screenWidth, 180);
    
    for (int i =0; i<2; i++) {
        self.newsBtn = [[UIButton alloc]initWithFrame:CGRectMake(i*(self.frame.size.width/2)+10, 5, self.frame.size.width/2 -20, self.frame.size.height/2-5)];
        [self.newsBtn setImage:[UIImage imageNamed:@"newsImage1.jpg"] forState:UIControlStateNormal];
        self.newsBtn.tag =i+1;
        [self addSubview:self.newsBtn];
        
        
        UIView *titleBgView = [[UIView alloc]initWithFrame:CGRectMake(0, self.newsBtn.frame.size.height-20, self.newsBtn.frame.size.width, 20)];
        titleBgView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.6];
        [self.newsBtn addSubview:titleBgView];
        
        self.titleLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, titleBgView.frame.size.width, 20)];
        self.titleLabel1.textColor = [UIColor whiteColor];
        self.titleLabel1.textAlignment = NSTextAlignmentLeft;
        self.titleLabel1.font = [UIFont systemFontOfSize:12];
        [titleBgView addSubview:self.titleLabel1];
//        
        if (self.newsBtn.tag ==1) {
            self.titleLabel1.text = @"asdfasdfa";
                    }else{
            self.titleLabel1.text = @"asdfasgrthefgs";
        }
        [self.newsBtn addTarget:self action:@selector(ClickNewsBtn:) forControlEvents:UIControlEventTouchUpInside];


    }
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width/2, 5, 1, self.newsBtn.frame.size.height)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self addSubview:lineView];
    
    self.newsBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.newsBtn2.frame = CGRectMake(0, self.frame.size.height/2, self.frame.size.width, self.frame.size.height/2);
    [self.newsBtn2 addTarget:self action:@selector(ClickNewsBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.newsBtn2];
    
    self.titleLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0,self.frame.size.width,20)];
    self.titleLabel2.text = @"sdfasdgasdkj;alskdjf;lajksd;lf";
    self.titleLabel2.textColor = [UIColor blackColor];
    self.titleLabel2.textAlignment = NSTextAlignmentLeft;
    self.titleLabel2.font = [UIFont systemFontOfSize:14];
    [self.newsBtn2 addSubview:self.titleLabel2];
    
    self.image = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titleLabel2.frame), self.newsBtn2.frame.size.height-30, self.newsBtn2.frame.size.height-30)];
    [self.image setImage:[UIImage imageNamed:@"newsImage1.jpg"]];
    [self.newsBtn2 addSubview:self.image];
 

    self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.image.frame)+10, CGRectGetMaxY(self.titleLabel2.frame), self.newsBtn2.frame.size.width - self.image.frame.size.width -30, self.image.frame.size.height)];
    self.detailLabel.text = @"asdfasdgasdgasdgasdgakdjgflakjsdf;ljka;fgfdgdfgdfgdfgfdglsjgkdfng.skdnfgksdlfkgjalkdjglsdkfjglsdkfjgsldkfjgslkdjfg;laskdjg;laksjdgl;akjsdg;lkajsldkgja;lksjdglaksjdglsdkl";
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.textColor = [UIColor blackColor];
    self.detailLabel.font = [UIFont systemFontOfSize:14];
    
    CGSize size=[self.detailLabel boundingRectWithSize:CGSizeMake( self.newsBtn2.frame.size.width - self.image.frame.size.width -30, 0)];
     self.detailLabel.frame=CGRectMake(CGRectGetMaxX(self.image.frame)+10,CGRectGetMaxY(self.titleLabel2.frame),size.width, size.height);

    [self.newsBtn2 addSubview: self.detailLabel];
    
}

-(void)ClickNewsBtn:(UIButton *)button{
    if ([_delegate respondsToSelector:@selector(WXHomeTableViewCell:didSelectButton:)]) {
        [_delegate WXHomeTableViewCell:self didSelectButton:button];
    }
    
}

//获取数据
//-(void)setNewsModel:(WXNewsModel *)newsModel{
//    _newsModel = newsModel;
//    
//    
//    if (self.image1.tag ==1) {
//        self.titleLabel1.text = newsModel.News_Name;
//    }else{
//        self.titleLabel1.text = @"asdfasgrthefgs";
//    }
//    
//}
//
//-(void)setImageModel:(WXImageModel *)imageModel{
//    _imageModel = imageModel;
//    [self.image1 setImage:[UIImage imageNamed:imageModel.Image_ur]];
//    [self.image2 setImage:[UIImage imageNamed:imageModel.Image_ur]];
//
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
