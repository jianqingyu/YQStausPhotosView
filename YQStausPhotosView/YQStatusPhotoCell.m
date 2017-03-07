//
//  YQStatusPhotoCell.m
//  YQStausPhotosView
//
//  Created by yjq on 16/4/13.
//  Copyright © 2016年 com.millenniumStar. All rights reserved.
//

#import "YQStatusPhotoCell.h"
#import "UIView+Extension.h"
@interface YQStatusPhotoCell ()
@property (nonatomic,strong)UILabel *titleLab;
@end
@implementation YQStatusPhotoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *Id = @"status";
    YQStatusPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (cell==nil) {
        cell = [[YQStatusPhotoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Id];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.titleLab = [[UILabel alloc]init];
        self.titleLab.text = @"上传图片";
        [self.contentView addSubview:self.titleLab];
        self.photosView = [[YQStatusPhotosView alloc]init];
        [self.contentView addSubview:self.photosView];
    }
    return self;
}

- (void)setImgPhotos:(NSArray *)imgPhotos{
    _imgPhotos = imgPhotos;
    self.titleLab.x = 16;
    self.titleLab.y = 10;
    self.titleLab.width = 80;
    self.titleLab.height = 30;
    if (imgPhotos.count>0) {
        self.photosView.imgPhotos = _imgPhotos;
        self.photosView.x = self.titleLab.x;
        self.photosView.y = CGRectGetMaxY(self.titleLab.frame)+10;
        self.photosView.size = [YQStatusPhotosView sizeWithCount:_imgPhotos.count];
    }
    CGRect bounds = self.bounds;
    bounds.size.height = CGRectGetMaxY(self.photosView.frame)+10;
    self.bounds = bounds;
}

@end
