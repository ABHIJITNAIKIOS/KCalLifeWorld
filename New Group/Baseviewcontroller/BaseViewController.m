//
//  BaseViewController.m

//
//  Created by Mackintosh on 04/03/14.
//  Copyright (c) 2014 Panacea. All rights reserved.
//

#import "BaseViewController.h"
#import "Reachability.h"
#import "AFHTTPSessionManager.h"
@interface BaseViewController ()

@end

@implementation BaseViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        // Custom initialization
    }
    
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}




-(NSDictionary *)WebParsingMethod:(NSString *)strCompleteURL : (NSString *)jsonRequest
{
    __block NSDictionary *jsonDict;
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable)
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"Turn on internet connection or use Wi-Fi to access data."
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
        // Setting error as nil
        NSError *error = nil;
        //Setting the URL of JSON
        NSURL *URL = [NSURL URLWithString:strCompleteURL];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
        
        jsonRequest = [jsonRequest
                       stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        NSString *length = [NSString stringWithFormat:@"%lu", (unsigned long)[jsonRequest length]];
        [request setValue:length forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
        [request setHTTPBody:[jsonRequest dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        
        NSString* strResponse = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(@"strResponse=%@",strResponse);
        
        if(!error)
        {
            jsonDict = [NSJSONSerialization JSONObjectWithData:responseData
                                                       options:kNilOptions
                                                         error:&error];
            
            // Print the value of the JSON.
            NSLog(@"JSON: %@", jsonDict);
        }
    }
    
    return jsonDict;
}




-(NSData *)sendSynchronousRequest:(NSURLRequest *)request
                returningResponse:(__autoreleasing NSURLResponse **)responsePtr
                            error:(__autoreleasing NSError **)errorPtr
{
    dispatch_semaphore_t    sem;
    __block NSData *        result;
    
    result = nil;
    
    sem = dispatch_semaphore_create(0);
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask= [manager dataTaskWithRequest:request
                  uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
                      
                  } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
                      
                  } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      
                      if (error)
                      {
                          NSLog(@"Error: %@", error);
                      }
                      
                      else
                      {
                          NSLog(@"Success: %@ %@", response, responseObject);
                          
                          result=responseObject;
                      }
                  }];
    
    [dataTask resume];
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    
    return result;
}




@end
