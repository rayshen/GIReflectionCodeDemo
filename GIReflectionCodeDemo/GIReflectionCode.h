//
//  GIReflectionCode.h
//  JsonToObject
//
//  Created by shen on 15/12/29.
//  Copyright © 2015年 shen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GIReflectionCode : NSObject
//序列化函数
+ (NSDictionary*)encode2DicFromObj:(id)obj;
+ (NSData *)encode2DataFromObj:(id)obj;
+ (NSString *)encode2JsonStrFromObj:(id)obj;
@end
