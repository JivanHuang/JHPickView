//
//  ViewController.m
//  JHPickView
//
//  Created by Jivan on 2017/5/13.
//  Copyright © 2017年 Jivan. All rights reserved.
//

#import "ViewController.h"
#import "JHPickView.h"

#define MAIN_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define MAIN_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,JHPickerDelegate>


@property (strong,nonatomic) UITableView* tableView ;
@property (strong,nonatomic) NSArray* cellTiltleArr ;
@property (assign,nonatomic) NSIndexPath* selectedIndexPath ;

@end

@implementation ViewController

-(NSArray*)cellTiltleArr
{
    if (!_cellTiltleArr) {
        
        _cellTiltleArr = @[@"性别",@"生日",@"星座",@"现居地",@"身高",@"体重",@"情感状态"] ;
    }
    
    return _cellTiltleArr ;
}
-(UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO ;
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        [self.view  addSubview: _tableView];
    }
    
    return _tableView ;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.hidden = NO ;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath =  indexPath ;
    
   if (indexPath.row == 0) {
        JHPickView *picker = [[JHPickView alloc]initWithFrame:self.view.bounds];
        picker.delegate = self ;
        picker.arrayType = GenderArray;
        [self.view addSubview:picker];
        
    }
    
    if (indexPath.row == 1) {
        JHPickView *picker = [[JHPickView alloc]initWithFrame:self.view.bounds];
        picker.delegate = self ;
        picker.arrayType = DeteArray;
        [self.view addSubview:picker];
    }
    
    if (indexPath.row == 3) {
        JHPickView *picker = [[JHPickView alloc]initWithFrame:self.view.bounds];
        picker.delegate = self ;
        picker.arrayType = AreaArray;
        [self.view addSubview:picker];
    }
    if (indexPath.row == 4) {
        JHPickView *picker = [[JHPickView alloc]initWithFrame:self.view.bounds];
        picker.delegate = self ;
        picker.arrayType = HeightArray;
        [self.view addSubview:picker];
    }
    
    if (indexPath.row == 5) {
        JHPickView *picker = [[JHPickView alloc]initWithFrame:self.view.bounds];
        picker.delegate = self ;
        picker.arrayType = weightArray;
        [self.view addSubview:picker];
    }
    
    if (indexPath.row == 6) {
        JHPickView *picker = [[JHPickView alloc]initWithFrame:self.view.bounds];
        picker.delegate = self ;
        picker.selectLb.text = @"情感状态";
        picker.customArr = @[@"已婚",@"未婚",@"保密"];
        [self.view addSubview:picker];
    }
}

#pragma mark - JHPickerDelegate

-(void)PickerSelectorIndixString:(NSString *)str
{
    
    UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:self.selectedIndexPath] ;
    cell.detailTextLabel.text = str ;
    
    if (self.selectedIndexPath.row == 1) {
        
        NSDateFormatter* formater = [[NSDateFormatter alloc] init];
        formater.dateFormat = @"yyyy年MM月d日" ;
        NSDate* date = [formater dateFromString:str];
        
        NSDateComponents* components  = [self getDateComponentsFromDate:date];
        NSString* str = [self getAstroWithMonth: components.month  day: components.day] ;
        
        UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndexPath.row+1 inSection:self.selectedIndexPath.section]] ;
        
        cell.detailTextLabel.text = str ;
        
        
    }
    
}

-(NSDateComponents*)getDateComponentsFromDate:(NSDate*)date{
    
    //    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Beijing"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit =  NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    
    return theComponents ;
    
}

-(NSString *)getAstroWithMonth:(NSInteger)m day:(NSInteger)d{
    
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result;
    
    if (m<1||m>12||d<1||d>31){
        return @"错误日期格式!";
    }
    
    if(m==2 && d>29)
    {
        return @"错误日期格式!!";
    }else if(m==4 || m==6 || m==9 || m==11) {
        
        if (d>30) {
            return @"错误日期格式!!!";
        }
    }
    
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(m*2-(d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*2,2)]];
    
    
    return [NSString stringWithFormat:@"%@座",result];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellTiltleArr.count ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellID = @"cellID" ;
    UITableViewCell*  cell =  [tableView dequeueReusableCellWithIdentifier:cellID];
    
    for (UIView* View in cell.contentView.subviews)
    {
        if ([View isKindOfClass:[UIImageView class]]||[View isKindOfClass:[UITextField class]]) {
            [View removeFromSuperview];
        }
        
    }
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        
    }
    
    cell.textLabel.text = self.cellTiltleArr[indexPath.row];
   
    return cell ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
