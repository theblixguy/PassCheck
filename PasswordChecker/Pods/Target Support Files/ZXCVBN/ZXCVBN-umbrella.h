#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "BBDateMatcher.h"
#import "BBDictionaryMatcher.h"
#import "BBDigitsMatcher.h"
#import "BBEntropyCenter.h"
#import "BBL33tMatcher.h"
#import "BBPasswordStrength.h"
#import "BBPattern.h"
#import "BBPatternCenter.h"
#import "BBPatternMatcher.h"
#import "BBRegularExpressionMatchHelper.h"
#import "BBRepeatMatcher.h"
#import "BBSequenceMatcher.h"
#import "BBSpatialMatcher.h"
#import "BBYearMatcher.h"
#import "ZXCVBN.h"

FOUNDATION_EXPORT double ZXCVBNVersionNumber;
FOUNDATION_EXPORT const unsigned char ZXCVBNVersionString[];

