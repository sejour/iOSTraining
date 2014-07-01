//
//  TestQueue.m
//  BasicObjectiveC
//
//  Created by Shuka Takakuma on 2014/06/28.
//  Copyright (c) 2014年 武田 祐一. All rights reserved.
//

#import "TestQueue.h"

@interface TestQueue ()
{
    // データ列
    NSMutableArray *data;
}
@end

@implementation TestQueue

- (id)init
{
    self = [super init];
    
    if (self) {
        data = [[NSMutableArray alloc] initWithCapacity:8];
    }
    
    return self;
}

/** エンキュー **/
- (void)enqueue:(id)object
{
    [data addObject:object];
}

/** デキュー **/
- (id)dequeue
{
    // データが一つも存在しなければnilを返す
    if (data.count < 1) {
        return nil;
    }
    
    id first = data.firstObject;
    
    [data removeObjectAtIndex:0];
    
    return first;
}

/** キューのサイズ **/
- (NSInteger)size
{
    return data.count;
}

@end
