//
//  FSDeepContentTextView.m
//  PeopleNewsReaderPhone
//
//  Created by people.com.cn on 12-11-13.
//
//

#import "FSDeepContentTextView.h"
#import "FSCommonFunction.h"
#import "FSHTTPWebExData.h"

#define FSDEEP_CONTENT_TEXT_TAG @"<div id='text_%d'>%@</div>"

#define FSDEEP_CONTENT_IMAGE_DIV_TAG @"<div id='image_%d' class='photo_section'></div>"

#define FSDEEP_CONTENT_DYNAMIC_IMAGE_TAG @"<a href='%@'><img src='%@' width='%.0f' height='%.0f' class='pictureBorder'/></a>"

#define FSDEEP_CONTENT_PICTURE_LEFT_RIGHT_SPACE 12.0f

#define FSDEEP_HTTP_SCHEME_PREFIX @"http"
#define FSDEEP_IMAGE_SCHEME_PREFIX @"image"
#define FSDEE_DYNAMIC_IMAGE_JS @"document.getElementById('image_%d').innerHTML=\"%@\""

@interface FSDeepContentTextView()
- (void)startDownloadPictures;
@end

@implementation FSDeepContentTextView
@synthesize contentObject = _contentObject;
@synthesize pictureFlag = _pictureFlag;
@synthesize textFlag = _textFlag;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        _webView.delegate = self;
        [self addSubview:_webView];
        
        _picURLs = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc {
    [_picURLs release];
    [_webView release];
    [super dealloc];
}

- (void)setFrame:(CGRect)value {
    BOOL needLayout = !(CGSizeEqualToSize(value.size, self.frame.size));
    [super setFrame:value];
    if (needLayout) {
        _webView.frame = CGRectMake(0.0f, 0.0f, value.size.width, value.size.height);
    }
}

- (void)setContentObject:(FSDeepContentObject *)value {
    if (value != _contentObject) {
        [_contentObject release];
        _contentObject = [value retain];
        
        [_picURLs removeAllObjects];
        
        dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
        dispatch_async(queue, ^{
            NSError *error = nil;
            NSString *htmlTemplate = [[NSString alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"deep_content_template.html"] encoding:NSUTF8StringEncoding error:&error];
            if (!error) {
                //FSLog(@"htmlTemplate:%@", htmlTemplate);
                //STEP 1.
                NSString *contentTitle = _contentObject.title;
                //{{title}}
                NSString *htmlString = [htmlTemplate stringByReplacingOccurrencesOfString:@"{{title}}" withString:toHTMLString(contentTitle)];
                //STEP 2.
                NSString *subTitle = nil;
                if ((_contentObject.pubDate != nil && ![_contentObject.pubDate isEqualToString:@""]) ||
                    (_contentObject.source != nil && ![_contentObject.source isEqualToString:@""])) {
                    
                    if (_contentObject.pubDate != nil && ![_contentObject.pubDate isEqualToString:@""] &&
                        _contentObject.source != nil && ![_contentObject.source isEqualToString:@""]) {
                        //全部存在
                        subTitle = [[NSString alloc] initWithFormat:@"%@    %@", _contentObject.pubDate, _contentObject.source];
                    } else if (_contentObject.pubDate != nil && ![_contentObject.pubDate isEqualToString:@""]) {
                        subTitle = [[NSString alloc] initWithFormat:@"%@", _contentObject.pubDate];
                    } else if (_contentObject.source != nil && ![_contentObject.source isEqualToString:@""]) {
                        subTitle = [[NSString alloc] initWithFormat:@"%@", _contentObject.source];
                    }
                    
                }
                //{{subtitle}}
                if (subTitle == nil) {
                    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"{{subtitle}}" withString:@""];
                } else {
                    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"{{subtitle}}" withString:toHTMLString(subTitle)];
                }
                [subTitle release];
                
                
                //STEP 3.
                NSMutableString *bodyString = [[NSMutableString alloc] init];
                NSArray *bodyElements = [[_contentObject.childContent allObjects] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                    FSDeepContent_ChildObject *childObj1 = (FSDeepContent_ChildObject *)obj1;
                    FSDeepContent_ChildObject *childObj2 = (FSDeepContent_ChildObject *)obj2;
                    NSInteger obj1Index = [childObj1.orderIndex intValue];
                    NSInteger obj2Index = [childObj2.orderIndex intValue];
                    if (obj1Index < obj2Index) {
                        return NSOrderedAscending;
                    } else if (obj1Index > obj2Index) {
                        return  NSOrderedDescending;
                    } else {
                        return NSOrderedSame;
                    }
                }];
                
                for (int i = 0; i < [bodyElements count]; i++) {
                    FSDeepContent_ChildObject *childObj = (FSDeepContent_ChildObject *)[bodyElements objectAtIndex:i];
                    if ([childObj.flag intValue] == _pictureFlag) {
                        //图片
                        [_picURLs setObject:childObj.content forKey:childObj.orderIndex];
                        
                        NSString *picDivTag = [[NSString alloc] initWithFormat:FSDEEP_CONTENT_IMAGE_DIV_TAG,  [childObj.orderIndex intValue]];
                        [bodyString appendString:picDivTag];
                        [picDivTag release];
                    } else if ([childObj.flag intValue] == _textFlag) {
                        //文字
                        NSString *textDivTag = [[NSString alloc] initWithFormat:FSDEEP_CONTENT_TEXT_TAG, [childObj.orderIndex intValue], toHTMLString(childObj.content)];
                        
                        [bodyString appendString:textDivTag];
                        [textDivTag release];
                    }
                }
                FSLog(@"bodyString:%@", bodyString);
                
                //{{body}}
                htmlString = [htmlString stringByReplacingOccurrencesOfString:@"{{body}}" withString:bodyString];
                
                //加载字符串
                NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
                [_webView loadHTMLString:htmlString baseURL:baseURL];
                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    //[self startDownloadPictures];
//                    [self performSelector:@selector(startDownloadPictures) withObject:nil afterDelay:0.5];
//                });
                
                [bodyString release];
            } else {
                FSLog(@"HTML Template error:%@", error);
            }
            [htmlTemplate release];

        });
        dispatch_release(queue);
    }
}


- (void)startDownloadPictures {
    NSArray *pictureKeys = [_picURLs allKeys];
    FSLog(@"_picURLs:%@", _picURLs);
    for (NSNumber *picKey in pictureKeys) {
        NSString *picURL = [_picURLs objectForKey:picKey];
        if (picURL) {
            NSString *picPath = getFileNameWithURLString(picURL, getCachesPath());
			NSString *imgURL = picURL;
			if ([[picURL lowercaseString] hasPrefix:FSDEEP_HTTP_SCHEME_PREFIX]) {
				NSRange range = {0, 4};
				imgURL = [picURL stringByReplacingCharactersInRange:range withString:FSDEEP_IMAGE_SCHEME_PREFIX];
			}
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:picPath]) {
                UIImage *image = [[UIImage alloc] initWithContentsOfFile:picPath];
                CGSize sizeTmp = scalImageSizeFixWidth(image, self.frame.size.width - FSDEEP_CONTENT_PICTURE_LEFT_RIGHT_SPACE * 2.0f);
                NSString *imgTag = [[NSString alloc] initWithFormat:FSDEEP_CONTENT_DYNAMIC_IMAGE_TAG, imgURL, picPath, sizeTmp.width, sizeTmp.height];
                NSString *jsString = [[NSString alloc] initWithFormat:FSDEE_DYNAMIC_IMAGE_JS, [picKey intValue], imgTag];
                FSLog(@"IMAGE.jsString:%@", jsString);
                [_webView stringByEvaluatingJavaScriptFromString:jsString];
                [imgTag release];
                [jsString release];
                [image release];
            } else {
                
                
                [FSNetworkData networkDataWithURLString:picURL withLocalStoreFileName:picPath withDelegate:self];
                //NSLog(@"loaclFile:%@",picPath);
                
//                [FSHTTPWebExData HTTPGetDataWithURLString:picURL blockCompletion:^(NSData *data, BOOL success) {
//                    if (success) {
//                        UIImage *image = [[UIImage alloc] initWithData:data];
//                        BOOL isImage = (image != nil);
//                        CGSize sizeTmp = scalImageSizeFixWidth(image, self.frame.size.width - FSDEEP_CONTENT_PICTURE_LEFT_RIGHT_SPACE * 2.0f);
//                        if (isImage) {
//                            [data writeToFile:picPath atomically:YES];
//                            NSString *imgTag = [NSString stringWithFormat:FSDEEP_CONTENT_DYNAMIC_IMAGE_TAG, imgURL, picPath, sizeTmp.width, sizeTmp.height];
//                            NSString *jsString = [NSString stringWithFormat:FSDEE_DYNAMIC_IMAGE_JS, [picKey intValue], imgTag];//[[NSString alloc] initWithFormat:FSDEE_DYNAMIC_IMAGE_JS, [picKey intValue], imgTag];
//                            FSLog(@"IMAGE.jsString.net:%@", jsString);
//                            //[_webView performSelector:@selector(stringByEvaluatingJavaScriptFromString:) withObject:jsString afterDelay:0.5];
//                            [_webView stringByEvaluatingJavaScriptFromString:jsString];
//                            //[imgTag release];
//                            //[jsString release];
//                        }
//                        
//                        [image release];
//                    }
//                }];
            }
        }
    }
}


-(void)networkDataDownloadDataComplete:(FSNetworkData *)sender isError:(BOOL)isError data:(NSData *)data{
    [self startDownloadPictures];
}


#pragma -
#pragma UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        NSString *urlStr = [[request URL] absoluteString];
        if ([[urlStr lowercaseString] hasPrefix:FSDEEP_IMAGE_SCHEME_PREFIX]) {
            if ([_delegate respondsToSelector:@selector(deepContentTextViewURLLink:)]) {
                [_delegate deepContentTextViewURLLink:urlStr];
            }
            return NO;
        }
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self startDownloadPictures];
    
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self startDownloadPictures];
//            //[self performSelector:@selector(startDownloadPictures) withObject:nil afterDelay:0.5];
//        });
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

@end
