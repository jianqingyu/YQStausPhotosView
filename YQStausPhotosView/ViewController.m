//
//  ViewController.m
//  YQStausPhotosView
//
//  Created by yjq on 16/4/13.
//  Copyright © 2016年 com.millenniumStar. All rights reserved.
//

#import "ViewController.h"
#import "YQStatusPhotoCell.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,YQStatusPhotosViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *imgArr;
@property (nonatomic,strong)UIImage *addImg;
@property (nonatomic,assign)BOOL isAdd;
@property (weak, nonatomic) IBOutlet UIStackView *myStackView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imgArr = [NSMutableArray array];
    UIImage *img = [UIImage imageNamed:@"sctp"];
    [self.imgArr addObject:img];
}

- (IBAction)addImg:(id)sender {
    self.isAdd = YES;
    [self newOpenCameraAction];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YQStatusPhotoCell *imgCell = [YQStatusPhotoCell cellWithTableView:tableView];
    imgCell.imgPhotos = self.imgArr;
    imgCell.photosView.delegate = self;
    return imgCell;
}

//删除图片
- (void)YQStatusPhotos:(YQStatusPhotosView *)YQStatusPhotos delete:(NSInteger)index{
    [self.imgArr removeObjectAtIndex:index];
    NSIndexPath *loadPath = [NSIndexPath indexPathForItem:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[loadPath] withRowAnimation:UITableViewRowAnimationNone];
}
//打开图片
- (void)YQStatusPhotos:(YQStatusPhotosView *)YQStatusPhotos tap:(id)sender{
    self.isAdd = NO;
    [self newOpenCameraAction];
}

- (void)newOpenCameraAction{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                   
                                                         handler:^(UIAlertAction * action) {}];
    UIAlertAction* fromPhotoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault                                                                 handler:^(UIAlertAction * action) {                                                                     UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        //        imagePicker.allowsEditing = YES;
        imagePicker.allowsEditing = NO;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction* fromCameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault                                                             handler:^(UIAlertAction * action) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            //            imagePicker.allowsEditing = YES;
            imagePicker.allowsEditing = NO;
            imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:fromCameraAction];
    [alertController addAction:fromPhotoAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark -- UIImagePickerControllerDelagate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //info中包含选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        if (_isAdd) {
            self.addImg = image;
            UIImageView *starImgVw = [[UIImageView alloc]initWithImage:self.addImg];
            starImgVw.contentMode = UIViewContentModeScaleAspectFit;
            [self.myStackView addArrangedSubview:starImgVw];
            [UIView animateWithDuration:0.25 animations:^{
                [self.myStackView layoutIfNeeded];
            }];
        }else{
            [self.imgArr addObject:image];
            NSIndexPath *loadPath = [NSIndexPath indexPathForItem:0 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:@[loadPath] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

@end
