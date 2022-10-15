#if canImport(UIKit)

import UIKit

extension Anchorable {
    /// Constraints for right of `leading` and to left of `trailing`.
    public func horizontallyBetween(_ leading: Anchorable, and trailing: Anchorable, spacing: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        (self.leading(spacing, multiplier: multiplier, priority: priority) == leading.trailing)
        + (self.trailing(-spacing, multiplier: multiplier, priority: priority) == trailing.leading)
    }

    /// Constraints for bottom of `top` and to top of `bottom`.
    public func verticallyBetween(_ top: Anchorable, and bottom: Anchorable, spacing: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        (self.top(spacing, multiplier: multiplier, priority: priority) == top.bottom)
        + (self.bottom(-spacing, multiplier: multiplier, priority: priority) == bottom.top)
    }

    /// Shortcut for `NSLayoutConstraint` which supports `priority`.
    public func width(equalTo constant: CGFloat, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        (width == constant).updatePriority(priority)
    }

    /// Shortcut for `NSLayoutConstraint` which supports `priority`.
    public func width(lessThanOrEqualTo constant: CGFloat, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        (width <= constant).updatePriority(priority)
    }

    /// Shortcut for `NSLayoutConstraint` which supports `priority`.
    public func width(greaterThanOrEqualTo constant: CGFloat, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        (width >= constant).updatePriority(priority)
    }

    /// Shortcut for `NSLayoutConstraint` which supports `priority`.
    public func height(equalTo constant: CGFloat, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        (height == constant).updatePriority(priority)
    }

    /// Shortcut for `NSLayoutConstraint` which supports `priority`.
    public func height(lessThanOrEqualTo constant: CGFloat, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        (height <= constant).updatePriority(priority)
    }

    /// Shortcut for `NSLayoutConstraint` which supports `priority`.
    public func height(greaterThanOrEqualTo constant: CGFloat, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        (height >= constant).updatePriority(priority)
    }

    /// Shortcut for `NSLayoutConstraint` for `width` and `height` by `CGSize`.
    public func size(equalTo constant: CGSize) -> [NSLayoutConstraint] {
        size == constant
    }

    /// Shortcut for `NSLayoutConstraint` for `width` and `height` by `CGSize`.
    public func size(lessThanOrEqualTo constant: CGSize) -> [NSLayoutConstraint] {
        size <= constant
    }

    /// Shortcut for `NSLayoutConstraint` for `width` and `height` by `CGSize`.
    public func size(greaterThanOrEqualTo constant: CGSize) -> [NSLayoutConstraint] {
        size >= constant
    }

    /// Shortcut for `NSLayoutConstraint` for `width` and `height`.
    public func size(equalTo constant: CGFloat) -> [NSLayoutConstraint] {
        size == constant
    }

    /// Shortcut for `NSLayoutConstraint` for `width` and `height`.
    public func size(lessThanOrEqualTo constant: CGFloat) -> [NSLayoutConstraint] {
        size <= constant
    }

    /// Shortcut for `NSLayoutConstraint` for `width` and `height`.
    public func size(greaterThanOrEqualTo constant: CGFloat) -> [NSLayoutConstraint] {
        size >= constant
    }
}

#endif
