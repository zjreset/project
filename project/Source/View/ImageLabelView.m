//
//  ImageLabelView.m
//  project
//
//  Created by runes on 13-1-30.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import "ImageLabelView.h"

@implementation ImageLabelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWith:(NSString *)title imageURL:(NSString *)imageURL toURL:(NSString *)toURL frame:(CGRect) _rect
{
    self = [super init];
    if (self) {
        self.frame = _rect;
        //        NSLog(@"%f--++++--%f",self.view.frame.origin.x,self.view.bounds.origin.x);
        _URL = toURL;
        int labelheight = 25;
        _imageView = [[TTImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-labelheight)];
        _imageView.urlPath = imageURL;
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.defaultImage = nil;
        [_imageView setUserInteractionEnabled:true];
        UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToURL)];
        singleTapGestureRecognizer.numberOfTouchesRequired = 1;    //触摸点个数
        singleTapGestureRecognizer.numberOfTapsRequired = 1;
        [_imageView addGestureRecognizer:singleTapGestureRecognizer];
        _imageView.layer.cornerRadius = 6;
        _imageView.layer.masksToBounds = YES;
        [self addSubview:_imageView];
        TT_RELEASE_SAFELY(_imageView);
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-labelheight, self.frame.size.width, labelheight)];
        _label.textAlignment  = NSTextAlignmentCenter;
        _label.text = title;
        _label.font = [UIFont systemFontOfSize:14];
        [self addSubview:_label];
        TT_RELEASE_SAFELY(_label);
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//        [imageView setImage:[UIImage imageNamed:@"Default.png"]];
//        imageView.alpha = 0.1;
//        [self addSubview:imageView];
        //[[self layer] setBorderWidth:1.0];//画线的宽度
        //[[self layer] setBorderColor:[UIColor blackColor].CGColor];//颜色
    }
    return self;
}

- (void) goToURL
{
    TTNavigator* navigator = [TTNavigator navigator];
    //切换至登录成功页面
    [navigator openURLAction:[[TTURLAction actionWithURLPath:_URL] applyAnimated:YES]];
}

@end
