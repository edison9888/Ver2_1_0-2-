//
//  FSBlogShareContentView.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-8.
//
//

#import "FSBlogShareContentView.h"
#import <QuartzCore/QuartzCore.h>

#define SEND_MSG_LEFT_RIGHT_SPACE 8.0f
#define SEND_MSG_TOP_BOTTOM_SPACE 44.0f
#define SEND_MSG_COL_SPACE 4.0f
#define SEND_MSG_ROW_SPACE 4.0f


@implementation FSBlogShareContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)doSomethingAtDealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [_tvContent release];
    [_imageView release];
    [_at_button release];
}

-(void)doSomethingAtInit{
    _tvContent = [[UITextView alloc] initWithFrame:CGRectMake(6, 6, 300, 200)];
    _tvContent.layer.cornerRadius = 6.0f;
	_tvContent.layer.masksToBounds = YES;
	_tvContent.layer.borderColor = [UIColor colorWithRed:204.0f / 255.0f green:204.0f / 255.0f blue:204.0f / 255.0f alpha:1.0f].CGColor;
	_tvContent.layer.borderWidth = 1.0f;
    //_tvContent.delegate = self;
    
	[_tvContent setFont:[UIFont systemFontOfSize:18.0f]];
    [_tvContent setTextColor:[UIColor blackColor]];
	//[_tvContent setTextColor:[UIColor colorWithRed:170.0f / 255.0f green:170.0f / 255.0f blue:170.0f /255.0f alpha:1.0f]];
	[_tvContent setBackgroundColor:[UIColor colorWithRed:242.0f /255.0f green:242.0f /255.0f blue:242.0f /255.0f alpha:1.0f]];
	_tvContent.backgroundColor = [UIColor colorWithRed:239.0f / 255.0f green:239.0f / 255.0f blue:239.0f /255.0f alpha:1.0f];
    
    
    _imageView = [[UIImageView alloc] init];
    
    
    _at_button = [[UIButton alloc] init];
    [_at_button setBackgroundImage:[UIImage imageNamed:@"at.png"] forState:UIControlStateNormal];
    [_at_button addTarget:self action:@selector(addAtUser:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addSubview:_tvContent];
    [self addSubview:_imageView];
    [self addSubview:_at_button];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWasShown:)
												 name:UIKeyboardWillShowNotification object:nil];
    
}


-(void)doSomethingAtLayoutSubviews{
    CGFloat top = SEND_MSG_LEFT_RIGHT_SPACE;
    _tvContent.frame = CGRectMake(SEND_MSG_LEFT_RIGHT_SPACE, top, self.frame.size.width - SEND_MSG_LEFT_RIGHT_SPACE * 2.0f, 200 - top - SEND_MSG_TOP_BOTTOM_SPACE);
    _tvContent.text = self.shareContent;
    if (_dataContent != nil) {
        _imageView.image = [UIImage imageWithData:self.dataContent];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.frame = CGRectMake(SEND_MSG_LEFT_RIGHT_SPACE, top + 200, self.frame.size.width - SEND_MSG_LEFT_RIGHT_SPACE * 2.0f, self.frame.size.height - 200 - top - SEND_MSG_TOP_BOTTOM_SPACE);
    }
    else{
        [_tvContent becomeFirstResponder];
    }
    
}

-(void)addAtUser:(id)sender{
    _tvContent.text = [NSString stringWithFormat:@"%@%@",_tvContent.text,@"@"];
}

-(NSString *)getShareContent{
    return _tvContent.text;
}

-(void)resignalTvContent{
    [_tvContent resignFirstResponder];
}

#pragma mark -
#pragma mark 键盘弹出尺寸布局
- (void)keyboardWasShown:(NSNotification*)aNotification {
#ifdef MYDEBUG
	NSLog(@"keyboardWasShown:%@", aNotification);
#endif
	NSDictionary *info = [aNotification userInfo];
	NSValue *value = nil;//[info objectForKey:UIKeyboardBoundsUserInfoKey];//UIKeyboardFrameEndUserInfoKey
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
		value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
	} else {
#ifndef IOS_3_2_LATER
		value = [info objectForKey:UIKeyboardBoundsUserInfoKey];
#endif
	}
    
	CGSize keyboardSize = [value CGRectValue].size;
#ifdef MYDEBUG
	NSLog(@"keyboardSize.w=%f;h=%f{__keyboardSize.w=%f;h=%f}", keyboardSize.width, keyboardSize.height, _keyboardSize.width, _keyboardSize.height);
#endif
	if (_keyboardSize.width == keyboardSize.width &&
		_keyboardSize.height == keyboardSize.height) {
		return;
	}
	_keyboardSize = keyboardSize;
	
	
	CGSize clientSize = self.frame.size;//getCurrentViewFrameWithKeyboardSize(keyboardSize, self.interfaceOrientation, self);
	
	NSLog(@"clientSize.height1:%f",clientSize.height);
	clientSize.height = clientSize.height - _keyboardSize.height;
	
	NSLog(@"clientSize.height2:%f",clientSize.height);
	//[self showWriteUserInterfaceWithSize:clientSize];
	
	//STEP 1.
	CGFloat top = SEND_MSG_LEFT_RIGHT_SPACE;
    _tvContent.frame = CGRectMake(SEND_MSG_LEFT_RIGHT_SPACE, top, self.frame.size.width - SEND_MSG_LEFT_RIGHT_SPACE * 2.0f, clientSize.height - top - SEND_MSG_TOP_BOTTOM_SPACE);
    _at_button.frame = CGRectMake(SEND_MSG_LEFT_RIGHT_SPACE*3, top + _tvContent.frame.size.height+SEND_MSG_LEFT_RIGHT_SPACE, 25, 25);
}



@end
