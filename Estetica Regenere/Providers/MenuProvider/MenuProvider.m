//
//  MenuProvider.m
//  Estetica Regenere
//
//  Created by Adriano on 10/15/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "MenuProvider.h"

@implementation MenuOption

+(MenuOption *)menuOptionWithName:(NSString *)name
                        imageName:(NSString *)imageName
                selectedImageName: (NSString *)selectedImageName
{
    return [[MenuOption alloc] initWithName:name
                                  imageName:imageName
                          selectedImageName:selectedImageName];
}

-(instancetype)initWithName:(NSString *)name
                  imageName:(NSString *)imageName
          selectedImageName:(NSString *)selectedImageName
{
    self = [super init];
    [self setName:name];
    [self setImageName:imageName];
    [self setSelectedImageName:selectedImageName];
    return self;
}

@end

@implementation MenuProvider

-(NSArray *)getMenuOptions
{
    return @[
             [MenuOption menuOptionWithName:@"Home"
                                  imageName:@"menu-home"
                          selectedImageName:@"menu-home-selected"],
             [MenuOption menuOptionWithName:@"Marcar Consulta"
                                  imageName:@"menu-schedule"
                          selectedImageName:@"menu-schedule-selected"],
             [MenuOption menuOptionWithName:@"Política de Privaciade"
                                  imageName:@"menu-privacy"
                          selectedImageName:@"menu-privacy-selected"],
             [MenuOption menuOptionWithName:@"Sobre o aplicativo"
                                  imageName:@"menu-about"
                          selectedImageName:@"menu-about-selected"],
             [MenuOption menuOptionWithName:@"Fale Conosco"
                                  imageName:@"menu-contact"
                          selectedImageName:@"menu-contact-selected"],
             [MenuOption menuOptionWithName:@"Fazer Logout"
                                  imageName:@"menu-logout"
                          selectedImageName:@"menu-logout-selected"]
             ];
}

@end
