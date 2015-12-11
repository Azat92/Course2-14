//
//  ViewController.m
//  Lesson15
//
//  Created by Azat Almeev on 11.12.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import "PrimesViewController.h"
#import "SimplesWorker.h"

@interface PrimesViewController ()
@property (nonatomic, readonly) SimplesWorker *simplesWorker;
@end

@implementation PrimesViewController
@synthesize simplesWorker = _simplesWorker;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(reloadTable) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
//    [timer invalidate];
    
//    __weak typeof(self) self_ = self;
//    [[NSNotificationCenter defaultCenter] addObserverForName:SimplesWorkerProcessNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
//        [self_.tableView reloadData];
//    }];
}

- (void)reloadTable {
    [self.tableView reloadData];
}

//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

- (SimplesWorker *)simplesWorker {
    if (!_simplesWorker)
        _simplesWorker = [SimplesWorker new];
    return _simplesWorker;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    NSNumber *result = [self.simplesWorker primesSumWithLimit:indexPath.row * 1000];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", result];
    return cell;
}

@end
