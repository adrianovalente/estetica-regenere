//
//  BaseTableViewManager.m
//  ListaDeCompras
//
//  Created by Taqtile on 10/9/14.
//  Copyright (c) 2014 Taqtile. All rights reserved.
//

#import "BaseTableViewManager.h"

@implementation BaseTableViewManager

-(id) initWithTableView:(UITableView *)tableView
{
    self = [super init];
    
    if(self){
        self.tableView = tableView;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.tableView.backgroundColor = [UIColor clearColor];
        [self setup];
    }
    
    return self;
}

-(void) updateWithData:(NSArray *)data
{
    self.data = data;
    [self registerCellNibs];
    [self.tableView reloadData];
}

-(void) setup
{
    self.registeredNibsIdentifiers = [NSMutableDictionary new];
}

-(void)setDataToCell:(id)cell withData:(id)item
{}

-(CGFloat)getTableViewContentHeight
{
    [self.tableView layoutIfNeeded];
    return [self.tableView contentSize].height;
}

-(Class)getCellClassForItem:(id)item
{
    return nil;
}

-(Class)classForItem:(id)item
{
    return nil;
}

-(NSArray *)getCellsClasses
{
    return nil;
}

#pragma mark - Register Nibs
-(void)registerCellNibs{
    NSArray* cellClasse = [self getCellsClasses];
    for (Class class in cellClasse) {
        
        NSString *cellClassName = NSStringFromClass(class);
        NSString *cellIdentifier = [self cellIdentifierForClass:cellClassName];
        
        if([self isNibRegisteredForClassName:cellClassName] == NO){
            [self.registeredNibsIdentifiers setObject:cellIdentifier forKey:cellClassName];
            [self.tableView registerNib:[UINib nibWithNibName:cellClassName bundle:nil]
                 forCellReuseIdentifier:cellIdentifier];
        }
    }
}
//END OF Register Nibs

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self getItem:indexPath];
    id cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifierForClass:[[self classForItem:item] description]]];
    [self setDataToCell:cell withData:item];
    
    return cell;
}
//END OF UITableViewDataSource


-(BOOL)isNibRegisteredForClassName:(NSString *)className
{
    return [self.registeredNibsIdentifiers.allKeys containsObject:className];
}

-(NSString*) cellIdentifierForClass:(NSString*) cellClassName
{
    return [NSString stringWithFormat:@"IDENTIFIER_%@",cellClassName];
}


-(id) getItem:(NSIndexPath *)indexPath{
    return [self.data objectAtIndex:indexPath.row];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
