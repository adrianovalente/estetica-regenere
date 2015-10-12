//
//  HomeHeaderView.m
//  Estetica Regenere
//
//  Created by Adriano on 10/10/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "HomeHeaderView.h"
#import "BasicButtonView.h"

@interface HomeHeaderView ()<BasicButtonProtocol>

@property (weak, nonatomic) IBOutlet BasicButtonView *marcarConsultaBasicButton;

@end


@implementation HomeHeaderView


- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void) setup
{
    [self.marcarConsultaBasicButton setTitle:@"Marcar consulta"];
    [self.marcarConsultaBasicButton setDelegate:self];
}


#pragma mark - Basic Button Delegate
- (void)buttonTapped:(id)button
{
    [self.delegate didSelectMarcarConsulta];
}

@end
