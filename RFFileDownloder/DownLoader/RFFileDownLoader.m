//
//  RQFileDownLoader.m
//  RFFileDownloder
//
//  Created by 冯延强 on 2017/4/5.
//  Copyright © 2017年 RQFeng. All rights reserved.
//

#import "RFFileDownLoader.h"
#import "RFFileDownLoaderProtocol.h"


@interface RFFileDownLoader ()

@property (nonatomic, strong) dispatch_semaphore_t semaphore;
// 任务数组
@property (nonatomic, strong) NSMutableArray<id<RFFileDownLoaderProtocol>> *taskArray;
@property (nonatomic, assign) BOOL haveTaskDownLoad; // 是否有任务正在下载

@property (nonatomic, strong) Class operationClass;

@property (strong, nonatomic) NSOperationQueue *downloadQueue;

@end

@implementation RFFileDownLoader


+(RFFileDownLoader *)shareFileDownLoader
{
    static RFFileDownLoader *downLoder = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downLoder = [self new];
        
    });
    return downLoder;
}

-(instancetype)init
{
    if (self = [super init]) {
        _macCurrentDownder = 2; // 最大并发数
        _downloadQueue = [NSOperationQueue new];
        _downloadQueue.maxConcurrentOperationCount = _macCurrentDownder;
        _automaticStart = YES;  // 是否自动开始下载
        _downloadTimeout = 30 ; // 下载超时的时间
    }
    return self;
}

#pragma mark - 设置下载的最大并发量
-(void)setMacCurrentDownder:(NSInteger)macCurrentDownder
{
    _macCurrentDownder = macCurrentDownder;
    _downloadQueue.maxConcurrentOperationCount = _macCurrentDownder;
}

-(NSUInteger)currentDownloadCount
{
    return self.downloadQueue.operationCount;
}

-(Class)operationClass
{
    return  [NSOperation class];
}

#pragma mark - 添加下载任务到当前下载队列
-(void)addDownLoadTaskWith:(id<RFFileDownLoaderProtocol>)taskModel
{
//    @synchronized (self.taskArray) {
//        [self.taskArray addObject:taskModel];
//    }
    [_downloadQueue addOperationWithBlock:^{
        
    }];
    
    
    if (!_haveTaskDownLoad && _automaticStart) { //  如果没有正在下载 开始下载
//        [self downLoadMusicWithTaskArray:self.taskArray];
    }
}


-(void)downLoadMusicWithTaskArray:(NSMutableArray<id<RFFileDownLoaderProtocol>> *)taskArray
{
    
}

- (id)downloadFileWithURL:(NSURL *)url options:(NSOperation *)options progress:(RFFileDownloaderProgressBlock)progressBlock completed:(RFFileDownloaderCompletedBlock)completedBlock
{
    __block NSOperation *operation;
    __weak __typeof(self)wself = self;
    NSTimeInterval timeoutInterval = wself.downloadTimeout;
    if (timeoutInterval == 0.0) {
        timeoutInterval = 30;
    }
    
       NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:(options  ? NSURLRequestUseProtocolCachePolicy : NSURLRequestReloadIgnoringLocalCacheData) timeoutInterval:timeoutInterval];
//    if (wself.headersFilter) {        request.allHTTPHeaderFields = wself.headersFilter(url, [wself.HTTPHeaders copy]);
//
//    }
//    else {
//        request.allHTTPHeaderFields = wself.HTTPHeaders;
//    }
    operation = [[NSOperation alloc] init];

    return operation;
}




-(void)downLoder
{
//    NSURLSessionDownloadTask *downloadTsk = [NSURLSessionDownloadTask ]
}





- (void)dealloc {
    [self.downloadQueue cancelAllOperations];
}




@end
