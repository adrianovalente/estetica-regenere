//
//  HomeHeaderView.m
//  Estetica Regenere
//
//  Created by Adriano on 10/10/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "HomeHeaderView.h"
#import "BasicButtonView.h"
#import "MoreButtonView.h"

@interface HomeHeaderView ()<BasicButtonProtocol, MoreButtonDelegate>

@property (weak, nonatomic) IBOutlet BasicButtonView *marcarConsultaBasicButton;
@property (weak, nonatomic) IBOutlet MoreButtonView *moreButtonView;
@property (weak, nonatomic) IBOutlet UILabel *helloLabel;
@property (weak, nonatomic) IBOutlet UILabel *appointmentsLabel;

@end


@implementation HomeHeaderView
#pragma mark - public api
-(void)updateWithName:(NSString *)name appointments:(NSNumber *)appointments
{
    [self.helloLabel setText:[NSString stringWithFormat:@"Olá, %@", name]];
    [self.appointmentsLabel setText:[NSString stringWithFormat:@"Você tem %@ consultas marcadas", appointments]];
}

-(void)noConnection
{
    [self.helloLabel setText:@"Olá, cliente"];
    [self.appointmentsLabel setText:@"Não foi possível se conectar ao servidor"];
}

#pragma mark - setup methods
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void) setup
{
    [self.marcarConsultaBasicButton setTitle:@"Marcar consulta"];
    [self.marcarConsultaBasicButton setDelegate:self];
    [self.moreButtonView setDelegate:self];

}


#pragma mark - Basic Button Delegate
- (void)buttonTapped:(id)button
{
    [self.delegate didSelectMarcarConsulta];
}

#pragma mark - More Button Delegate
-(void)didTapMoreButton
{
    [self.delegate didSelectMais];
}
@end
