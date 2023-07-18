//
//  TorchModule.m
//  DysarthriaChecker
//
//  Created by 하창진 on 7/3/23.
//

#import "TorchModule.h"
#import <Libtorch-Lite.h>

@implementation TorchModule {
@protected
    torch::jit::mobile::Module _impl;
}

- (nullable instancetype)initWithFileAtPath:(NSString*)filePath {
  self = [super init];
  if (self) {
    try {
      _impl = torch::jit::_load_for_mobile(filePath.UTF8String);
    } catch (const std::exception& exception) {
      NSLog(@"%s", exception.what());
      return nil;
    }
  }
  return self;
}

-(NSArray<NSNumber*>*)predictAudio:(void*)audioBuffer : (int)outputSize {
    try{
        at::Tensor tensor = torch::from_blob(audioBuffer, {1, 3, 28, 28}, at::kFloat);
        c10::InferenceMode mode;

        auto outputTensor = _impl.forward({tensor}).toTensor();
        float* floatBuffer = outputTensor.data_ptr<float>();
        
        if(!floatBuffer){
            return nil;
        }
        
        NSMutableArray* results = [[NSMutableArray alloc] init];
        
        for(int i = 0; i < outputSize; i++){
            [results addObject:@(floatBuffer[i])];
        }
        
        return [results copy];
        
    } catch(const std::exception& exception){
        NSLog(@"%s", exception.what());
    }
    
    return nil;
}

@end
