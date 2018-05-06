//
//  ViewController.m
//  ZXWebImageCache
//
//  Created by windorz on 2018/3/23.
//  Copyright © 2018年 windorz. All rights reserved.
//

#import "ViewController.h"
#import "ZXWebImageCacheManager.h"
#import "UIImageView+ZXWebChache.h"

@interface ViewController ()
@property (nonatomic, strong) UIImageView *imageView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    

    
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    self.imageView.backgroundColor = [UIColor orangeColor];
    self.imageView.center = self.view.center;
    
    [self.view addSubview:self.imageView];
    
    

}

- (IBAction)downLoader:(UIButton *)sender {
    
    // NSString *urlString = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1525595910277&di=c85b3c424b604df275c58c5046b28f71&imgtype=0&src=http%3A%2F%2Fimg1.cache.netease.com%2Fgame%2FOW%2F201503%2F77.jpg";
    
     NSString *urlString = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1525596301308&di=93958893dfbeba8367d7978edb2dc2ec&imgtype=0&src=http%3A%2F%2Fstatic.numbani.cn%2Fforum%2F201602%2F29%2F215655aozex6yznxnruhc8.jpg";


    // 方法一
    [self.imageView zx_setImageWithUrlString:urlString withPlaceHolderImageName:@"placeholder"];
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
