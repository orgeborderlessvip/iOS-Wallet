//
//  MMPickerView.m
//  MMPickerView
//
//  Created by Madjid Mahdjoubi on 6/5/13.
//  Copyright (c) 2013 GG. All rights reserved.
//

#import "MMPickerView.h"

NSString * const MMbackgroundColor = @"backgroundColor";
NSString * const MMtextColor = @"textColor";
NSString * const MMtoolbarColor = @"toolbarColor";
NSString * const MMbuttonColor = @"buttonColor";
NSString * const MMfont = @"font";
NSString * const MMvalueY = @"yValueFromTop";
NSString * const MMselectedObject = @"selectedObject";
NSString * const MMselectedMoneyObject = @"selectedMoenyObject";
NSString * const MMtoolbarBackgroundImage = @"toolbarBackgroundImage";
NSString * const MMtextAlignment = @"textAlignment";
NSString * const MMshowsSelectionIndicator = @"showsSelectionIndicator";

@interface MMPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>{
    NSInteger selectedRow1;
}

@property (nonatomic, strong) UILabel *pickerViewLabel;
@property (nonatomic, strong) UIView *pickerViewLabelView;
@property (nonatomic, strong) UIView *pickerContainerView;
@property (nonatomic, strong) UIView *pickerViewContainerView;
@property (nonatomic, strong) UIView *pickerTopBarView;
@property (nonatomic, strong) UIImageView *pickerTopBarImageView;
@property (nonatomic, strong) UIToolbar *pickerViewToolBar;
@property (nonatomic, strong) UIBarButtonItem *pickerViewBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *cancelBtn;

@property (nonatomic, strong) UIButton *pickerDoneButton;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *pickerViewArray;
@property (nonatomic, strong) NSArray *pickerMoneyArray;

@property (nonatomic, strong) UIColor *pickerViewTextColor;
@property (nonatomic, strong) UIFont *pickerViewFont;
@property (nonatomic, assign) CGFloat yValueFromTop;
@property (nonatomic, assign) NSInteger pickerViewTextAlignment;
@property (nonatomic, assign) BOOL pickerViewShowsSelectionIndicator;
@property (copy) void (^onDismissCompletion)(NSString *, NSInteger index);
@property (copy) void (^onDismissCompletion1)(NSString *);

@property (copy) NSString *(^objectToStringConverter)(id object);
@property (copy) NSString *(^objectToStringConverter1)(id object);

@end


@implementation MMPickerView

#pragma mark - Singleton

+ (MMPickerView*)sharedView {
  static dispatch_once_t once;
  static MMPickerView *sharedView;
  dispatch_once(&once, ^ { sharedView = [[self alloc] init]; });
  return sharedView;
}

#pragma mark - Show Methods

+(void)showPickerViewInView:(UIView *)view
                withStrings:(NSArray *)strings
               withMoenyStr:(NSArray *)moenyStr
                withOptions:(NSDictionary *)options
                 completion:(void (^)(NSString *selectedString,NSInteger index))completion
                completion1:(void (^)(NSString *selectedString))completion1{
  
    
    [[self sharedView] initializePickerViewInView:view withArray:strings withMoenyArray:moenyStr withOptions:options];
    [[self sharedView] setPickerHidden:NO callBack:nil mcallBack:nil];
  [self sharedView].onDismissCompletion = completion;
    [self sharedView].onDismissCompletion1 = completion1;
  [view addSubview:[self sharedView]];
  
}
+(void)showPickerViewInView:(UIView *)view
                withStrings:(NSArray *)strings
                withOptions:(NSDictionary *)options
                 completion:(void (^)(NSString *,NSInteger index))completion{
    [[self sharedView] initializePickerViewInView:view withArray:strings withMoenyArray:nil withOptions:options];
    [[self sharedView] setPickerHidden:NO callBack:nil mcallBack:nil];

    [self sharedView].onDismissCompletion = completion;
    [self sharedView].onDismissCompletion1 = nil;

    [view addSubview:[self sharedView]];
    
}

#pragma mark - Dismiss Methods

+(void)dismissWithCompletion: (void(^)(NSString *,NSInteger index))completion Completion: (void(^)(NSString *))completion1{
    [[self sharedView] setPickerHidden:YES callBack:completion mcallBack:completion1];
}
//+(void)dismissWithCompletion:(void (^)(NSString *))completion{
//  [[self sharedView] setPickerHidden:YES callBack:completion];
//}


-(void)hiddenAction{
    [MMPickerView dismissWithCompletion:nil Completion:nil];

}
-(void)tapAction{
    [MMPickerView dismissWithCompletion:nil Completion:nil];
}
-(void)dismiss{
    [MMPickerView dismissWithCompletion:self.onDismissCompletion Completion:self.onDismissCompletion1];
//    [MMPickerView dismissWithCompletion:self.onDismissCompletion];
}

+(void)removePickerView{
  [[self sharedView] removeFromSuperview];
}

#pragma mark - Show/hide PickerView methods
//-(void)setPickerHidden: (BOOL)hidden
//              callBack: (void(^)(NSString *))callBack; {
//    
//    [UIView animateWithDuration:0.3
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveEaseOut
//                     animations:^{
//                         
//                         if (hidden) {
//                             [_pickerViewContainerView setAlpha:0.0];
//                             [_pickerContainerView setTransform:CGAffineTransformMakeTranslation(0.0, CGRectGetHeight(_pickerContainerView.frame))];
//                         } else {
//                             [_pickerViewContainerView setAlpha:1.0];
//                             [_pickerContainerView setTransform:CGAffineTransformIdentity];
//                         }
//                     } completion:^(BOOL completed) {
//                         if(completed && hidden){
//                             [MMPickerView removePickerView];
//                             callBack([self selectedObject]);
//                         }
//                     }];
//    
//}

-(void)setPickerHidden: (BOOL)hidden
              callBack: (void(^)(NSString *,NSInteger index))callBack mcallBack: (void(^)(NSString *))mcallBack {
  
  [UIView animateWithDuration:0.3
                        delay:0.0
                      options:UIViewAnimationOptionCurveEaseOut
                   animations:^{
                     
                     if (hidden) {
                       [_pickerViewContainerView setAlpha:0.0];
                       [_pickerContainerView setTransform:CGAffineTransformMakeTranslation(0.0, CGRectGetHeight(_pickerContainerView.frame))];
                     } else {
                       [_pickerViewContainerView setAlpha:1.0];
                       [_pickerContainerView setTransform:CGAffineTransformIdentity];
                     }
                   } completion:^(BOOL completed) {
                     if(completed && hidden){
                       [MMPickerView removePickerView];
                         if (callBack!=nil) {
                             callBack([self selectedObject],[self.pickerView selectedRowInComponent:0]);
                         }
                         if (mcallBack!=nil) {
                             mcallBack([self selectedObject1]);
                         }
                     }
                   }];
  
}

#pragma mark - Initialize PickerView

-(void)initializePickerViewInView: (UIView *)view
                        withArray: (NSArray *)array
                        withMoenyArray: (NSArray *)moneyArray
                      withOptions: (NSDictionary *)options {
  
  _pickerViewArray = array;
  id chosenObject = options[MMselectedObject];
  NSInteger selectedRow;
    
  if (chosenObject!=nil) {
    selectedRow = [_pickerViewArray indexOfObject:chosenObject];
  }else{
    selectedRow = [[_pickerViewArray objectAtIndex:0] integerValue];

  }
    if (moneyArray!=nil) {
        
         NSString *stringInt = [NSString stringWithFormat:@"%lu",(unsigned long)moneyArray.count];
        if ([moneyArray firstObject] > stringInt) {
            _pickerMoneyArray = moneyArray;
            id chosenObject1 = options[MMselectedMoneyObject];
            
            if (chosenObject1!=nil) {
                selectedRow1 = [_pickerMoneyArray indexOfObject:chosenObject1];
            }else{
                selectedRow1 = [[_pickerMoneyArray objectAtIndex:0] integerValue];
                
            }

        }else {
            _pickerMoneyArray = moneyArray;
            
            for (NSString *str in moneyArray) {
                id chosenObject1 = options[MMselectedMoneyObject];
                
                if (chosenObject1!=nil) {
                    selectedRow1 = [[_pickerMoneyArray objectAtIndex:0] integerValue];

//                    selectedRow1 = [str integerValue];
//                    selectedRow1 = [_pickerMoneyArray indexOfObject:chosenObject1];
                }else{
                    selectedRow1 = [str integerValue];

//                    selectedRow1 = [[_pickerMoneyArray objectAtIndex:0] integerValue];
                    
                }

            }
            
        }
        
    }
  NSNumber *textAlignment = [[NSNumber alloc] init];
  textAlignment = options[MMtextAlignment];
  //Default value is NSTextAlignmentCenter
  _pickerViewTextAlignment = 1;
  
  if (textAlignment != nil) {
  _pickerViewTextAlignment = [options[MMtextAlignment] integerValue];
  }
  
  BOOL showSelectionIndicator = [options[MMshowsSelectionIndicator] boolValue];
  
  if (!showSelectionIndicator) {
    _pickerViewShowsSelectionIndicator = 1;
  }
  _pickerViewShowsSelectionIndicator = showSelectionIndicator;
  
  UIColor *pickerViewBackgroundColor = [[UIColor alloc] initWithCGColor:[options[MMbackgroundColor] CGColor]];
  UIColor *pickerViewTextColor = [[UIColor alloc] initWithCGColor:[options[MMtextColor] CGColor]];
  UIColor *toolbarBackgroundColor = [[UIColor alloc] initWithCGColor:[options[MMtoolbarColor] CGColor]];
  UIColor *buttonTextColor = [[UIColor alloc] initWithCGColor:[options[MMbuttonColor] CGColor]];
  UIFont *pickerViewFont = nil;
  pickerViewFont = options[MMfont];
  _yValueFromTop = [options[MMvalueY] floatValue];
  
  [self setFrame: view.bounds];
  [self setBackgroundColor:[UIColor clearColor]];
  
  UIImage * toolbarImage = options[MMtoolbarBackgroundImage];
  
  //Whole screen with PickerView and a dimmed background
  _pickerViewContainerView = [[UIView alloc] initWithFrame:view.bounds];
  [_pickerViewContainerView setBackgroundColor: [UIColor colorWithRed:0.412 green:0.412 blue:0.412 alpha:0.7]];
  [self addSubview:_pickerViewContainerView];
  
    // 单击的 Recognizer
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    tapGesture.numberOfTapsRequired = 1;
    
    [_pickerViewContainerView addGestureRecognizer:tapGesture];
    
    
  //PickerView Container with top bar
  _pickerContainerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, _pickerViewContainerView.bounds.size.height - 260.0, mainWidth, 260.0)];
    
  //Default Color Values (if colors == nil)
  
  //PickerViewBackgroundColor - White
  if (pickerViewBackgroundColor==nil) {
    pickerViewBackgroundColor = [UIColor whiteColor];
  }
  
  //PickerViewTextColor - Black
  if (pickerViewTextColor==nil) {
    pickerViewTextColor = [UIColor blackColor];
  }
  _pickerViewTextColor = pickerViewTextColor;
  
  //ToolbarBackgroundColor - Black
  if (toolbarBackgroundColor==nil) {
    toolbarBackgroundColor = [UIColor colorWithRed:0.969 green:0.969 blue:0.969 alpha:0.8];
  }
  
  //ButtonTextColor - Blue
  if (buttonTextColor==nil) {
    buttonTextColor = [UIColor colorWithRed:0.000 green:0.486 blue:0.976 alpha:1];
  }
  
  if (pickerViewFont==nil) {
    _pickerViewFont = [UIFont systemFontOfSize:22];
  }
  _pickerViewFont = pickerViewFont;
  
  /*
   //ToolbackBackgroundImage - Clear Color
   if (toolbarBackgroundImage!=nil) {
   //Top bar imageView
   _pickerTopBarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, _pickerContainerView.frame.size.width, 44.0)];
   //[_pickerContainerView addSubview:_pickerTopBarImageView];
   _pickerTopBarImageView.image = toolbarBackgroundImage;
   [_pickerViewToolBar setHidden:YES];
   
   }
   */
  
  _pickerContainerView.backgroundColor = pickerViewBackgroundColor;
  [_pickerViewContainerView addSubview:_pickerContainerView];
  
  
  //Content of pickerContainerView
  
  //Top bar view
  _pickerTopBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, _pickerContainerView.frame.size.width, 44.0)];
  [_pickerContainerView addSubview:_pickerTopBarView];
  [_pickerTopBarView setBackgroundColor:[UIColor whiteColor]];
  
  
  _pickerViewToolBar = [[UIToolbar alloc] initWithFrame:_pickerTopBarView.frame];
  [_pickerContainerView addSubview:_pickerViewToolBar];
  
  CGFloat iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
  //DLog(@"%f",iOSVersion);
  if (iOSVersion < 7.0) {
    _pickerViewToolBar.tintColor = toolbarBackgroundColor;
    //[_pickerViewToolBar setBackgroundColor:toolbarBackgroundColor];
  }else{
     [_pickerViewToolBar setBackgroundColor:toolbarBackgroundColor];
     //_pickerViewToolBar.tintColor = toolbarBackgroundColor;
    #if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
    _pickerViewToolBar.barTintColor = toolbarBackgroundColor;
    #endif
  }
  
  if (toolbarImage!=nil) {
    [_pickerViewToolBar setBackgroundImage:toolbarImage forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
  }
  UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    _pickerViewBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:WDLocalizedString(@"确定") style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
                              
//                              initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismiss)];
   _cancelBtn = [[UIBarButtonItem alloc] initWithTitle:WDLocalizedString(@"取消") style:UIBarButtonItemStyleDone target:self action:@selector(hiddenAction)];
  _pickerViewToolBar.items = @[_cancelBtn,flexibleSpace, _pickerViewBarButtonItem];
  [_pickerViewBarButtonItem setTintColor:buttonTextColor];
  [_cancelBtn setTintColor:buttonTextColor];

  //[_pickerViewBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"Helvetica-Neue" size:23.0], UITextAttributeFont,nil] forState:UIControlStateNormal];
  
  /*
   _pickerDoneButton = [[UIButton alloc] initWithFrame:CGRectMake(_pickerContainerView.frame.size.width - 80.0, 10.0, 60.0, 24.0)];
   [_pickerDoneButton setTitle:@"Done" forState:UIControlStateNormal];
   [_pickerContainerView addSubview:_pickerDoneButton];
   [_pickerDoneButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
  */
  
  //Add pickerView
  _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0, 44.0, mainWidth, 216.0)];
  [_pickerView setDelegate:self];
  [_pickerView setDataSource:self];
  [_pickerView setShowsSelectionIndicator: _pickerViewShowsSelectionIndicator];//YES];
  [_pickerContainerView addSubview:_pickerView];
  
  //[self.pickerViewContainerView setAlpha:0.0];
  [_pickerContainerView setTransform:CGAffineTransformMakeTranslation(0.0, CGRectGetHeight(_pickerContainerView.frame))];
  
  //Set selected row
  [_pickerView selectRow:0 inComponent:0 animated:YES];
  [_pickerView selectRow:0 inComponent:0 animated:YES];

}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView {
  return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component {
  return [_pickerViewArray count];
}

- (NSString *)pickerView: (UIPickerView *)pickerView
             titleForRow: (NSInteger)row
            forComponent: (NSInteger)component {
  if (self.objectToStringConverter == nil){
    return [_pickerViewArray objectAtIndex:row];
  } else{
    return (self.objectToStringConverter ([_pickerViewArray objectAtIndex:row]));
  }
}

#pragma mark - UIPickerViewDelegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  if (self.objectToStringConverter == nil) {
      if (self.objectToStringConverter1 != nil) {
          //滑动的同时  是否赋值
          self.onDismissCompletion ([_pickerViewArray objectAtIndex:row],row);
          self.onDismissCompletion1([_pickerMoneyArray objectAtIndex:row]);
      }

  } else{
      
      if (_pickerMoneyArray!=nil) {
          self.onDismissCompletion1(self.objectToStringConverter1([self selectedObject1]));

      }
    self.onDismissCompletion (self.objectToStringConverter ([self selectedObject]),row);
  }
}

- (id)selectedObject {
    return [_pickerViewArray objectAtIndex: [self.pickerView selectedRowInComponent:0]];
}
- (id)selectedObject1 {
    return [_pickerMoneyArray objectAtIndex: [self.pickerView selectedRowInComponent:0]];
}
- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
  
  UIView *customPickerView = view;
  
  UILabel *pickerViewLabel;
  
  if (customPickerView==nil) {
    
    CGRect frame = CGRectMake(0.0, 0.0, 292.0, 44.0);
    customPickerView = [[UIView alloc] initWithFrame: frame];
    
//   UIImageView *patternImageView = [[UIImageView alloc] initWithFrame:frame];
//   patternImageView.image = [[UIImage imageNamed:@"texture"] resizableImageWithCapInsets:UIEdgeInsetsZero];
//    [customPickerView addSubview:patternImageView];
    
    if (_yValueFromTop == 0.0f) {
      _yValueFromTop = 3.0;
    }
    
    CGRect labelFrame = CGRectMake(0.0, _yValueFromTop, 292.0, 35); // 35 or 44
    pickerViewLabel = [[UILabel alloc] initWithFrame:labelFrame];
    [pickerViewLabel setTag:1];
    [pickerViewLabel setTextAlignment: _pickerViewTextAlignment];
    [pickerViewLabel setBackgroundColor:[UIColor clearColor]];
    [pickerViewLabel setTextColor:_pickerViewTextColor];
    [pickerViewLabel setFont:_pickerViewFont];
    [customPickerView addSubview:pickerViewLabel];
  } else{
    
    for (UIView *view in customPickerView.subviews) {
      if (view.tag == 1) {
        pickerViewLabel = (UILabel *)view;
        break;
      }
    }
  }
  
  if (self.objectToStringConverter == nil){
    [pickerViewLabel setText: [_pickerViewArray objectAtIndex:row]];
  } else{
    [pickerViewLabel setText:(self.objectToStringConverter ([_pickerViewArray objectAtIndex:row]))];
  }
  
  return customPickerView;

}


@end
