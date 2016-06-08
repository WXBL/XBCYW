//
//  WXdynamicTableViewCell.h
//  XBCYW
//
//  Created by admin on 16/6/8.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXNewsModel.h"
#import "WXImageModel.h"
@interface WXdynamicTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *image;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *detailLabel;

@property (nonatomic,strong)WXNewsModel *newsModel;
@property (nonatomic,strong)WXImageModel *imageModel;
@end
