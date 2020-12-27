//
//  SMRGeometry.h
//  demoforlayout
//
//  Created by Tinswin on 2020/12/26.
//

#ifndef SMRGeometry_h
#define SMRGeometry_h

UIKIT_STATIC_INLINE UIEdgeInsets SafeAreaInsets() {
    if (@available(iOS 11.0, *)) {
        return [UIApplication sharedApplication].windows.firstObject.safeAreaInsets;
    } else {
        return UIEdgeInsetsZero;
    }
}

UIKIT_STATIC_INLINE CGFloat StatusBarHeight() {
    if (@available(iOS 11.0, *)) {
        return SafeAreaInsets().top ?: 20;
    } else {
        return 20;
    }
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

CG_INLINE CGPoint CGPointInPadding(CGPoint point, UIEdgeInsets padding) {
    return CGPointMake(point.x + padding.left, point.y + padding.top);
}

CG_INLINE CGSize CGSizeInPadding(CGSize size, UIEdgeInsets padding) {
    CGFloat width = size.width - padding.left - padding.right;
    CGFloat height = size.height - padding.top - padding.bottom;
    return CGSizeMake((width > 0) ? width : size.width, (height > 0) ? height : size.height);
}

CG_INLINE CGRect CGRectInPadding(CGRect rect, UIEdgeInsets padding) {
    CGPoint point = CGPointInPadding(rect.origin, padding);
    CGSize size = CGSizeInPadding(rect.size, padding);
    return CGRectMake(point.x, point.y, size.width, size.height);
}

CG_INLINE CGPoint CGPointAddPadding(CGPoint point, UIEdgeInsets padding) {
    return CGPointMake(point.x + padding.left, point.y + padding.top);
}

CG_INLINE CGSize CGSizeAddPadding(CGSize size, UIEdgeInsets padding) {
    CGFloat width = size.width + padding.left + padding.right;
    CGFloat height = size.height + padding.top + padding.bottom;
    return CGSizeMake(width, height);
    
}

CG_INLINE CGRect CGRectAddPadding(CGRect rect, UIEdgeInsets padding) {
    CGPoint point = CGPointAddPadding(rect.origin, padding);
    CGSize size = CGSizeAddPadding(rect.size, padding);
    return CGRectMake(point.x, point.y, size.width, size.height);
}

CG_INLINE CGSize CGSizeNoZero(CGSize size1, CGSize size2) {
    return CGSizeMake(size1.width ?: size2.width, size1.height ?: size2.height);
}

CG_INLINE CGSize CGSizeMaxSize(CGSize size1, CGSize size2) {
    return CGSizeMake(MAX(size1.width, size2.width), MAX(size1.height, size2.height));
}

CG_INLINE CGSize CGSizeMaxWidth(CGSize size1, CGFloat sizeWidth) {
    return CGSizeMake(MAX(size1.width, sizeWidth), size1.height);
}

CG_INLINE CGSize CGSizeMaxHeight(CGSize size1, CGFloat sizeHeight) {
    return CGSizeMake(size1.width, MAX(size1.height, sizeHeight));
}

CG_INLINE CGSize CGSizeAdd(CGSize size1, CGSize size2) {
    return CGSizeMake(size1.width + size2.width, size1.height + size2.height);
}

CG_INLINE CGSize CGSizeSubtract(CGSize size1, CGSize size2) {
    return CGSizeMake(size1.width - size2.width, size1.height - size2.height);
}

CG_INLINE CGSize CGSizeMultiply(CGSize size, CGPoint point) {
    return CGSizeMake(size.width*point.x, size.height*point.y);
}

#endif /* SMRGeometry_h */
