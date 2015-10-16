//
//  MenuTableViewManager.m
//  Estetica Regenere
//
//  Created by Adriano on 10/15/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "MenuTableViewManager.h"
#import "MenuTableViewCell.h"

static const int kMenuTableViewCellHeight = 50;

@implementation MenuTableViewManager

-(Class)classForItem:(id)item
{
    return [MenuTableViewCell class];
}

-(NSArray *)getCellsClasses
{
    return @[[MenuTableViewCell class]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kMenuTableViewCellHeight;
}

-(void)setDataToCell:(id)cell withData:(id)item
{
    [(MenuTableViewCell *)cell fillWithMenuOption:(MenuOption *)item];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate didSelectMenuOption:indexPath.row];
}

#pragma mark - override
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Tirar esse migue
    id item = [self getItem:indexPath];
    id cell = [tableView dequeueReusableCellWithIdentifier:@"IDENTIFIER_MenuTableViewCell"];
    if (cell == nil) {
        NSLog(@"nil");
    }
    [self setDataToCell:cell withData:item];

    
    return cell;
}

@end
