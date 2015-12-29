//
//  ViewController.m
//  GIReflectionCodeDemo
//
//  Created by shen on 15/12/29.
//  Copyright © 2015年 shen. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import "GIReflectionCode.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //序列化成JsonDic、JsonData、JsonStr的Demo
    Student *newStu=[[Student alloc]init];
    newStu.stuName=@"Shen";
    Teacher *tea1=[[Teacher alloc]init];
    tea1.teaName=@"Tea11";
    Teacher *tea2=[[Teacher alloc]init];
    tea2.teaName=@"Tea22";
    newStu.teachersArray=[[NSMutableArray alloc]init];
    [newStu.teachersArray addObject:tea1];
    [newStu.teachersArray addObject:tea2];
    
    //序列化
    NSDictionary *jsonDic=[GIReflectionCode encode2DicFromObj:newStu];
    NSLog(@"jsonDic:%@",jsonDic);
    NSData *jsonData = [GIReflectionCode encode2DataFromObj:newStu];
    NSString *jsonString = [GIReflectionCode encode2JsonStrFromObj:newStu];
    NSLog(@"jsonStr:%@",jsonString);
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
