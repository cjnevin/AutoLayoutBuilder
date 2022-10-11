#if canImport(UIKit)

import UIKit

public struct Superview {
    public init() {}
}

public struct SizeLayoutDimension {
    let width: NSLayoutDimension
    let height: NSLayoutDimension
}

// MARK: - EqualTo Operators

// trailing() == Superview()
public func == (lhs: ConstraintBuilder, rhs: Superview) -> [NSLayoutConstraint] {
    lhs.equalToSuperview()
}

// trailing() == someView.leadingAnchor
public func == (lhs: ConstraintBuilder, rhs: NSLayoutXAxisAnchor) -> [NSLayoutConstraint] {
    lhs.equalTo(rhs)
}

// top() == someView.bottomAnchor
public func == (lhs: ConstraintBuilder, rhs: NSLayoutYAxisAnchor) -> [NSLayoutConstraint] {
    lhs.equalTo(rhs)
}

// width() == someView.widthAnchor
public func == (lhs: ConstraintBuilder, rhs: NSLayoutDimension) -> [NSLayoutConstraint] {
    lhs.equalTo(rhs)
}

// height() == someView
public func == (lhs: ConstraintBuilder, rhs: Anchorable) -> [NSLayoutConstraint] {
    lhs.equalTo(rhs)
}

// widthAnchor == 50
public func == (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    lhs.constraint(equalToConstant: rhs)
}

// sizeAnchor == CGSize(width: 50, height: 50)
public func == (lhs: SizeLayoutDimension, rhs: CGSize) -> [NSLayoutConstraint] {
    [lhs.width.constraint(equalToConstant: rhs.width), lhs.height.constraint(equalToConstant: rhs.height)]
}

// sizeAnchor == 50
public func == (lhs: SizeLayoutDimension, rhs: CGFloat) -> [NSLayoutConstraint] {
    [lhs.width.constraint(equalToConstant: rhs), lhs.height.constraint(equalToConstant: rhs)]
}

// MARK: - LessThanOrEqualTo Operators

// trailing() <= Superview()
public func <= (lhs: ConstraintBuilder, rhs: Superview) -> [NSLayoutConstraint] {
    lhs.lessThanOrEqualToSuperview()
}

// trailing() <= someView.leadingAnchor
public func <= (lhs: ConstraintBuilder, rhs: NSLayoutXAxisAnchor) -> [NSLayoutConstraint] {
    lhs.lessThanOrEqualTo(rhs)
}

// top() <= someView.bottomAnchor
public func <= (lhs: ConstraintBuilder, rhs: NSLayoutYAxisAnchor) -> [NSLayoutConstraint] {
    lhs.lessThanOrEqualTo(rhs)
}

// width() <= someView.widthAnchor
public func <= (lhs: ConstraintBuilder, rhs: NSLayoutDimension) -> [NSLayoutConstraint] {
    lhs.lessThanOrEqualTo(rhs)
}

// height() <= someView
public func <= (lhs: ConstraintBuilder, rhs: Anchorable) -> [NSLayoutConstraint] {
    lhs.lessThanOrEqualTo(rhs)
}

// widthAnchor <= 50
public func <= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    lhs.constraint(lessThanOrEqualToConstant: rhs)
}

// sizeAnchor <= CGSize(width: 50, height: 50)
public func <= (lhs: SizeLayoutDimension, rhs: CGSize) -> [NSLayoutConstraint] {
    [lhs.width.constraint(lessThanOrEqualToConstant: rhs.width), lhs.height.constraint(lessThanOrEqualToConstant: rhs.height)]
}

// sizeAnchor <= 50
public func <= (lhs: SizeLayoutDimension, rhs: CGFloat) -> [NSLayoutConstraint] {
    [lhs.width.constraint(lessThanOrEqualToConstant: rhs), lhs.height.constraint(lessThanOrEqualToConstant: rhs)]
}

// MARK: - GreaterThanOrEqualTo Operators

// trailing() >= Superview()
public func >= (lhs: ConstraintBuilder, rhs: Superview) -> [NSLayoutConstraint] {
    lhs.greaterThanOrEqualToSuperview()
}

// leading() >= someView.trailingAnchor
public func >= (lhs: ConstraintBuilder, rhs: NSLayoutXAxisAnchor) -> [NSLayoutConstraint] {
    lhs.greaterThanOrEqualTo(rhs)
}

// bottom() >= someView.topAnchor
public func >= (lhs: ConstraintBuilder, rhs: NSLayoutYAxisAnchor) -> [NSLayoutConstraint] {
    lhs.greaterThanOrEqualTo(rhs)
}

// width() >= someView.widthAnchor
public func >= (lhs: ConstraintBuilder, rhs: NSLayoutDimension) -> [NSLayoutConstraint] {
    lhs.greaterThanOrEqualTo(rhs)
}

// height() >= someView
public func >= (lhs: ConstraintBuilder, rhs: Anchorable) -> [NSLayoutConstraint] {
    lhs.greaterThanOrEqualTo(rhs)
}

// widthAnchor >= 50
public func >= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    lhs.constraint(greaterThanOrEqualToConstant: rhs)
}

// sizeAnchor >= CGSize(width: 50, height: 50)
public func >= (lhs: SizeLayoutDimension, rhs: CGSize) -> [NSLayoutConstraint] {
    [lhs.width.constraint(greaterThanOrEqualToConstant: rhs.width), lhs.height.constraint(greaterThanOrEqualToConstant: rhs.height)]
}

// sizeAnchor >= 50
public func >= (lhs: SizeLayoutDimension, rhs: CGFloat) -> [NSLayoutConstraint] {
    [lhs.width.constraint(greaterThanOrEqualToConstant: rhs), lhs.height.constraint(greaterThanOrEqualToConstant: rhs)]
}

#endif
