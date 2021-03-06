//
//  WXImageModel.m
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/5/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXImageModel.h"

@implementation WXImageModel
-(id)getImageDataWithDictionaryJSON:(NSDictionary *)dict{
    if(dict){
        WXImageModel *model=[[WXImageModel alloc] init];
        model.Image_ID=[((NSNumber *)dict[@"Image_ID"]) stringValue];
        model.Image_ur=(dict[@"Image_ur"]==[NSNull null])?@"":dict[@"Image_ur"];
        model.Image_Name=(dict[@"Image_Name"]==[NSNull null])?@"":dict[@"Image_Name"];
        model.News_ID=[((NSNumber *)dict[@"News_ID"]) stringValue];
        model.Goods_ID=[((NSNumber *)dict[@"Goods_ID"]) stringValue];
        return model;
    }
    return nil;
}
-(id)getImageListDataWithArrayJSON:(NSArray *)array{
    if (array) {
        NSMutableArray *data=[NSMutableArray array];
        for (NSDictionary *dic in array) {
            [data addObject:[self getImageDataWithDictionaryJSON:dic]];
        }
        return data;
    }
    return nil;
}
@end
