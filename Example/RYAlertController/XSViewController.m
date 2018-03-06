//
//  XSViewController.m
//  RYAlertController
//
//  Created by XaoflySho on 03/06/2018.
//  Copyright (c) 2018 XaoflySho. All rights reserved.
//

#import "XSViewController.h"
#import <RYAlertController/RYAlertController.h>

@interface XSViewController ()

@end

@implementation XSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showAlertButtonClick:(id)sender {
    RYAlertController *alertController = [RYAlertController alertControllerWithTitle:@"title" message:@"message"];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)showUIAlertButtonClick:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"title" message:@"message" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
