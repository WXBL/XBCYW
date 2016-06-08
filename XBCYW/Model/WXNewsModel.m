//
//  WXNewsModel.m
//  ZGNCDSW
//
//  Created by Macx on 16/4/27.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXNewsModel.h"
#import "WXImageModel.h"
@implementation WXNewsModel
-(id)getNewsDataWithDictionaryJSON:(NSDictionary *)dict{
    if (dict) {
        WXNewsModel *model=[[WXNewsModel alloc] init];
        model.News_ID=[((NSNumber *)dict[@"News_ID"]) stringValue];
        model.News_Name=(dict[@"News_Name"]==[NSNull null])?@"":dict[@"News_Name"];
        model.News_Content=(dict[@"News_Content"]==[NSNull null])?@"":dict[@"News_Content"];
        model.News_release_People_=(dict[@"News_release_People_"]==[NSNull null])?@"":dict[@"News_release_People_"];
        model.Release_Time=(dict[@"Release_Time"]==[NSNull null])?@"":dict[@"Release_Time"];
        NSMutableArray *imgArr=(dict[@"NewsImage"]==[NSNull null])?@"":dict[@"NewsImage"];
        model.newsImgArr=[[[WXImageModel alloc] init] getImageListDataWithArrayJSON:imgArr];
        return model;
    }
    return nil;
}
-(id)getNewsListWithArrayJSON:(NSArray *)array{
    if (array) {
        NSMutableArray *data=[NSMutableArray array];
        for (NSDictionary *dic in array) {
            [data addObject:[self getNewsDataWithDictionaryJSON:dic]];
        }
        return data;
    }
    return nil;
}
@end
