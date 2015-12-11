//
//  SimplesWorker.m
//  Lesson15
//
//  Created by Azat Almeev on 11.12.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import "SimplesWorker.h"
#import <UIKit/UIKit.h>

@interface SimplesWorker ()
@property (nonatomic, readonly) NSCache *cache;
@property (nonatomic, readonly) NSMutableArray *process;
@property (nonatomic, readonly) NSOperationQueue *queue;
@end

@implementation SimplesWorker
@synthesize cache = _cache;
@synthesize process = _process;
@synthesize queue = _queue;

- (instancetype)init {
    self = [super init];
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [self.cache removeAllObjects];
    }];
    return self;
}

- (NSCache *)cache {
    if (!_cache)
        _cache = [NSCache new];
    return _cache;
}

- (NSMutableArray *)process {
    if (!_process)
        _process = [NSMutableArray new];
    return _process;
}

- (NSOperationQueue *)queue {
    if (!_queue) {
        _queue = [NSOperationQueue new];
    }
    return _queue;
}

- (BOOL)isPrime:(NSInteger)number {
    if (number < 2)
        return NO;
    for (NSInteger i = 2; i < sqrt(number); i++)
        if (number % i == 0)
            return NO;
    return YES;
}

- (NSArray *)primeWithLimit:(NSInteger)count {
    NSMutableArray *result = [NSMutableArray new];
    for (NSInteger i = 0; i < count; i++) {
        for (NSInteger j = [[result lastObject] integerValue] + 1; YES; j++)
            if ([self isPrime:j]) {
                [result addObject:@(j)];
                break;
            }
    }
    return result.copy;
}

- (NSNumber *)primesSumWithLimit:(NSInteger)count {
    NSNumber *result = [self.cache objectForKey:@(count)];
    if (!result && ![self.process containsObject:@(count)]) {
        [self.process addObject:@(count)];

        //NSOperationQueue
        [self.queue addOperationWithBlock:^{
            NSArray *primes = [self primeWithLimit:count];
            NSNumber *result = [primes valueForKeyPath:@"@sum.self"];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                completion(result);
               [[NSNotificationCenter defaultCenter] postNotificationName:SimplesWorkerProcessNotification object:self];
                [self.process removeObject:@(count)];
            }];
//            @synchronized(self.process) {
//                [self.process removeObject:@(count)];
//            }
            [self.cache setObject:result forKey:@(count)];
        }];
        
        //Grand Central Dispatch
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            NSArray *primes = [self primeWithLimit:count];
//            NSNumber *result = [primes valueForKeyPath:@"@sum.self"];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                completion(result);
//            });
//            @synchronized(self.process) {
//                [self.process removeObject:@(count)];
//            }
//            [self.cache setObject:result forKey:@(count)];
//        });
    }
    return result;
}

@end
