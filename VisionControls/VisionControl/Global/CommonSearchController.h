//
//  CommonSearchController.h
//  VisionControls
//
//  Created by Vision on 16/3/15.
//  Copyright © 2016年 VIIIO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CboDataMODEL.h"

@class CommonSearchController;
@protocol CommonSearchControllerDelegate <NSObject>

@optional
- (void)commonSearchController:(CommonSearchController *)controller singleItemSelected:(CboDataMODEL *)model userTag:(id)userTag;
- (void)commonSearchController:(CommonSearchController *)controller multiItemsSelected:(NSMutableArray *)list_model userTag:(id)userTag;

@end

@interface CommonSearchController : UITableViewController
@property (weak,nonatomic) id<CommonSearchControllerDelegate> delegate;
/**
 單選時有值
 */
@property (strong,nonatomic) CboDataMODEL *SelectedItem;
/**
  多選時有值 <CboDataMODEL>
  */
@property (strong,nonatomic) NSMutableArray *SelectedList;
/**
 是否多選，默認NO
 */
@property (assign,nonatomic) BOOL IsMulti;
/**
 是否為自定義的數據源，默認NO
 */
@property (assign,nonatomic) BOOL IsCustomDataSource;
/**
 必須調用此方法進行單選/多選初始化，此方法為自定義數據源，單選
 @param dataSource 數據源Array<CboDataMODEL>
 @param value 單項選擇Value值
 @param userTag 用戶保留域，便於選擇回調方法中進行數據的處理
 */
- (void)initDataSource:(NSMutableArray *)dataSource withSelected:(NSString *)value userTag:(id)userTag;
/**
 必須調用此方法進行單選/多選初始化，此方法為自定義數據源，多選
 @param dataSource 數據源Array<CboDataMODEL>
 @param list_value 以逗號","分隔的多選擇項
 @param userTag 用戶保留域，便於選擇回調方法中進行數據的處理
 */
- (void)initMultiDataSource:(NSMutableArray *)dataSource withSelected:(NSString *)list_value userTag:(id)userTag;
@end
