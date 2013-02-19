//
//  AutoAdaptedView.m
//  project
//
//  Created by runes on 13-1-23.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import "AutoAdaptedView.h"
#import "AppDelegate.h"
#import "SysTypeValue.h"

@implementation AutoAdaptedView
@synthesize textField = _textField,valueTypeDicCode = _valueTypeDicCode,inputType = _inputType,textValue = _textValue;
static int titleLabelWidth = 90;

- (id)initWithFrame:(CGRect)frame title:(NSString*)_title inputType:(NSString*)sInputType inputText:(NSString*)_inputText inputValue:(NSString*)_inputValue valueTypeDicCode:(NSString*)sValueTypeDicCode
{
    self = [[super initWithFrame:frame] autorelease];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, titleLabelWidth, 30)];
        _titleLabel.text = _title;
        _titleLabel.textAlignment = NSTextAlignmentRight;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_titleLabel];
        _textValue = _inputValue;
        _valueTypeDicCode = sValueTypeDicCode;
        _inputType = sInputType;
        if (![sInputType isEqual:[NSNull null]] && [sInputType compare:@"select"] == NSOrderedSame) {
            _textField = [[UITextField alloc] initWithFrame:CGRectMake(titleLabelWidth+10, 0, frame.size.width-titleLabelWidth-35, 30)];
            _textField.textAlignment = NSTextAlignmentLeft;
            if (![_inputText isEqual:[NSNull null]]) {
                _textField.text = _inputText;
            }
            _textField.backgroundColor = [UIColor grayColor];
            [self addSubview:_textField];
        }
        else if (![sInputType isEqual:[NSNull null]] && [sInputType compare:@"radio"] == NSOrderedSame) {
            
        }
        else if (![sInputType isEqual:[NSNull null]] && [sInputType compare:@"textarea"] == NSOrderedSame) {
            _textField = [[UITextField alloc] initWithFrame:CGRectMake(titleLabelWidth+10, 0, frame.size.width-titleLabelWidth-35, 130)];
            _textField.textAlignment = NSTextAlignmentLeft;
            if (![_inputText isEqual:[NSNull null]]) {
                _textField.text = _inputText;
            }
            _textField.backgroundColor = [UIColor grayColor];
            [self addSubview:_textField];
        }
        else if (![sInputType isEqual:[NSNull null]] && [sInputType compare:@"date"] == NSOrderedSame) {
            _textField = [[UITextField alloc] initWithFrame:CGRectMake(titleLabelWidth+10, 0, frame.size.width-titleLabelWidth-35, 30)];
            _textField.textAlignment = NSTextAlignmentLeft;
            if (![_inputText isEqual:[NSNull null]]) {
                _textField.text = _inputText;
            }
            _textField.backgroundColor = [UIColor grayColor];
            
            UIDatePicker *dPicker = [[[UIDatePicker alloc]init] autorelease];
            [dPicker setDatePickerMode:UIDatePickerModeDate];
            _textField.inputView = dPicker;
//            NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
//            formatter.dateFormat = @"yyyy-MM-dd";
//            //NSTimeInterval interval = 24*60*60*1;
//            NSDate *date = [[NSDate alloc] init];
//            NSString *timestamp = [formatter stringFromDate:date];
//            _textField.text = timestamp;
//            [date release];
            [dPicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventAllEvents];
            
            [self addSubview:_textField];
        }
        else{
            _textField = [[UITextField alloc] initWithFrame:CGRectMake(titleLabelWidth+10, 0, frame.size.width-titleLabelWidth-35, 30)];
            _textField.textAlignment = NSTextAlignmentLeft;
            if (![_inputText isEqual:[NSNull null]]) {
                _textField.text = _inputText;
            }
            _textField.backgroundColor = [UIColor grayColor];
            [self addSubview:_textField];
        }
    }
    return self;
}

- (void)datePickerValueChanged:(id)sender
{
	UIDatePicker *datePicker = (UIDatePicker*)sender;
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    formatter.dateFormat = @"yyyy-MM-dd";
	NSString *timestamp = [formatter stringFromDate:datePicker.date];
    _textField.text = timestamp;
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
