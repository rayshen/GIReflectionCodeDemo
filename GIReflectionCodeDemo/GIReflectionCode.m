//
//  GIReflectionCode.m
//  JsonToObject
//
//  Created by shen on 15/12/29.
//  Copyright © 2015年 shen. All rights reserved.
//

#import "GIReflectionCode.h"
#import <objc/runtime.h>
@implementation GIReflectionCode
//序列化函数
+ (NSData *)encode2DataFromObj:(id)obj{
    NSDictionary *jsonDic=[self encode2DicFromObj:obj];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:nil];
    return jsonData;
}

+ (NSString *)encode2JsonStrFromObj:(id)obj{
    NSDictionary *jsonDic=[self encode2DicFromObj:obj];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
}


+ (NSDictionary*)encode2DicFromObj:(id)obj
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);//获得属性列表
    for(int i = 0;i < propsCount; i++)
    {
        objc_property_t prop = props[i];
        
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];//获得属性的名称
        id value = [obj valueForKey:propName];//kvc读值
        if(value == nil)
        {
            value = [NSNull null];
        }
        else
        {
            value = [self getObjectInternal:value];//自定义处理数组，字典，其他类
        }
        [dic setObject:value forKey:propName];
    }
    return dic;
}

+ (id)getObjectInternal:(id)obj
{
    if([obj isKindOfClass:[NSString class]]
       || [obj isKindOfClass:[NSNumber class]]
       || [obj isKindOfClass:[NSNull class]])
    {
        return obj;
    }
    
    if([obj isKindOfClass:[NSArray class]])
    {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++)
        {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    
    if([obj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys)
        {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self encode2DicFromObj:obj];
}
@end
