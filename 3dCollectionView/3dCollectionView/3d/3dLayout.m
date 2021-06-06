//
//  3dLayout.m
//  3dCollectionView
//
//  Created by yunlong on 2021/6/6.
//

#import "3dLayout.h"

#define kScale 0.1

@implementation _dLayout


- (void)prepareLayout
{
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [super prepareLayout];
}

// 获取到可视范围内的cell，在cell的滑动过程中，通过cell偏移的距离来进行尺寸的缩放系数的设置
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    // 1.获取父类布局好的样式数组
    NSArray *superAttributes = [super layoutAttributesForElementsInRect:rect];
    // 2.防止出现问题，这里必须拷贝一遍
    NSArray *attributes = [[NSArray alloc] initWithArray:superAttributes copyItems:YES];
    // 3.计算出collectionView的中心的位置
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    // 4.根据当前的滚动，对每个 cell 进行相应的缩放
    [attributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat distance = centerX - attribute.center.x;
        // 越靠近中心，值越小，缩放系数越小，显示越大
        // 越远离中心，值越大，缩放就越大，显示就越小
        // 缩放的是高度，也就是Y轴，以ItemHeight计算缩放系数
        CGFloat scaleHeight = distance / self.itemSize.height;
        CGFloat scale = (1-kScale) + kScale * (1 - fabs(scaleHeight));
        attribute.transform3D = CATransform3DMakeScale(1, scale, 1);
        attribute.zIndex = 1;
    }];
    
    return attributes;
}

// 通过遍历目标区域中的cell，来计算出距离中心点最近的cell，把它调整到中间，实现平缓流畅的滑动结束的效果。
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
                                 withScrollingVelocity:(CGPoint)velocity {
    // 1.计算中心点的 x 值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    // 2.计算出最终显示的矩形框
    CGRect rect;
    rect.origin = CGPointMake(proposedContentOffset.x, proposedContentOffset.y);
    rect.size = self.collectionView.bounds.size;
    // 3.获取这个点可视范围内的布局属性
    NSArray<UICollectionViewLayoutAttributes *> *attrs = [self layoutAttributesForElementsInRect:rect];
    // 4. 需要移动的最小距离
    CGFloat moveDistance = MAXFLOAT;
    // 5.遍历数组找出最小距离
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        if (fabs(attr.center.x - centerX) < fabs(moveDistance)) {
            moveDistance = attr.center.x - centerX;
        }
    }
    // 6.返回一个新的偏移点
    proposedContentOffset.x += moveDistance;
    return proposedContentOffset;
}

// 滚动的时会调用
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds;
{
    return YES;
}

@end
