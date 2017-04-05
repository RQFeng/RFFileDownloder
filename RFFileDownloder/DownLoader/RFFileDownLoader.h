//
//  RQFileDownLoader.h
//  RFFileDownloder
//
//  Created by 冯延强 on 2017/4/5.
//  Copyright © 2017年 RQFeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^RFFileDownloaderProgressBlock)(NSInteger receivedSize, NSInteger expectedSize);

typedef void(^RFFileDownloaderCompletedBlock)(UIImage *image, NSData *data, NSError *error, BOOL finished);

@interface RFFileDownLoader : NSObject


// 设置最大并发数 默认是 2
@property (nonatomic,assign) NSInteger macCurrentDownder;


@property (nonatomic,readonly) NSUInteger currentDownloadCount;

// 是否自动开始下载 默认是YES
@property (nonatomic,assign) BOOL automaticStart;

@property (nonatomic, assign) NSInteger downloadTimeout;
/**
 大文件下载类

 @return 大文件下载单利
 */
+(instancetype)shareFileDownLoader;
@end
