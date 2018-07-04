//
//  HomeViewController.m
//  DemoApp
//
//  Created by 魏佃文 on 2018/7/3.
//  Copyright © 2018年 魏佃文. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeImageShowCell.h"
#import "ImagePreview.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,HomeImageShowCellDelegate>

//展示tableView
@property (strong,nonatomic) UITableView *displayTableView;
//需要展示的图片数组(内部存放为图片资源名字)
@property (strong,nonatomic) NSArray *imageNamesArr;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"self.imageNamesArr==%@",self.imageNamesArr);
    
    //添加底层tableVIew视图
    if (self.displayTableView)
    {
        [self.view addSubview:self.displayTableView];
    }
}

//tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.imageNamesArr.count/2+self.imageNamesArr.count%2;
}

//设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *aIdentifier = @"homeCell";
    HomeImageShowCell *cell = [tableView dequeueReusableCellWithIdentifier:aIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell)
    {
        cell = [[HomeImageShowCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aIdentifier];
    }
    cell.cellIndexPath = indexPath;
    cell.delegate = self;
    
    [self loadImagesForRowsWithIndexPath:indexPath andCell:cell];
    
    return cell;
}

//构建cell展示图像 并传入cell
-(void)loadImagesForRowsWithIndexPath:(NSIndexPath *)indexPath andCell:(HomeImageShowCell *)cell
{
    NSMutableArray *dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    NSString *firstName = self.imageNamesArr[indexPath.row*2];
    [dataArr addObject:firstName];
    
    //判断是否需要添加 cell第二张图
    //如果是最后一行且为单数 则最后一行不走这里 只有一张图显示
    if (self.imageNamesArr.count > indexPath.row*2+1)
    {
        NSString *secondName = self.imageNamesArr[indexPath.row*2+1];
        [dataArr addObject:secondName];
    }
    
    [cell congigueUIWithData:dataArr];
}

//cell将要出现时 绑定数据可以写在这里
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{}

//每个cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{}

//HomeCell点击图片回调代理
- (void)didClickOneImageWithTag:(NSInteger)aTag andIndex:(NSIndexPath *)indexP andImageView:(UIImageView *)image
{
    // 先计算cell的位置 再转化到view中的位置.
    //CGRect rectInTableView = [self.displayTableView rectForRowAtIndexPath:indexP];
    //CGRect rectInSuperView = [self.displayTableView convertRect:rectInTableView toView:[self.displayTableView superview]];
    //NSLog(@"==%@",NSStringFromCGRect(rectInSuperView));
    
    UIWindow *window=[[[UIApplication sharedApplication] delegate] window];
    CGRect aReact=[image convertRect: image.bounds toView:window];
    
    //NSLog(@"==%@",NSStringFromCGRect(aReact));
    NSString *imageName = _imageNamesArr[indexP.row*2];
    if (aTag == 101)
    {
        imageName = _imageNamesArr[indexP.row*2+1];
    }
    
    ImagePreview *imagePreview = [[ImagePreview alloc] initWithReact:aReact];
    [imagePreview showWithImageName:imageName];
}

/*延迟加载图像 这里模拟 网络加载图像有好处
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {[self loadImagesForOnscreenRows];}
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}

- (void)loadImagesForOnscreenRows
{
    if (_imageNamesArr.count>0)
    {
        NSArray *visiblePaths=[self.displayTableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            HomeImageShowCell *cell=[self.displayTableView cellForRowAtIndexPath:indexPath];
            
            NSMutableArray *dataArr = [[NSMutableArray alloc]initWithCapacity:0];
            
            NSString *firstName = self.imageNamesArr[indexPath.row*2];
            [dataArr addObject:firstName];
            
            if (self.imageNamesArr.count > indexPath.row*2)
            {
                NSString *secondName = self.imageNamesArr[indexPath.row*2+1];
                [dataArr addObject:secondName];
            }
            
            [cell congigueUIWithData:dataArr];
        }
    }
}*/

//懒加载imageNamesArr
- (NSArray *)imageNamesArr
{
    if (_imageNamesArr == nil)
    {
        _imageNamesArr = @[@"weather_bg_07_沙.jpg",@"weather_bg_05_雪.JPG",@"weather_bg_02_阴.JPG",@"weather_bg_01_晴.JPG",@"weather_bg_03_雨.JPG",@"weather_bg_08_霾.jpg",@"weather_bg_06_雷.JPG"];
    }
    return _imageNamesArr;
}

//懒加载displayTableView
- (UITableView *)displayTableView
{
    if (!_displayTableView)
    {
        _displayTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _displayTableView.tableFooterView = [[UIView alloc]init];
        _displayTableView.delegate = self;
        _displayTableView.dataSource = self;
        _displayTableView.separatorColor = [UIColor clearColor];
        _displayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _displayTableView.showsVerticalScrollIndicator = NO;
    }
    return _displayTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
