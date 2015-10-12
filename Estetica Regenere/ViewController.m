//
//  ViewController.m
//  Estetica Regenere
//
//  Created by Adriano on 10/10/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *checkView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.checkView.layer.masksToBounds = NO;
    self.checkView.layer.shadowOffset = CGSizeMake(-15, 20);
    self.checkView.layer.shadowRadius = 5;
    self.checkView.layer.shadowOpacity = 0.5;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
