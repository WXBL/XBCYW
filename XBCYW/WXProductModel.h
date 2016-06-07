//
//  WXProductModel.h
//  ZGNCDSW
//
//  Created by Macx on 16/4/27.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXMerchantModel.h"
#import "WXTypeModel.h"
@interface WXProductModel : NSObject
@property(strong,nonatomic)NSString *Goods_ID;
@property(strong,nonatomic)NSString *Goods_Name;
@property(strong,nonatomic)NSString *Goods_Price;
@property(strong,nonatomic)NSString *Goods_Introduce;
@property(strong,nonatomic)NSString *Merchants_ID;
@property(strong,nonatomic)NSString *Goods_Time;
@property(strong,nonatomic)NSString *Goods_Type_ID;
@property(strong,nonatomic)WXMerchantModel *Merchant;
@property(strong,nonatomic)WXTypeModel *Goods_Type;
@property(strong,nonatomic)NSString *Goods_TypeName;
@property(strong,nonatomic)NSMutableArray *productImgArr;
@property(strong,nonatomic)NSString *Note;

-(id)getProductDataWithDictionaryJSON:(NSDictionary *)dict;
-(id)getProductListWithArrayJSON:(NSArray *)array;
@end
