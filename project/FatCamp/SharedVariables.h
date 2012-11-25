//
//  SharedVariables.h
//  FatCamp
//
//  Created by Wen Shane on 12-10-8.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#ifndef FatCamp_SharedVariables_h
#define FatCamp_SharedVariables_h


#define APPSTORE
//#define WEIPHONE
//#define ZHUSHOU91
//#define TONGBU
//#define COCOACHINA



#ifdef DEBUG
#define CHANNEL_ID     @"test"
#elif defined(APPSTORE)
#define CHANNEL_ID @"appstore"
#elif defined(WEIPHONE)
#define CHANNEL_ID @"weiphone"
#elif defined(ZHUSHOU91)
#define CHANNEL_ID @"91"
#elif defined(TONGBU)
#define CHANNEL_ID @"tongbu"
#elif defined(COCOACHINA)
#define CHANNEL_ID @"COCOACHINA"
#endif

#define APP_KEY_UMENG   @"508f4a7b52701513ff000118"


#define RGB_DIV_255(x)      ((CGFloat)(x/255.0))


#define TOP_LINE_RECT    CGRectMake(20, 30, 280, 40)


#define MAIN_BGCOLOR        [UIColor colorWithRed:RGB_DIV_255(252) green:RGB_DIV_255(122) blue:RGB_DIV_255(24) alpha:1.0f]

#define MAIN_BGCOLOR_DEEP        [UIColor colorWithRed:RGB_DIV_255(169) green:RGB_DIV_255(100) blue:RGB_DIV_255(52) alpha:1.0f]



#define MAIN_BGCOLOR_SHALLOW        [UIColor colorWithRed:RGB_DIV_255(156) green:RGB_DIV_255(77) blue:RGB_DIV_255(21) alpha:1.0f]

#define MAIN_BGCOLOR_TRANSPARENT        [UIColor colorWithRed:RGB_DIV_255(252) green:RGB_DIV_255(122) blue:RGB_DIV_255(24) alpha:0.6f]


#define MAIN_BGCOLOR_MAINTEXT        [UIColor colorWithRed:RGB_DIV_255(255) green:RGB_DIV_255(118) blue:RGB_DIV_255(95) alpha:1.0f]

#define MAIN_BGCOLOR_MAINTEXT2        [UIColor colorWithRed:RGB_DIV_255(213) green:RGB_DIV_255(102) blue:RGB_DIV_255(12) alpha:1.0f]

#define MAIN_BGCOLOR_TABPAGE        [UIColor colorWithRed:RGB_DIV_255(243) green:RGB_DIV_255(243) blue:RGB_DIV_255(243) alpha:1.0f]

#define COLOR_TRIVAL_TEXT        [UIColor colorWithRed:RGB_DIV_255(114) green:RGB_DIV_255(114) blue:RGB_DIV_255(140) alpha:1.0f]

#define COLOR_WARTER_MARK   [UIColor colorWithRed:RGB_DIV_255(114) green:RGB_DIV_255(114) blue:RGB_DIV_255(140) alpha:0.2f]
#define MAIN_BGCOLOR_SHALLOWer        [UIColor colorWithRed:RGB_DIV_255(156) green:RGB_DIV_255(77) blue:RGB_DIV_255(21) alpha:0.7f]

#define SELECTED_CELL_COLOR [UIColor colorWithRed:RGB_DIV_255(223) green:RGB_DIV_255(179) blue:RGB_DIV_255(153) alpha:1.0f]

#define SELECTED_CELL_COLOR_TRANSPARENT [UIColor colorWithRed:RGB_DIV_255(223) green:RGB_DIV_255(179) blue:RGB_DIV_255(153) alpha:0.7f]

#define MAIN_BGCOLOR_GRADE1 [UIColor colorWithRed:RGB_DIV_255(255) green:RGB_DIV_255(245) blue:RGB_DIV_255(229) alpha:1.0f]

#define MAIN_BGCOLOR_GRADE2 [UIColor colorWithRed:RGB_DIV_255(255) green:RGB_DIV_255(235) blue:RGB_DIV_255(204) alpha:1.0f]

#define MAIN_BGCOLOR_GRADE3 [UIColor colorWithRed:RGB_DIV_255(255) green:RGB_DIV_255(224) blue:RGB_DIV_255(178) alpha:1.0f]

#define MAIN_BGCOLOR_GRADE4 [UIColor colorWithRed:RGB_DIV_255(255) green:RGB_DIV_255(214) blue:RGB_DIV_255(153) alpha:1.0f]

#endif //FatCamp_SharedVariables_h
