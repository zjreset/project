//
//  AutoAdaptedView.h
//  project
//
//  Created by runes on 13-1-23.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import <Three20UI/Three20UI.h>
typedef enum {
    InputTypeNone,
    InputTypeInput,
    InputTypeSelect,
    InputTypeRadio,
    InputTypeCheckbox,
    InputTypeDate,
} InputType;

@interface AutoAdaptedView : TTView
{
    UILabel *_titleLabel;
    UITextField *_textField;
}
@property (nonatomic, retain) UITextField *textField;
- (id)initWithFrame:(CGRect)frame title:(NSString*)_title inputType:(NSInteger)_inputType inputValue:(NSString*)_inputValue;
@end
