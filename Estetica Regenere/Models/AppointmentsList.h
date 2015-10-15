//
//  AppointmentsList.h
//  Estetica Regenere
//
//  Created by json-model-generator: https://github.com/adrianovalente/JSONModel-Generator
//  Copyright (c) 2015 json-model-generator. All rights reserved.
//

#import "JSONModel.h"

@protocol ConsultasModel <NSObject>
@end


@interface DateModel : JSONModel
@property (nonatomic, strong) NSNumber *hour;
@property (nonatomic, strong) NSNumber *month;
@property (nonatomic, strong) NSNumber *day;
@property (nonatomic, strong) NSNumber *minute;
@property (nonatomic, strong) NSNumber *year;
@end


@interface ConsultasModel : JSONModel
@property (nonatomic, strong) DateModel *date;
@property (nonatomic, strong) NSString *service;
@end


@interface AppointmentsList : JSONModel
@property (nonatomic, strong) NSArray <ConsultasModel> *consultas;
@end
