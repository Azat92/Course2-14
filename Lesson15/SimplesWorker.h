//
//  SimplesWorker.h
//  Lesson15
//
//  Created by Azat Almeev on 11.12.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SimplesWorkerProcessNotification @"SimplesWorkerProcessNotification" 

@interface SimplesWorker : NSObject
- (NSNumber *)primesSumWithLimit:(NSInteger)count;
@end
