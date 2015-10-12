//
//  BaseTableViewManager.h
//  ListaDeCompras
//
//  Created by Taqtile on 10/9/14.
//  Copyright (c) 2014 Taqtile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BaseTableViewManager <NSObject>

@optional
-(Class) getCellClassForItem:(id)item;

@optional
-(void) setDataToCell:(id) cell withData:(id) item;

@optional
-(NSArray*) getCellsClasses;

@optional
-(CGFloat) getTableViewContentHeight;

@end

@interface BaseTableViewManager : NSObject<UITableViewDataSource, UITableViewDelegate, BaseTableViewManager>

-(id) initWithTableView:(UITableView*) tableView;

-(void) updateWithData:(NSArray*) data;

@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSArray* data;
@property (strong, nonatomic) NSMutableDictionary *registeredNibsIdentifiers;

-(BOOL)isNibRegisteredForClassName:(NSString *)className;

-(Class) classForItem:(id) item;

-(NSString*) cellIdentifierForClass:(NSString*) cellClassName;

-(id) getItem:(NSIndexPath *)indexPath;

-(void)registerCellNibs;



@end
