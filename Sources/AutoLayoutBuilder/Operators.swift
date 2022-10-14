#if canImport(UIKit)

import UIKit

public struct Superview {
    public init() {}
}

// MARK: - EqualTo Operators

// trailing == Superview()
public func == (lhs: ConstraintBuilder, rhs: Superview) -> [NSLayoutConstraint] {
    lhs.equalToSuperview()
}

// trailing == someView.leading
public func == (lhs: ConstraintBuilder, rhs: Anchor) -> [NSLayoutConstraint] {
    lhs.equalTo(rhs)
}

// height == someView
public func == (lhs: ConstraintBuilder, rhs: Anchorable) -> [NSLayoutConstraint] {
    lhs.equalTo(rhs)
}

// width == 50
public func == (lhs: Anchor, rhs: CGFloat) -> NSLayoutConstraint {
    lhs.constraint(.equal, to: rhs)
}

// centerX == containerView.centerX
public func == (lhs: Anchor, rhs: Anchor) -> NSLayoutConstraint {
    lhs.constraint(.equal, to: rhs)
}

// size == CGSize(width: 50, height: 50)
public func == (lhs: SizeAnchor, rhs: CGSize) -> [NSLayoutConstraint] {
    [
        lhs.width.constraint(.equal, to: rhs.width),
        lhs.height.constraint(.equal, to: rhs.height)
    ]
}

// size == 50
public func == (lhs: SizeAnchor, rhs: CGFloat) -> [NSLayoutConstraint] {
    lhs == CGSize(width: rhs, height: rhs)
}

// MARK: - LessThanOrEqualTo Operators

// trailing <= Superview()
public func <= (lhs: ConstraintBuilder, rhs: Superview) -> [NSLayoutConstraint] {
    lhs.lessThanOrEqualToSuperview()
}

// trailing <= someView.leading
public func <= (lhs: ConstraintBuilder, rhs: Anchor) -> [NSLayoutConstraint] {
    lhs.lessThanOrEqualTo(rhs)
}

// trailing <= containerView.trailing
public func <= (lhs: Anchor, rhs: Anchor) -> NSLayoutConstraint {
    lhs.constraint(.lessThanOrEqual, to: rhs)
}

// height <= someView
public func <= (lhs: ConstraintBuilder, rhs: Anchorable) -> [NSLayoutConstraint] {
    lhs.lessThanOrEqualTo(rhs)
}

// width <= 50
public func <= (lhs: Anchor, rhs: CGFloat) -> NSLayoutConstraint {
    lhs.constraint(.lessThanOrEqual, to: rhs)
}

// size <= CGSize(width: 50, height: 50)
public func <= (lhs: SizeAnchor, rhs: CGSize) -> [NSLayoutConstraint] {
    [
        lhs.width.constraint(.lessThanOrEqual, to: rhs.width),
        lhs.height.constraint(.lessThanOrEqual, to: rhs.height)
    ]
}

// size <= 50
public func <= (lhs: SizeAnchor, rhs: CGFloat) -> [NSLayoutConstraint] {
    lhs <= CGSize(width: rhs, height: rhs)
}

// MARK: - GreaterThanOrEqualTo Operators

// trailing >= Superview()
public func >= (lhs: ConstraintBuilder, rhs: Superview) -> [NSLayoutConstraint] {
    lhs.greaterThanOrEqualToSuperview()
}

// leading >= someView.trailing
public func >= (lhs: ConstraintBuilder, rhs: Anchor) -> [NSLayoutConstraint] {
    lhs.greaterThanOrEqualTo(rhs)
}

// height >= someView
public func >= (lhs: ConstraintBuilder, rhs: Anchorable) -> [NSLayoutConstraint] {
    lhs.greaterThanOrEqualTo(rhs)
}

// width >= 50
public func >= (lhs: Anchor, rhs: CGFloat) -> NSLayoutConstraint {
    lhs.constraint(.greaterThanOrEqual, to: rhs)
}

// leading >= containerView.leading
public func >= (lhs: Anchor, rhs: Anchor) -> NSLayoutConstraint {
    lhs.constraint(.greaterThanOrEqual, to: rhs)
}

// size >= CGSize(width: 50, height: 50)
public func >= (lhs: SizeAnchor, rhs: CGSize) -> [NSLayoutConstraint] {
    [
        lhs.width.constraint(.greaterThanOrEqual, to: rhs.width),
        lhs.height.constraint(.greaterThanOrEqual, to: rhs.height)
    ]
}

// size >= 50
public func >= (lhs: SizeAnchor, rhs: CGFloat) -> [NSLayoutConstraint] {
    lhs >= CGSize(width: rhs, height: rhs)
}

#endif
