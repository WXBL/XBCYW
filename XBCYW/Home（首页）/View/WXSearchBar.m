//
//  WXSearchBar.m
//  XBCYW
//
//  Created by admin on 16/6/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WXSearchBar.h"
#import "UIView+Extension.h"
#import "Xbcyw.pch"
@implementation WXSearchBar


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:14];
        self.placeholder = @"请输入关键字查找";
        self.backgroundColor = [UIColor whiteColor];
        [self.layer setCornerRadius:5.0];
        self.borderStyle = UITextBorderStyleRoundedRect;
        [self.layer setBorderWidth:1];
        [self.layer setBorderColor:[[UIColor colorWithWhite:0.9 alpha:1]CGColor]];
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.keyboardType = UIKeyboardTypeDefault;
        self.tintColor = [UIColor colorWithRed:0.3 green:0.7 blue:0.3 alpha:1];
        
        UIImageView *searchIcon = [[UIImageView alloc]init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.width = 30;
        searchIcon.height = 30;
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    
    return self;
}

-(instancetype)init{
    
    CGFloat width = WXMainScreenBounds.size.width - 110;
    CGFloat height = 30;
    CGFloat X = screenWidth - width -20;
    CGFloat Y = 7;
    CGRect frame = CGRectMake(X, Y, width, height);
    return [self initWithFrame:frame];
}

+(instancetype)searchBar{
    return [[self alloc]init];
}

@end
