//
//  HWLoadMoreFooter.m
//  黑马微博2期
//
//  Created by apple on 14-10-14.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "WXLoadMoreFooter.h"

@implementation WXLoadMoreFooter


+ (instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"WXLoadMoreFooter" owner:nil options:nil] lastObject];
}

@end
