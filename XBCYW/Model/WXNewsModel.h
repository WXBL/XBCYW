//
//  WXNewsModel.h
//  ZGNCDSW
//
//  Created by Macx on 16/4/27.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXNewsModel : NSObject
@property(strong,nonatomic)NSString *News_ID;
@property(strong,nonatomic)NSString *News_Name;
@property(strong,nonatomic)NSString *News_Content;
@property(strong,nonatomic)NSString *News_release_People_;
@property(strong,nonatomic)NSString *Release_Time;
@property(strong,nonatomic)NSMutableArray *newsImgArr;
@property(nonatomic,strong)NSString *url;
-(id)getNewsDataWithDictionaryJSON:(NSDictionary *)dict;
-(id)getNewsListWithArrayJSON:(NSArray *)array;
@end
