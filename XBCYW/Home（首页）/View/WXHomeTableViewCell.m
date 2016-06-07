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
    UIView *cellView1 = [[UIView alloc]init];
    
    cellView1.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/2);
    cellView1.backgroundColor = [UIColor whiteColor];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
