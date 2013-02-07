//
//  AutoAdaptedView.m
//  project
//
//  Created by runes on 13-1-23.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import "AutoAdaptedView.h"

@implementation AutoAdaptedView
@synthesize textField=_textField;
static int titleLabelWidth = 90;

- (id)initWithFrame:(CGRect)frame title:(NSString*)_title inputType:(NSInteger)_inputType inputValue:(NSString*)_inputValue
{
    self = [[super initWithFrame:frame] autorelease];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, titleLabelWidth, 30)];
        _titleLabel.text = _title;
        _titleLabel.textAlignment = NSTextAlignmentRight;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_titleLabel];
        switch (_inputType) {
            case InputTypeInput:    //输入框
                _textField = [[UITextField alloc] initWithFrame:CGRectMake(titleLabelWidth+10, 0, frame.size.width-titleLabelWidth-35, 30)];
                _textField.textAlignment = NSTextAlignmentLeft;
                if (![_inputValue isEqual:[NSNull null]]) {
                    _textField.text = _inputValue;
                }
                _textField.backgroundColor = [UIColor grayColor];
                [self addSubview:_textField];
                break;
            case InputTypeSelect:
                
                break;
            case InputTypeCheckbox:
                
                break;
            case InputTypeRadio:
                
                break;
            case InputTypeDate:
                
                break;
            default:
                break;
        }
    }
    return self;
}

- (void) dealloc
{
    [super dealloc];
    TT_RELEASE_SAFELY(_titleLabel);
    TT_RELEASE_SAFELY(_textField)
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
