//
//  EncoderViewController.m
//  project
//
//  Created by runes on 13-2-4.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import "EncoderViewController.h"

@interface EncoderViewController ()

@end

@implementation EncoderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    id<NSFastEnumeration> results = [info objectForKey:ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for (symbol in results)
    {
        break;
    }
    
    NSString *text = symbol.data;
    NSLog(@"%@",text);
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
}
@end
