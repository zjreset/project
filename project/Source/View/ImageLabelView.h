//
//  ImageLabelView.h
//  project
//
//  Created by runes on 13-1-30.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import <Three20UI/Three20UI.h>

@interface ImageLabelView : TTView
{
    TTImageView *_imageView;
    UILabel *_label;
    NSString *_URL;
}
- (id)initWith:(NSString *)title imageURL:(NSString *)imageURL toURL:(NSString *)toURL frame:(CGRect) _rect;

@end
