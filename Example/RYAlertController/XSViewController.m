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
    RYAlertController *alertController = [RYAlertController alertControllerWithTitle:@"TITLE" message:@"Message"];
    
    RYAlertAction *okAction = [RYAlertAction actionWithTitle:@"Ok" style:RYAlertActionStyleDefault handler:^(RYAlertAction * _Nonnull action) {
        NSLog(@"%@", action.title);
    }];
    
    RYAlertAction *cancelAction = [RYAlertAction actionWithTitle:@"Cancel" style:RYAlertActionStyleCancel handler:^(RYAlertAction * _Nonnull action) {
        NSLog(@"%@", action.title);
    }];
    
    RYAlertAction *destructiveAction = [RYAlertAction actionWithTitle:@"Destructive" style:RYAlertActionStyleDestructive handler:^(RYAlertAction * _Nonnull action) {
        NSLog(@"%@", action.title);
    }];
    
    [alertController addAction:okAction];
    [alertController addAction:destructiveAction];
    [alertController addAction:cancelAction];

    RYAlertAction *bikeSubaction = [RYAlertAction subactionWithTitle:@"Bike" image:[UIImage imageNamed:@"Bike"] handler:^(RYAlertAction * _Nonnull action) {
        NSLog(@"%@", action.title);
    }];
    
    RYAlertAction *busSubaction = [RYAlertAction subactionWithTitle:@"Bus" image:[UIImage imageNamed:@"Bus"] handler:^(RYAlertAction * _Nonnull action) {
        NSLog(@"%@", action.title);
    }];
    
    RYAlertAction *tramSubaction = [RYAlertAction subactionWithTitle:@"Tram" image:[UIImage imageNamed:@"Tram"] handler:^(RYAlertAction * _Nonnull action) {
        NSLog(@"%@", action.title);
    }];

    [alertController addSubaction:bikeSubaction];
    [alertController addSubaction:busSubaction];
    [alertController addSubaction:tramSubaction];
    [alertController addSubaction:bikeSubaction];
    [alertController addSubaction:busSubaction];
    [alertController addSubaction:tramSubaction];
    [alertController addSubaction:bikeSubaction];
    [alertController addSubaction:busSubaction];
    [alertController addSubaction:tramSubaction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)showUIAlertButtonClick:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"TITLE" message:@"message" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:@"Destructive" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [alertController addAction:destructiveAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
