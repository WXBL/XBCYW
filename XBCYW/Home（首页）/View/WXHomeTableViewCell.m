//
//  WXHomeTableViewCell.m
//  XBCYW
//
//  Created by admin on 16/6/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WXHomeTableViewCell.h"

@implementation WXHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
     
        [self addSubviews];
    }
    return self;
}

-(void)addSubviews{
    UIView *cellView = [[UIView alloc]init];
    
    cellView.frame = CGRectMake(0, 0, screenWidth , 90);
    cellView.backgroundColor = [UIColor whiteColor];
    [self addSubview:cellView];
    
    for (int i =0; i<2; i++) {
        self.image1 = [[UIImageView alloc]initWithFrame:CGRectMake(i*(cellView.frame.size.width/2)+10, 5, cellView.frame.size.width/2 -20, cellView.frame.size.height-5)];
        [self.image1 setImage:[UIImage imageNamed:@"newsImage1.jpg"]];
        self.image1.tag =i+1;
        [cellView addSubview:self.image1];
        
        
        UIView *titleBgView = [[UIView alloc]initWithFrame:CGRectMake(0, self.image1.frame.size.height-20, self.image1.frame.size.width, 20)];
        titleBgView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.6];
        [self.image1 addSubview:titleBgView];
        
        self.titleLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, titleBgView.frame.size.width, 20)];
        self.titleLabel1.textColor = [UIColor whiteColor];
        self.titleLabel1.textAlignment = NSTextAlignmentLeft;
        self.titleLabel1.font = [UIFont systemFontOfSize:12];
        [titleBgView addSubview:self.titleLabel1];
        
        if (self.image1.tag ==1) {
            self.titleLabel1.text = @"asdfasdfa";
        }else{
            self.titleLabel1.text = @"asdfasgrthefgs";
        }
    }
    
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(cellView.frame.size.width/2, 5, 1, self.image1.frame.size.height)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [cellView addSubview:lineView];
    
    self.titleLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(10, cellView.frame.size.height+5,cellView.frame.size.width,30)];
    self.titleLabel2.text = @"sdfasdgasdkj;alskdjf;lajksd;lf";
    self.titleLabel2.textColor = [UIColor blackColor];
    self.titleLabel2.textAlignment = NSTextAlignmentLeft;
    self.titleLabel2.font = [UIFont systemFontOfSize:14];
    [cellView addSubview:self.titleLabel2];
    
    self.image2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titleLabel2.frame), cellView.frame.size.height/2, cellView.frame.size.height/2)];
    [self.image2 setImage:[UIImage imageNamed:@"newsImage1.jpg"]];
    [cellView addSubview:self.image2];
    
    self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.image2.frame)+10, CGRectGetMaxY(self.titleLabel2.frame), cellView.frame.size.width - self.image2.frame.size.width -30, self.image2.frame.size.height)];
    self.detailLabel.text = @"asdfasdgasdgasdgasdgakdjgflakjsdf;ljka;lsjgkdfng.skdnfgksdlfkgjalkdjglsdkfjglsdkfjgsldkfjgslkdjfg;laskdjg;laksjdgl;akjsdg;lkajsldkgja;lksjdglaksjdglsdkl";
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.textColor = [UIColor blackColor];
    self.detailLabel.font = [UIFont systemFontOfSize:14];
    self.detailLabel.textAlignment = NSTextAlignmentLeft;
    [cellView addSubview: self.detailLabel];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
