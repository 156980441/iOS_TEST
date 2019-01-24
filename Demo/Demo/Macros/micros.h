//
//  micros.h
//  Demo
//
//  Created by fanyl on 2019/1/24.
//  Copyright © 2019年 fanyl. All rights reserved.
//

#ifndef micros_h
#define micros_h

#define YLColorWithRGBA(r, g, b, a) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:a]
#define YLColorHexWithAlpha(hexValue, aplha) [UIColor colorWithRed:((CGFloat)((hexValue & 0xFF0000) >> 16))/255.0 green:((CGFloat)((hexValue & 0xFF00) >> 8))/255.0 blue:((CGFloat)(hexValue & 0xFF))/255.0 alpha:aplha]
#define YLColorHex(hexValue)                 YLColorHexWithAlpha(hexValue, 1.0)


#define YLColor_Title         YLColorHex(0x333333)
#define YLColor_Subtitle      YLColorHex(0x666666)
#define YLColor_Placeholder   YLColorHex(0xCCCCCC)
#define YLColor_Line          YLColorHex(0xE6E6E6)
#define YLColor_Disable       YLColorHex(0xD1D1D2)
#define YLColor_Module        YLColorHex(0xFFFFFF)
#define YLColor_Background    YLColorHex(0xF7F8FA)
#define YLColor_Red           YLColorHex(0xEE6560)
#define YLColor_Green         YLColorHex(0x4DB872)
#define YLColor_Blue          YLColorHex(0x4E88F0)
#define YLColor_Orange        YLColorHex(0xFF9E08)

#endif /* micros_h */
