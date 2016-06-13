//
//  WXProductModel.m
//  ZGNCDSW
//
//  Created by Macx on 16/4/27.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXProductModel.h"
#import "WXTypeModel.h"
#import "WXImageModel.h"
#import "WXMerchantModel.h"
@implementation WXProductModel

-(id)getProductDataWithDictionaryJSON:(NSDictionary *)dict
{
    if (dict) {
        WXProductModel *model=[[WXProductModel alloc] init];
        model.Goods_ID=[((NSNumber *)dict[@"Goods_ID"]) stringValue];
        model.Goods_Name=(dict[@"Goods_Name"]==[NSNull null])?@"":dict[@"Goods_Name"];
        model.Goods_Price=[((NSNumber *)dict[@"Goods_Price"]) stringValue];
        NSMutableDictionary *merchantDic=(dict[@"Merchant_ID"]==[NSNull null])?@"":dict[@"Merchant_ID"];
        model.Merchant=[[[WXMerchantModel alloc] init] getMerchantDataWithDictionaryWithJSON:merchantDic];
        model.Goods_Introduce=(dict[@"Goods_Introduce"]==[NSNull null])?@"":dict[@"Goods_Introduce"];
        model.Goods_Time=(dict[@"Goods_Time"]==[NSNull null])?@"":dict[@"Goods_Time"];
        model.Note=(dict[@"Note"]==[NSNull null])?@"":dict[@"Note"];
        NSMutableDictionary *typeDIct=(dict[@"Goods_Tyoe_ID"]==[NSNull null]?@"":dict[@"Goods_Tyoe_ID"]);
        model.Goods_Type=[[[WXTypeModel alloc] init] getTypeDataWithDictionaryWithJSON:typeDIct];
        model.Goods_TypeName=model.Goods_Type.Type_Name;
        NSMutableArray *imageArr=(dict[@"Goods_Image"]==[NSNull null]?@"":dict[@"Goods_Image"]);
        model.productImgArr=[[[WXImageModel alloc]init]getImageListDataWithArrayJSON:imageArr];
        model.url=(dict[@"url"]==[NSNull null])?@"":dict[@"url"];
        return model;
    }
    
    return  nil;
}
-(id)getProductListWithArrayJSON:(NSArray *)array
{
    if (array) {
        NSMutableArray *data=[NSMutableArray array];
        for (NSDictionary *dic in array) {
            [data addObject:[self getProductDataWithDictionaryJSON:dic]];
        }
        return data;
    }
    return nil;
}
@end
