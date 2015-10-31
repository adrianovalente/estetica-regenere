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

@interface HomeTableViewManager ()<HomeTableViewCellDelegate>

@end

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
    [homeCell setTrashDelegate:self];
    [homeCell fillCellWithName:[consulta service]
                      subtitle:[consulta esteticista]
                          time:[NSString stringWithFormat:@"%@ de %@, às %@:%@", [date day], [self monthString:[date month]], [date hour], [date minute]] consultaId:(int)[[consulta consultaId] integerValue]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

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

#pragma mark - Home Table View Cell Delegate
-(void)didTapTrashIcon:(int)appointmentId
{
    [self.delegate didSelectConsulta:appointmentId];
}

@end
