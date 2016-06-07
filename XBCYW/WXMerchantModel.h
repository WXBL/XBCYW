//
//  WXMerchantModel.h
//  ZGNCDSW
//
//  Created by Macx on 16/4/26.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXMerchantModel : NSObject
@property(strong,nonatomic)NSString *Merchant_ID;
@property(strong,nonatomic)NSString *Merchant_Name;
@property(strong,nonatomic)NSString *Merchants_Tell;
@property(strong,nonatomic)NSString *Merchants_Adress;
@property(strong,nonatomic)NSString *Merchants_Introduce;
@property(strong,nonatomic)NSString *Longitude;
@property(strong,nonatomic)NSString *Latitude;
@property(strong,nonatomic)NSString *Note;

-(id)getMerchantDataWithDictionaryWithJSON:(NSDictionary *)dict;
-(id)getMerchantListWithArrayJSON:(NSArray *)array;
@end
