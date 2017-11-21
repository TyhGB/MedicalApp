//
//  SetHeadViewController.m
//  MedicalApp
//
//  Created by TyhOS on 2017/10/31.
//  Copyright © 2017年 TyhOS. All rights reserved.
//

#import "SetHeadViewController.h"
#import "UserDataBase.h"

@interface SetHeadViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIImage *image;
@end

@implementation SetHeadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"设置头像";
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-300)/2, 100, 300, 300)];
    self.imageView.layer.borderWidth=1;
    //获取数据库中的头像图片
    self.image = [[UserDataBase sharedUserDataBase] getHeadPicture:_phone];
    self.imageView.image = self.image;
    [self.view addSubview:self.imageView];
    UIBarButtonItem * button  =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(clickBtn)];
    self.navigationItem.rightBarButtonItem = button;
}
-(void)clickBtn
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
            //设置代理(UINavigationControlDelegate,UIImagePicker)
            imagePicker.delegate = self;
            //设置数据类型
            imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            imagePicker.editing = YES;
            imagePicker.allowsEditing = YES;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"摄像头拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
            //设置代理(UINavigationControlDelegate,UIImagePicker)
            imagePicker.delegate = self;
            //设置数据类型
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.editing = YES;
            imagePicker.allowsEditing = YES;
            imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }];
    UIAlertAction *action3= [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        nil;
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [self presentViewController:alert animated:YES completion:nil];
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //取消图片
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *chooseImage =info[UIImagePickerControllerEditedImage];
    self.imageView.image = chooseImage;
    [[UserDataBase sharedUserDataBase] setHeadPicture:chooseImage Phone:self.phone];
              //设置头像更新代理
    [self.delegate updateHead:chooseImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
////压缩图片
//-(UIImage *)imageWithImagesSimpl:(UIImage *)image scaledToSize:(CGSize) newSize
//{
//
//}
@end
