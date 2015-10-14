//
//  HomeTableViewManager.m
//  Estetica Regenere
//
//  Created by Adriano on 10/11/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "HomeTableViewManager.h"
#import "HomeTableViewCell.h"

static const int kHomeTableViewCellHeight = 72;

@implementation HomeTableViewManager

-(Class)classForItem:(id)item
{
    return [HomeTableViewCell class];
}

-(NSArray *)getCellsClasses
{
    return @[[HomeTableViewCell class]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHomeTableViewCellHeight;
}

-(void)setDataToCell:(id)cell withData:(id)item
{
    HomeTableViewCell *homeCell = (HomeTableViewCell *) cell;
    [homeCell fillCellWithName:@"Limpeza de pele"
                      subtitle:@"Dra. Olga Fernanda"
                          time:@"07 de novembro, às 21:00"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate didSelectConsulta:1];
}

@end
