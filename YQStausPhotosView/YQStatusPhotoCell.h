//
//  YQStatusPhotoCell.h
//  YQStausPhotosView
//
//  Created by yjq on 16/4/13.
//  Copyright © 2016年 com.millenniumStar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQStatusPhotosView.h"
@interface YQStatusPhotoCell : UITableViewCell
@property (nonatomic,strong)NSArray *imgPhotos;
@property (nonatomic,strong)YQStatusPhotosView *photosView;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
