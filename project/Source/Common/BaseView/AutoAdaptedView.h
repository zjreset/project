//
//  AutoAdaptedView.h
//  project
//
//  Created by runes on 13-1-23.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import <Three20UI/Three20UI.h>
#import "RadioButton.h"
@interface AutoAdaptedView : TTView <RadioButtonDelegate>
{
    UILabel *_titleLabel;
    UITextField *_textField;
    RadioButton *_radioButton;
    UILabel *_radioLabel;
    NSString *_valueTypeDicCode;
    NSString *_inputType;
    NSString *_textValue;
}
@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, retain) NSString *valueTypeDicCode;
@property (nonatomic, retain) NSString *inputType;
@property (nonatomic, retain) NSString *textValue;
@property (nonatomic, assign) NSInteger viewHeight;

- (id)initWithFrame:(CGRect)frame title:(NSString*)_title inputType:(NSString*)sInputType inputText:(NSString*)_inputText inputValue:(NSString*)_inputValue valueTypeDicCode:(NSString*)sValueTypeDicCode;
@end
