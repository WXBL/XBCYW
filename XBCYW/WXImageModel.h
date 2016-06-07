//
//  WXImageModel.h
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/5/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXImageModel : NSObject
@property(strong,nonatomic)NSString *Image_ID;
@property(strong,nonatomic)NSString *Image_ur;//
@property(strong,nonatomic)NSString *Image_Name;
@property(strong,nonatomic)NSString *News_ID;
@property(strong,nonatomic)NSString *Goods_ID;//邮编

-(id)getImageDataWithDictionaryJSON:(NSDictionary *)dict;
-(id)getImageListDataWithArrayJSON:(NSArray *)array;
@end
