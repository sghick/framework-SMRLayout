//
//  SMRBoxing.h
//  demoforlayout
//
//  Created by Tinswin on 2020/12/21.
//

#ifndef SMRBoxing_h
#define SMRBoxing_h

#import "SMRBox.h"

static SMRBox * box(void (^block)(SMRBox *set)) {
    return [SMRBox layout:block];
}

static SMRRow * row(void (^block)(SMRRow *set)) {
    return [SMRRow layout:block];
}

static SMRColumn * column(void (^block)(SMRColumn *set)) {
    return [SMRColumn layout:block];
}

UIKIT_STATIC_INLINE UIEdgeInsets UIEdgeInsetsMakeAll(CGFloat all) {
    UIEdgeInsets insets = {all, all, all, all};
    return insets;
}

UIKIT_STATIC_INLINE UIEdgeInsets UIEdgeInsetsMakeOnlyTop(CGFloat top) {
    UIEdgeInsets insets = {top, 0, 0, 0};
    return insets;
}

UIKIT_STATIC_INLINE UIEdgeInsets UIEdgeInsetsMakeOnlyLeft(CGFloat left) {
    UIEdgeInsets insets = {0, left, 0, 0};
    return insets;
}

UIKIT_STATIC_INLINE UIEdgeInsets UIEdgeInsetsMakeOnlyBottom(CGFloat bottom) {
    UIEdgeInsets insets = {0, 0, bottom, 0};
    return insets;
}

UIKIT_STATIC_INLINE UIEdgeInsets UIEdgeInsetsMakeOnlyRight(CGFloat right) {
    UIEdgeInsets insets = {0, 0, 0, right};
    return insets;
}

#endif /* SMRBoxing_h */
