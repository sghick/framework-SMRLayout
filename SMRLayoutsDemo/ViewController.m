//
//  ViewController.m
//  demoforlayout
//
//  Created by Tinswin on 2020/10/24.
//

#import "ViewController.h"
#import "SMRLayouts.h"
#import "SMRViews.h"

@interface SMRDemoItem : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *detail;
@property (strong, nonatomic) NSString *jumpClass;

@end

@implementation SMRDemoItem

+ (instancetype)itemWithTitle:(NSString *)title detail:(NSString *)detail jumpClass:(NSString *)jumpClass {
    SMRDemoItem *item = [[SMRDemoItem alloc] init];
    item.title = title;
    item.detail = detail;
    item.jumpClass = jumpClass;
    return item;
}

@end

@interface ViewController ()<
UITableViewDataSource,
UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray<SMRDemoItem *> *items;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    self.tableView.frame = self.view.frame;
    self.items = @[
//        [SMRDemoItem itemWithTitle:@"Box" detail:@"" jumpClass:@"SMRBoxDemoController"],
//        [SMRDemoItem itemWithTitle:@"Row" detail:@"" jumpClass:@"SMRRowDemoController"],
//        [SMRDemoItem itemWithTitle:@"Column" detail:@"" jumpClass:@"SMRColumnDemoController"],
//        [SMRDemoItem itemWithTitle:@"Scaffod" detail:@"" jumpClass:@"SMRScaffodDemoController"],
        [SMRDemoItem itemWithTitle:@"Migo" detail:@"" jumpClass:@"SMRMigoDemoController"],
    ];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    SMRDemoItem *item = self.items[indexPath.row];
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = item.detail;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SMRDemoItem *item = self.items[indexPath.row];
    UIViewController *vc = [[NSClassFromString(item.jumpClass) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

@end
