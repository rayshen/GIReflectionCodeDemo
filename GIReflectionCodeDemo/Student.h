//
//  Student.h
//  JsonToObject
//
//  Created by shen on 15/12/29.
//  Copyright © 2015年 shen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Teacher.h"
@interface Student : NSObject

@property (copy) NSString *stuName;
@property (strong) NSMutableArray *teachersArray;

@end
