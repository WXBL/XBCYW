//
//  WXHomeTableViewCell.h
//  XBCYW
//
//  Created by admin on 16/6/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXNewsModel.h"
#import "WXImageModel.h"

@protocol WXHomeTableViewCellDelegate <NSObject>


@end
@interface WXHomeTableViewCell : UITableViewCell

@property (nonatomic,weak)id<WXHomeTableViewCellDelegate>delegate;

@property (nonatomic,strong)UIButton *newsBtn;
@property (nonatomic,strong)UIButton *newsBtn2;
@property (nonatomic,strong)UIImageView *image;
@property (nonatomic,strong)UILabel *titleLabel1;
@property (nonatomic,strong)UILabel *titleLabel2;
@property (nonatomic,strong)UILabel *detailLabel;

@property (nonatomic,strong)WXNewsModel *newsModel;
@property (nonatomic,strong)WXImageModel *imageModel;

@end
