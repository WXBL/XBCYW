//
//  WXMerchantModel.m
//  ZGNCDSW
//
//  Created by Macx on 16/4/26.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXMerchantModel.h"

@implementation WXMerchantModel
-(id)getMerchantDataWithDictionaryWithJSON:(NSDictionary *)dict{
    if (dict) {
        WXMerchantModel *model=[[WXMerchantModel alloc] init];
        model.Merchant_ID=[((NSNumber *)dict[@"Merchant_ID"]) stringValue];
        model.Merchant_Name=(dict[@"Merchant_Name"]==[NSNull null])?@"":dict[@"Merchant_Name"];
        model.Merchants_Tell=(dict[@"Merchants_Tell"]==[NSNull null])?@"":dict[@"Merchants_Tell"];
        model.Merchants_Adress=(dict[@"Merchants_Adress"]==[NSNull null])?@"":dict[@"Merchants_Adress"];
        model.Merchants_Introduce=(dict[@"Merchants_Introduce"]==[NSNull null])?@"":dict[@"Merchants_Introduce"];
        model.Longitude=(dict[@"Longitude"]==[NSNull null])?@"":dict[@"Longitude"];
        model.Latitude=(dict[@"Latitude"]==[NSNull null])?@"":dict[@"Latitude"];
        model.Note=(dict[@"Note"]==[NSNull null])?@"":dict[@"Note"];
        return model;
    }
    return nil;
}
-(id)getMerchantListWithArrayJSON:(NSArray *)array{
    if (array) {
        NSMutableArray *data=[NSMutableArray array];
        for (NSDictionary *dic in array) {
            [data addObject:[self getMerchantDataWithDictionaryWithJSON:dic]];
        }
        return data;
    }
    return nil;
}
@end
