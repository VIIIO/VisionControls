//
//  CommonSearchController.m
//  VisionControls
//
//  Created by Vision on 16/3/15.
//  Copyright © 2016年 VIIIO. All rights reserved.
//

#import "CommonSearchController.h"

@interface CommonSearchController (){
    
}

/**
 用戶保留域，便於選擇回調方法中進行數據的處理
 */
@property (strong,nonatomic) id userTag;
@property NSMutableArray * list_model;
@property NSMutableArray * list_model_search;
@end

@implementation CommonSearchController

#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self bind];
}

-(void) bind{
    self.searchDisplayController.searchBar.placeholder = @"Click To Search";
    self.tableView.tableFooterView = [UIView new];
}
/**
 初始化数据
 */
- (void) initTableData{
    self.list_model = [[NSMutableArray alloc]init];
    self.list_model_search = [[NSMutableArray alloc]init];
    self.SelectedItem = [[CboDataMODEL alloc]init];
    self.SelectedList = [[NSMutableArray alloc]init];
    if (!self.IsMulti) {
        CboDataMODEL *model_nil = [[CboDataMODEL alloc]init];
        model_nil.name = @"無";
        model_nil.value = nil;
        [self.list_model addObject:model_nil];
    }
}
- (void) reloadTableBoth{
    [self.tableView reloadData];
    [self.searchDisplayController.searchResultsTableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
/**
 必須調用此方法進行單選/多選初始化，此方法為自定義數據源，單選
 @param dataSource 數據源Array<CboDataMODEL>
 @param value 單項選擇Value值
 */
- (void)initDataSource:(NSMutableArray *)dataSource withSelected:(NSString *)value userTag:(id)userTag{
    [self resetDataSource:dataSource IsMulti:NO IsCustomDataSource:YES userTag:userTag];
    [self selectByValue:value];
}
/**
 必須調用此方法進行單選/多選初始化，此方法為自定義數據源，多選
 @param dataSource 數據源Array<CboDataMODEL>
 @param list_value 以逗號","分隔的多選擇項
 */
- (void)initMultiDataSource:(NSMutableArray *)dataSource withSelected:(NSString *)list_value userTag:(id)userTag{
    [self resetDataSource:dataSource IsMulti:YES IsCustomDataSource:YES userTag:userTag];
    [self selectByValues:list_value];
}

- (void)resetDataSource:(NSMutableArray *)dataSource IsMulti:(BOOL)IsMulti IsCustomDataSource:(BOOL)IsCustomDataSource userTag:(id)userTag{
    //初始化
    self.IsMulti = IsMulti;
    self.IsCustomDataSource = IsCustomDataSource;
    self.userTag = userTag;
    [self initTableData];
    if (dataSource) {
        self.list_model = dataSource;
    }
    [self reloadTableBoth];
}

- (void)selectByValue:(NSString *)value{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"value == %@", value];
    NSArray *filteredArray = [self.list_model filteredArrayUsingPredicate:predicate];
    if (filteredArray.count > 0) {
        self.SelectedItem = [filteredArray objectAtIndex:0];
    }
}
- (void)selectByValues:(NSString *)list_value{
    NSArray * arr_value= [list_value componentsSeparatedByString:@","];
    for (NSString* value in arr_value) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"value == %@", value];
        NSArray *filteredArray = [self.list_model filteredArrayUsingPredicate:predicate];
        if (filteredArray.count > 0) {
            [self.SelectedList addObject:[filteredArray objectAtIndex:0]];
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return self.list_model.count;
    }else{
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(name contains[cd] %@) OR (value contains[cd] %@) ",self.searchDisplayController.searchBar.text,self.searchDisplayController.searchBar.text];
        self.list_model_search = [[NSMutableArray alloc] initWithArray:[self.list_model filteredArrayUsingPredicate:predicate]];
        return [self.list_model_search count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * st_cellId = @"CommonSearchCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:st_cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:st_cellId];
    }
    
    NSMutableArray *arr_temp;
    if (tableView == self.tableView) {
        arr_temp = self.list_model;
    }else{
        arr_temp = self.list_model_search;
    }
    
    CboDataMODEL *model = [arr_temp objectAtIndex:indexPath.row];
    // Configure the cell...
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.value;
    if (!self.IsMulti) {
        if ([model isEqual: self.SelectedItem]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else{
        if ([self.SelectedList indexOfObject:model] != NSNotFound) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *arr_temp;
    if (tableView == self.tableView) {
        arr_temp = self.list_model;
    }else{
        arr_temp = self.list_model_search;
    }
    CboDataMODEL *model_sel = [arr_temp objectAtIndex:indexPath.row];
    if (!self.IsMulti) {
        self.SelectedItem = model_sel;
        //[tableView reloadData];
        [self reloadTableBoth];//全部Reload以消除原选中
        [self singleItemSelectedCallback];
        if (self.searchDisplayController.active) {
            [self.searchDisplayController setActive:NO animated:YES];
        }
        [self backToPrevPage];
    }else{
        if ([self.SelectedList indexOfObject:model_sel] == NSNotFound) {
            //若不存在，新增
            [self.SelectedList addObject:model_sel];
        }else{
            //若存在，删除
            [self.SelectedList removeObject:model_sel];
        }
        [self reloadTableBoth];
        //[tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];//多选只需刷新一行即可
    }
}

#pragma mark 控件触发
- (IBAction)btn_back_click:(id)sender {
    [self backToPrevPage];
}
- (IBAction)btn_done_click:(id)sender {
    //若是多选，执行回调
    if (self.IsMulti) {
        [self multiItemsSelectedCallback];
    }else{
        if (self.SelectedItem.value == nil) {
            self.SelectedItem = [self.list_model objectAtIndex:0];
            [self reloadTableBoth];
            [self singleItemSelectedCallback];
        }
    }
    [self backToPrevPage];
}
- (IBAction)btn_clear_click:(id)sender {
    if (self.IsMulti) {
        self.SelectedList = [[NSMutableArray alloc]init];
        [self reloadTableBoth];
    }else{
        self.SelectedItem = [self.list_model objectAtIndex:0];
        [self reloadTableBoth];
        [self singleItemSelectedCallback];
        [self backToPrevPage];
    }
}


#pragma mark 一般处理

- (void)ShowInfo:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:msg message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)singleItemSelectedCallback{
    if ([self.delegate respondsToSelector:@selector(commonSearchController:singleItemSelected:userTag:)]) {
        [self.delegate commonSearchController:self singleItemSelected:self.SelectedItem userTag:self.userTag];
    }
}
- (void)multiItemsSelectedCallback{
    if ([self.delegate respondsToSelector:@selector(commonSearchController:multiItemsSelected:userTag:)]) {
        [self.delegate commonSearchController:self multiItemsSelected:self.SelectedList userTag:self.userTag];
    }
}

- (void)backToPrevPage{
    [self.navigationController popViewControllerAnimated:true];
}
@end
