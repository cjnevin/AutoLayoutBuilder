#if canImport(UIKit)

import UIKit

public struct Superview {
    public init() {}
}

public struct SizeLayoutDimension {
    let width: Anchor<NSLayoutDimension>
    let height: Anchor<NSLayoutDimension>
}

// MARK: - EqualTo Operators

// trailing == Superview()
public func == (lhs: ConstraintBuilder, rhs: Superview) -> [NSLayoutConstraint] {
    lhs.equalToSuperview()
}

// trailing == someView.leading
public func == (lhs: ConstraintBuilder, rhs: Anchor<NSLayoutXAxisAnchor>) -> [NSLayoutConstraint] {
    lhs.equalTo(rhs)
}

// top == someView.bottom
public func == (lhs: ConstraintBuilder, rhs: Anchor<NSLayoutYAxisAnchor>) -> [NSLayoutConstraint] {
    lhs.equalTo(rhs)
}

// width == someView.width
public func == (lhs: ConstraintBuilder, rhs: Anchor<NSLayoutDimension>) -> [NSLayoutConstraint] {
    lhs.equalTo(rhs)
}

// height == someView
public func == (lhs: ConstraintBuilder, rhs: Anchorable) -> [NSLayoutConstraint] {
    lhs.equalTo(rhs)
}

// width == 50
public func == (lhs: Anchor<NSLayoutDimension>, rhs: CGFloat) -> NSLayoutConstraint {
    lhs.dimension.constraint(equalToConstant: rhs)
}

// centerX == containerView.centerX
public func == <T: AnyObject>(lhs: Anchor<NSLayoutAnchor<T>>, rhs: Anchor<NSLayoutAnchor<T>>) -> NSLayoutConstraint {
    lhs.anchor.constraint(equalTo: rhs.anchor)
}

// size == CGSize(width: 50, height: 50)
public func == (lhs: SizeLayoutDimension, rhs: CGSize) -> [NSLayoutConstraint] {
    [lhs.width.dimension.constraint(equalToConstant: rhs.width), lhs.height.dimension.constraint(equalToConstant: rhs.height)]
}

// size == 50
public func == (lhs: SizeLayoutDimension, rhs: CGFloat) -> [NSLayoutConstraint] {
    [lhs.width.dimension.constraint(equalToConstant: rhs), lhs.height.dimension.constraint(equalToConstant: rhs)]
}

// MARK: - LessThanOrEqualTo Operators

// trailing <= Superview()
public func <= (lhs: ConstraintBuilder, rhs: Superview) -> [NSLayoutConstraint] {
    lhs.lessThanOrEqualToSuperview()
}

// trailing <= someView.leading
public func <= (lhs: ConstraintBuilder, rhs: Anchor<NSLayoutXAxisAnchor>) -> [NSLayoutConstraint] {
    lhs.lessThanOrEqualTo(rhs)
}

// top <= someView.bottom
public func <= (lhs: ConstraintBuilder, rhs: Anchor<NSLayoutYAxisAnchor>) -> [NSLayoutConstraint] {
    lhs.lessThanOrEqualTo(rhs)
}

// width <= someView.width
public func <= (lhs: ConstraintBuilder, rhs: Anchor<NSLayoutDimension>) -> [NSLayoutConstraint] {
    lhs.lessThanOrEqualTo(rhs)
}

// trailing <= containerView.trailing
public func <= <T: AnyObject>(lhs: Anchor<NSLayoutAnchor<T>>, rhs: Anchor<NSLayoutAnchor<T>>) -> NSLayoutConstraint {
    lhs.anchor.constraint(lessThanOrEqualTo: rhs.anchor)
}

// height <= someView
public func <= (lhs: ConstraintBuilder, rhs: Anchorable) -> [NSLayoutConstraint] {
    lhs.lessThanOrEqualTo(rhs)
}

// width <= 50
public func <= (lhs: Anchor<NSLayoutDimension>, rhs: CGFloat) -> NSLayoutConstraint {
    lhs.dimension.constraint(lessThanOrEqualToConstant: rhs)
}

// size <= CGSize(width: 50, height: 50)
public func <= (lhs: SizeLayoutDimension, rhs: CGSize) -> [NSLayoutConstraint] {
    [lhs.width.dimension.constraint(lessThanOrEqualToConstant: rhs.width), lhs.height.dimension.constraint(lessThanOrEqualToConstant: rhs.height)]
}

// size <= 50
public func <= (lhs: SizeLayoutDimension, rhs: CGFloat) -> [NSLayoutConstraint] {
    [lhs.width.dimension.constraint(lessThanOrEqualToConstant: rhs), lhs.height.dimension.constraint(lessThanOrEqualToConstant: rhs)]
}

// MARK: - GreaterThanOrEqualTo Operators

// trailing >= Superview()
public func >= (lhs: ConstraintBuilder, rhs: Superview) -> [NSLayoutConstraint] {
    lhs.greaterThanOrEqualToSuperview()
}

// leading >= someView.trailing
public func >= (lhs: ConstraintBuilder, rhs: Anchor<NSLayoutXAxisAnchor>) -> [NSLayoutConstraint] {
    lhs.greaterThanOrEqualTo(rhs)
}

// bottom >= someView.top
public func >= (lhs: ConstraintBuilder, rhs: Anchor<NSLayoutYAxisAnchor>) -> [NSLayoutConstraint] {
    lhs.greaterThanOrEqualTo(rhs)
}

// width >= someView.width
public func >= (lhs: ConstraintBuilder, rhs: Anchor<NSLayoutDimension>) -> [NSLayoutConstraint] {
    lhs.greaterThanOrEqualTo(rhs)
}

// height >= someView
public func >= (lhs: ConstraintBuilder, rhs: Anchorable) -> [NSLayoutConstraint] {
    lhs.greaterThanOrEqualTo(rhs)
}

// width >= 50
public func >= (lhs: Anchor<NSLayoutDimension>, rhs: CGFloat) -> NSLayoutConstraint {
    lhs.dimension.constraint(greaterThanOrEqualToConstant: rhs)
}

// leading >= containerView.leading
public func >= <T: AnyObject>(lhs: Anchor<NSLayoutAnchor<T>>, rhs: Anchor<NSLayoutAnchor<T>>) -> NSLayoutConstraint {
    lhs.anchor.constraint(lessThanOrEqualTo: rhs.anchor)
}

// size >= CGSize(width: 50, height: 50)
public func >= (lhs: SizeLayoutDimension, rhs: CGSize) -> [NSLayoutConstraint] {
    [lhs.width.dimension.constraint(greaterThanOrEqualToConstant: rhs.width), lhs.height.dimension.constraint(greaterThanOrEqualToConstant: rhs.height)]
}

// size >= 50
public func >= (lhs: SizeLayoutDimension, rhs: CGFloat) -> [NSLayoutConstraint] {
    [lhs.width.dimension.constraint(greaterThanOrEqualToConstant: rhs), lhs.height.dimension.constraint(greaterThanOrEqualToConstant: rhs)]
}

#endif
