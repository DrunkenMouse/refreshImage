//
//  ShowImage.m
//  逐层刷新图片
//
//  Created by 王奥东 on 16/11/25.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ShowImage.h"

@implementation ShowImage {
    
    int _noewHeight;
    
    BOOL _isAdding;//是否在动画中
    NSTimer * _timer;
    CALayer * _myLayer;
    UIImage * _img;//当前动画的图片
    
}

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _noewHeight = 0;
        self.frame = frame;
        _isAdding = NO;
    }
    return self;
}

-(void)setImage:(UIImage *)image {
    
    if (_isAdding) {
        [_timer invalidate];
        [_myLayer removeFromSuperlayer];
        _myLayer = nil;
        _isAdding = NO;
        _noewHeight = 0;
        //动画中切换图片，就立即更换旧图开启新图的动画方式
        [super setImage:_img];
    }
    _img = image;
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _noewHeight);
    layer.contents = (id)[self fitImageSize:image].CGImage;
    CGAffineTransform trans = CGAffineTransformMakeScale(1, -1);
    [layer setAffineTransform:trans];
    layer.masksToBounds = YES;
    
    
    //CGAffineTransform
    //图层对齐方式
    //底部”总是意味着“最小Y”和“顶部” 始终表示“最大Y”。
    layer.contentsGravity = kCAGravityTop;
    
    _myLayer = layer;
    [self.layer addSublayer:_myLayer];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(addFrameHeight) userInfo:nil repeats:YES];
    [_timer fire];
    _isAdding = YES;
    
}


#pragma mark - 将图片绘制成当前imageView的大小
-(UIImage *)fitImageSize:(UIImage *)image{
    
    CGRect drawRect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    
    UIGraphicsBeginImageContext(drawRect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, drawRect, image.CGImage);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    
    UIGraphicsEndImageContext();
    
    return img;
}

#pragma mark - 计时器增加高度执行动画显示
-(void)addFrameHeight {
    
    if (self.superview) {
        _noewHeight += 5;
        _myLayer.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _noewHeight);
        if (_noewHeight >= self.frame.size.height) {
            [_timer invalidate];
            [super setImage:_img];
            [_myLayer removeFromSuperlayer];
            _myLayer = nil;
            _noewHeight = 0;
            _isAdding = NO;
        }
    }
    
}




@end
