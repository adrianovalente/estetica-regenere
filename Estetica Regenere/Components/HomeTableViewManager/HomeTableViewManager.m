//
//  HomeTableViewManager.m
//  Estetica Regenere
//
//  Created by Adriano on 10/11/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "HomeTableViewManager.h"
#import "HomeTableViewCell.h"
#import "AppointmentsList.h"

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
    ConsultasModel *consulta = (ConsultasModel *)item;
    DateModel *date = [consulta date];
    HomeTableViewCell *homeCell = (HomeTableViewCell *) cell;
    [homeCell fillCellWithName:[consulta service]
                      subtitle:@"Dra. Olga Fernanda"
                          time:[NSString stringWithFormat:@"%@ de %@, às %@:%@", [date day], [self monthString:[date month]], [date hour], [date minute]]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate didSelectConsulta:1];
}

-(NSString *)monthString:(NSNumber *)month
{
    return [@[
              @"",
              @"janeiro",
              @"fevereiro",
              @"março",
              @"abril",
              @"maio",
              @"junho",
              @"julho",
              @"agosto",
              @"setembro",
              @"outubro",
              @"novembro",
              @"dezembro"
              ] objectAtIndex:[month integerValue]];
}

@end
