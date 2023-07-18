//
//  TorchModule.h
//  DysarthriaChecker
//
//  Created by 하창진 on 7/3/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TorchModule : NSObject

- (nullable instancetype) initWithFileAtPath : (NSString*)filePath
NS_SWIFT_NAME(init(fileAtPath:)) NS_DESIGNATED_INITIALIZER;
+ (instancetype) new NS_UNAVAILABLE;
- (instancetype) init NS_UNAVAILABLE;
- (nullable NSArray<NSNumber*>*)predictAudio:(void*)audioBuffer :(int)outputSize NS_SWIFT_NAME(predict(audio:outputSize:));


@end

NS_ASSUME_NONNULL_END
