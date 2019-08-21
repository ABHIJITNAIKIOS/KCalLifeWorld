//
//  ChangeProfileViewController.m
//  KCal
//
//  Created by Pipl-01 on 04/07/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "ChangeProfileViewController.h"
#import "MyDetailController.h"
#import "AppDelegate.h"
#import "BaseViewController.h"
#import "GiFHUD.h"
#import <Photos/Photos.h>

@interface ChangeProfileViewController () <UIImagePickerControllerDelegate>
{
    UIImagePickerController *imgPickerObj;
    UIImage *img;
    NSData *datimaga;
    NSString *flagYes;
    NSString *str_img;
}

@end

@implementation ChangeProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"Change Profile Picture";
    
    flagYes = @"yes";
    str_img = @"";
    
    self.navigationItem.hidesBackButton=YES;
    
    _imgProfile.layer.masksToBounds = YES;
    _imgProfile.layer.cornerRadius = _imgProfile.frame.size.width/2;
//    _imgProfile.layer.borderWidth=1.0f;
//    _imgProfile.layer.borderColor=[UIColor blackColor].CGColor;
    
    [GiFHUD setGifWithImageName:@"Spinner3.gif"];
}



-(void)viewDidAppear:(BOOL)animated
{
    if ([flagYes isEqualToString:@"yes"])
    {
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        
//        NSString *strimg = [NSString stringWithFormat:@"%@%@",str_global_domain_pic,[defaults valueForKey:@"profile_pic"]];
        
        NSString *strimg = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"profile_pic"]];
        
        NSURL *url = [NSURL URLWithString:strimg];
        
        [_imgProfile setImageWithURL:url placeholderImage:[UIImage imageNamed:@"ic_user"]];
        
//        [GiFHUD showWithOverlay];
//        //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            [self wsGetPic];
//        });
        
        flagYes = @"no";
    }
    
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame = CGRectMake(12, 15, 18, 18);
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"white_left"] forState:UIControlStateNormal];
    leftbtn.tag=302;
    
    [leftbtn addTarget:self action:@selector(back)
      forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:leftbtn];
    
    for (UIButton *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 134)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 222)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 219)
        {
            [view removeFromSuperview];
        }
    }
    
    for (UIImageView *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 201)
        {
            [view removeFromSuperview];
        }
    }
}



-(void)back
{
    MyDetailController *obj=[[MyDetailController alloc]initWithNibName:@"MyDetailController" bundle:nil];
    [self.navigationController pushViewController:obj animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)btnRemove:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *img = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"profile_pic"]];
    
    if ([img isEqualToString:@""])
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"No image found."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        
                                        
                                    }];
        
        
        //Add your buttons to alert controller
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else if ([img isKindOfClass:[NSNull class]])
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"No image found."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        
                                        
                                    }];
        
        
        //Add your buttons to alert controller
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else if ([img isEqualToString:@"<null>"])
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"No image found."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        
                                        
                                    }];
        
        
        //Add your buttons to alert controller
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else
    {
        UIAlertController * alert = [UIAlertController                                                          alertControllerWithTitle:NSLocalizedString(@"Whoops!",nil)
                                                                                                                                 message:@"Are you sure you want to delete this profile picture ?"
                                                                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"YES"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        
                                        [GiFHUD showWithOverlay];
                                        //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
                                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
                                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                                            [self wsRemoveProfile];
                                        });
                                        
                                    }];
        
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"NO"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       
                                       
                                   }];
        
        
        //Add your buttons to alert controller
        
        [alert addAction:yesButton];
        [alert addAction:noButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
}



- (IBAction)btnCamera:(id)sender
{
    imgPickerObj = [[UIImagePickerController alloc] init];
    imgPickerObj.sourceType = UIImagePickerControllerSourceTypeCamera;
    [imgPickerObj setDelegate:(id)self];
    imgPickerObj.allowsEditing = YES;
    imgPickerObj.navigationBar.backgroundColor = [UIColor colorWithRed:71/255.0f green:118/255.0f blue:59/255.0f alpha:1];
    imgPickerObj.navigationBar.translucent = NO;
    imgPickerObj.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if(status == AVAuthorizationStatusAuthorized) {
        
        // authorized
        
        [self presentViewController:imgPickerObj animated:YES completion:nil];
    }
    else if(status == AVAuthorizationStatusDenied){
        
        // denied
        
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:nil
                                    message:@"Please allow Kcal to access your Camera from Settings." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *yesButton = [UIAlertAction
                                    actionWithTitle:@"Settings"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction *action) {
                                        
                                        UIApplication *application = [UIApplication sharedApplication];
                                        NSURL *URL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                                        [application openURL:URL options:@{} completionHandler:^(BOOL success) {
                                            if (success) {
                                                NSLog(@"Opened url");
                                            }
                                        }];
                                    }];
        
        
        UIAlertAction *noButton = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action) {
                                   }];
        
        [alert addAction:yesButton];
        [alert addAction:noButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else if(status == AVAuthorizationStatusRestricted){ // restricted
        
        
    }
    else if(status == AVAuthorizationStatusNotDetermined){ // not determined
        
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if(granted){
                
                // authorize
                // Access has been granted ..do something
                
                [self presentViewController:imgPickerObj animated:YES completion:nil];
            }
            
            else {
                
                // Access denied ..do something
                
                UIAlertController *alert = [UIAlertController
                                            alertControllerWithTitle:nil
                                            message:@"Please allow Kcal to access your Camera from Settings." preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *yesButton = [UIAlertAction
                                            actionWithTitle:@"Settings"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action) {
                                                
                                                UIApplication *application = [UIApplication sharedApplication];
                                                NSURL *URL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                                                [application openURL:URL options:@{} completionHandler:^(BOOL success) {
                                                    if (success) {
                                                        NSLog(@"Opened url");
                                                    }
                                                }];
                                            }];
                
                
                UIAlertAction *noButton = [UIAlertAction
                                           actionWithTitle:@"Cancel"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action) {
                                           }];
                
                
                [alert addAction:yesButton];
                [alert addAction:noButton];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
    }
}




- (IBAction)btnAlbum:(id)sender
{
    imgPickerObj = [[UIImagePickerController alloc] init];
    imgPickerObj.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [imgPickerObj setDelegate:(id)self];
    imgPickerObj.navigationBar.backgroundColor = [UIColor colorWithRed:71/255.0f green:118/255.0f blue:59/255.0f alpha:1];
    imgPickerObj.navigationBar.translucent = NO;
    imgPickerObj.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont fontWithName:@"AvenirLTStd-Medium" size:13.0]};
    
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]] setTitleTextAttributes:@{ NSFontAttributeName : [UIFont fontWithName:@"AvenirLTStd-Medium" size:13.0] } forState:UIControlStateNormal];
    
    //[[UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil] setTitleTextAttributes:@{ NSFontAttributeName : [UIFont fontWithName:@"AvenirLTStd-Medium" size:13.0] } forState:UIControlStateNormal];
    
    imgPickerObj.allowsEditing = YES;
    imgPickerObj.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypePhotoLibrary];
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusAuthorized) {
        
        // Access has been granted.
        
        [self presentViewController:imgPickerObj animated:YES completion:nil];
    }
    
    else if (status == PHAuthorizationStatusDenied) {
        
        // Access has been denied.
        
        UIAlertController *alert = [UIAlertController
                                    
                                    alertControllerWithTitle:nil
                                    
                                    message:@"Please allow Kcal to access your photo library from Settings." preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *yesButton = [UIAlertAction
                                    
                                    actionWithTitle:@"Settings"
                                    
                                    style:UIAlertActionStyleDefault
                                    
                                    handler:^(UIAlertAction *action) {
                                        
                                        UIApplication *application = [UIApplication sharedApplication];
                                        NSURL *URL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                                        [application openURL:URL options:@{} completionHandler:^(BOOL success) {
                                            if (success) {
                                                NSLog(@"Opened url");
                                            }
                                        }];
                                    }];
        
        UIAlertAction *noButton = [UIAlertAction
                                   
                                   actionWithTitle:@"Cancel"
                                   
                                   style:UIAlertActionStyleDefault
                                   
                                   handler:^(UIAlertAction *action) {
                                       
                                   }];
        
        [alert addAction:yesButton];
        
        [alert addAction:noButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else if (status == PHAuthorizationStatusNotDetermined) {
        
        // Access has not been determined.
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            
            if (status == PHAuthorizationStatusAuthorized) {
                
                // Access has been granted.
                
                [self presentViewController:imgPickerObj animated:YES completion:nil];
            }
            
            else {
                
                // Access has been denied.
                
                UIAlertController *alert = [UIAlertController
                                            
                                            alertControllerWithTitle:nil
                                            
                                            message:@"Please allow Kcal to access your photo library from Settings." preferredStyle:UIAlertControllerStyleAlert];
                
                
                UIAlertAction *yesButton = [UIAlertAction
                                            
                                            actionWithTitle:@"Settings"
                                            
                                            style:UIAlertActionStyleDefault
                                            
                                            handler:^(UIAlertAction *action) {
                                                
                                                UIApplication *application = [UIApplication sharedApplication];
                                                NSURL *URL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                                                [application openURL:URL options:@{} completionHandler:^(BOOL success) {
                                                    if (success) {
                                                        NSLog(@"Opened url");
                                                    }
                                                }];
                                            }];
                
                UIAlertAction *noButton = [UIAlertAction
                                           
                                           actionWithTitle:@"Cancel"
                                           
                                           style:UIAlertActionStyleDefault
                                           
                                           handler:^(UIAlertAction *action) {
                                               
                                           }];
                [alert addAction:yesButton];
                
                [alert addAction:noButton];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
    }
    
    else if (status == PHAuthorizationStatusRestricted) {
        
        // Restricted access - normally won't happen.
    }
}




- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary  *)info
{
    img=[info objectForKey:UIImagePickerControllerEditedImage];
    
    _imgProfile.image=img;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (IBAction)btnupdate:(id)sender
{
    if(img!=nil)
    {
        [GiFHUD showWithOverlay];
        //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self WsUpdateProfile];
        });
    }
    
    else
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"Please select a new profile picture."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        
                                        
                                    }];
        
        
        //Add your buttons to alert controller
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}



#pragma mark <--Web Services-->


//-(void)wsGetPic
//{
//    BaseViewController *base=[[BaseViewController alloc]init];
//    NSString *user_id=[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"];
//
//    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
//    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
//
//    NSString *parameter=[NSString stringWithFormat:@"userid=%@&action=%@&request=%@",user_id,@"view",@"profile"];
//
//    NSDictionary *dictionary =[[NSMutableDictionary alloc]init];
//
//    dictionary=[base WebParsingMethod:stringWebServicesCompleteUrl :parameter];
//
//    if(dictionary == (id)[NSNull null] || dictionary == nil)
//    {
//        UIAlertController * alert = [UIAlertController
//                                     alertControllerWithTitle:nil
//                                     message:@"Oops, cannot connect to server."
//                                     preferredStyle:UIAlertControllerStyleAlert];
//
//        //Add Buttons
//
//        UIAlertAction* yesButton = [UIAlertAction
//                                    actionWithTitle:@"OK"
//                                    style:UIAlertActionStyleDefault
//                                    handler:^(UIAlertAction * action) {
//
//
//                                    }];
//
//
//        //Add your buttons to alert controller
//
//        [alert addAction:yesButton];
//
//        [self presentViewController:alert animated:YES completion:nil];
//
//
//        //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Oops, cannot connect to server." delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//        //
//        //            [alert show];
//    }
//
//    else
//    {
//        NSString *errorCode=[NSString stringWithFormat:@"%@",[dictionary  valueForKey:@"code"]];
//        NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
//
//        dispatch_async(dispatch_get_main_queue(),^{
//            [GiFHUD dismiss];
//            if([errorCode isEqualToString:@"1"])
//            {
//                NSArray *arrProfile = [dictionary valueForKey:@"data"];
//
//                if ([[[arrProfile objectAtIndex:0] valueForKey:@"image"] isKindOfClass:[NSNull class]])
//                {
//
//                }
//
//                else
//                {
//                    str_img = [NSString stringWithFormat:@"%@",[[arrProfile objectAtIndex:0] valueForKey:@"image"]];
//
////                    NSURL *url = [NSURL URLWithString:str_img];
////
////                    [_imgProfile setImageWithURL:url placeholderImage:[UIImage imageNamed:@"ic_user"]];
//                }
//            }
//
//            else if ([errorCode isEqualToString:@"0"])
//            {
//
//            }
//
//            else if ([errorCode isEqualToString:@"3"])
//            {
//                UIAlertController * alert = [UIAlertController
//                                             alertControllerWithTitle:nil
//                                             message:message preferredStyle:UIAlertControllerStyleAlert];
//
//                //Add Buttons
//
//                UIAlertAction* yesButton = [UIAlertAction
//                                            actionWithTitle:@"OK"
//                                            style:UIAlertActionStyleDefault
//                                            handler:^(UIAlertAction * action) {
//
//
//                                            }];
//
//
//                //Add your buttons to alert controller
//
//                [alert addAction:yesButton];
//
//                [self presentViewController:alert animated:YES completion:nil];
//
//                //                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//                //
//                //                [alert show];
//            }
//
//            else
//            {
//                UIAlertController * alert = [UIAlertController
//                                             alertControllerWithTitle:nil
//                                             message:message preferredStyle:UIAlertControllerStyleAlert];
//
//                //Add Buttons
//
//                UIAlertAction* yesButton = [UIAlertAction
//                                            actionWithTitle:@"OK"
//                                            style:UIAlertActionStyleDefault
//                                            handler:^(UIAlertAction * action) {
//
//
//                                            }];
//
//
//                //Add your buttons to alert controller
//
//                [alert addAction:yesButton];
//
//                [self presentViewController:alert animated:YES completion:nil];
//
//                //                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//                //
//                //                [alert show];
//            }
//        });
//    }
//}




-(void)WsUpdateProfile
{
    //BaseViewController *obj=[[BaseViewController alloc]init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *token = [defaults valueForKey:@"token"];
    
    //NSString *webServices=@"ws-update-profile";
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    
    NSString            *stringBoundary, *contentType, *baseURLString, *urlString;
    NSURL               *url;
    NSMutableURLRequest *urlRequest;
    NSMutableData       *postBody=[[NSMutableData alloc]init];
    baseURLString   = [NSString stringWithFormat:@"%@",stringWebServicesCompleteUrl];
    urlString       = [NSString stringWithFormat:@"%@", baseURLString];
    url             = [NSURL URLWithString:urlString];
    urlRequest      = [[NSMutableURLRequest alloc] initWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    // Setup POST body
    
    contentType    = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", stringBoundary];
    [urlRequest addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    //user_id
    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Disposition: form-data; name=\"user_id\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *struserid = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"user_id"]];
    [postBody appendData:[[NSString stringWithString:struserid] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //request
    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Disposition: form-data; name=\"request\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *request = [NSString stringWithFormat:@"%@",@"profile"];
    [postBody appendData:[[NSString stringWithString:request] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //action
    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Disposition: form-data; name=\"action\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *action = [NSString stringWithFormat:@"%@",@"insert"];
    [postBody appendData:[[NSString stringWithString:action] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //key
    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Disposition: form-data; name=\"key\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *key = [NSString stringWithFormat:@"%@",str_key];
    [postBody appendData:[[NSString stringWithString:key] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //secret
    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Disposition: form-data; name=\"secret\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *secret = [NSString stringWithFormat:@"%@",str_secret];
    [postBody appendData:[[NSString stringWithString:secret] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //token
    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Disposition: form-data; name=\"token\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *strtoken = [NSString stringWithFormat:@"%@",token];
    [postBody appendData:[[NSString stringWithString:strtoken] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //image
    if(img!=nil)
    {
        NSData* pictureData = [NSData dataWithData:UIImageJPEGRepresentation(img,0.5)];
        
        [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image\"; filename=\"image.JPG\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        if ([pictureData length] == 0)
        {
            NSData *dataimage =[NSData dataWithData:datimaga];
            [postBody appendData:dataimage];
        }
        
        else
        {
            [postBody appendData:pictureData];
        }
        
        [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [urlRequest setHTTPBody:postBody];
    
    NSLog(@"Request body %@", [[NSString alloc] initWithData:[urlRequest HTTPBody] encoding:NSUTF8StringEncoding]);
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:nil];
    
    NSError *myError = nil;
    
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    NSArray *res = [dictionary valueForKey:@"data"];
    NSString *errorCode=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"code"]];
    NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
    
    NSLog(@"%@",res);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [GiFHUD dismiss];
        if([errorCode isEqualToString:@"1"])
        {
            if ([[[res objectAtIndex:0] valueForKey:@"image"] isKindOfClass:[NSNull class]])
            {
                
            }
            
            else
            {
                NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                
                NSString *pic=[NSString stringWithFormat:@"%@",[[res objectAtIndex:0] valueForKey:@"image"]];
                
                [defaults setObject:pic forKey:@"profile_pic"];
                
//                NSString *strimg = [NSString stringWithFormat:@"%@%@",str_global_domain_pic,[defaults valueForKey:@"profile_pic"]];
                
                NSString *strimg = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"profile_pic"]];
                
                NSURL *url = [NSURL URLWithString:strimg];
                
                [_imgProfile setImageWithURL:url placeholderImage:[UIImage imageNamed:@"ic_user"]];
            }
            
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:nil
                                         message:@"Profile picture is updated successfully." preferredStyle:UIAlertControllerStyleAlert];
            
            //Add Buttons
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            
                                            
                                        }];
            
            
            //Add your buttons to alert controller
            
            [alert addAction:yesButton];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        else if ([errorCode isEqualToString:@"0"])
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:nil
                                         message:message preferredStyle:UIAlertControllerStyleAlert];
            
            //Add Buttons
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            
                                            
                                        }];
            
            
            //Add your buttons to alert controller
            
            [alert addAction:yesButton];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        else if ([errorCode isEqualToString:@"2"])
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:nil
                                         message:message preferredStyle:UIAlertControllerStyleAlert];
            
            //Add Buttons
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            
                                            
                                        }];
            
            
            //Add your buttons to alert controller
            
            [alert addAction:yesButton];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            //                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
            //
            //                [alert show];
        }
        
        else if ([errorCode isEqualToString:@"3"])
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:nil
                                         message:message preferredStyle:UIAlertControllerStyleAlert];
            
            //Add Buttons
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            
                                            
                                        }];
            
            
            //Add your buttons to alert controller
            
            [alert addAction:yesButton];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            //                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
            //
            //                [alert show];
        }
        
        else
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:nil
                                         message:message preferredStyle:UIAlertControllerStyleAlert];
            
            //Add Buttons
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            
                                            
                                        }];
            
            
            //Add your buttons to alert controller
            
            [alert addAction:yesButton];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            //                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
            //
            //                [alert show];
        }
    });
}




-(void)wsRemoveProfile
{
    BaseViewController *base=[[BaseViewController alloc]init];
    NSString *user_id=[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSString *token = [defaults valueForKey:@"token"];
    NSString *strimg = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"profile_pic"]];
    
    NSArray *strold = [strimg componentsSeparatedByString:@"/"];
    
    NSString *strnew = [strold lastObject];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"image=%@&user_id=%@&action=%@&request=%@&key=%@&secret=%@&token=%@",strnew,user_id,@"delete",@"profile",str_key,str_secret,token];
    
    NSDictionary *dictionary =[[NSMutableDictionary alloc]init];
    
    dictionary=[base WebParsingMethod:stringWebServicesCompleteUrl :parameter];
    [GiFHUD dismiss];
    if(dictionary == (id)[NSNull null] || dictionary == nil)
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"Oops, cannot connect to server."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        
                                        
                                    }];
        
        
        //Add your buttons to alert controller
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Oops, cannot connect to server." delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
        //
        //            [alert show];
    }
    
    else
    {
        NSString *errorCode=[NSString stringWithFormat:@"%@",[dictionary  valueForKey:@"code"]];
        NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            if([errorCode isEqualToString:@"1"])
            {
                [defaults setObject:@"" forKey:@"profile_pic"];
                [_imgProfile setImage:[UIImage imageNamed:@"ic_user"]];
            }
            
            else if ([errorCode isEqualToString:@"0"])
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:message preferredStyle:UIAlertControllerStyleAlert];
                
                //Add Buttons
                
                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                
                                                
                                            }];
                
                
                //Add your buttons to alert controller
                
                [alert addAction:yesButton];
                
                [self presentViewController:alert animated:YES completion:nil];
                
                //                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                //
                //                [alert show];
            }
            
            else if ([errorCode isEqualToString:@"3"])
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:message preferredStyle:UIAlertControllerStyleAlert];
                
                //Add Buttons
                
                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                
                                                
                                            }];
                
                
                //Add your buttons to alert controller
                
                [alert addAction:yesButton];
                
                [self presentViewController:alert animated:YES completion:nil];
                
                //                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                //
                //                [alert show];
            }
            
            else
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:message preferredStyle:UIAlertControllerStyleAlert];
                
                //Add Buttons
                
                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                
                                                
                                            }];
                
                
                //Add your buttons to alert controller
                
                [alert addAction:yesButton];
                
                [self presentViewController:alert animated:YES completion:nil];
                
                //                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                //
                //                [alert show];
            }
        });
    }
}




@end
