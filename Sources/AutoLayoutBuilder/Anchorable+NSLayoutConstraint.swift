#if canImport(UIKit)

import UIKit

extension Anchorable {
    /// Shortcut for `NSLayoutConstraint` which supports `priority`.
    public func width(equalTo constant: CGFloat, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        widthAnchor.constraint(equalToConstant: constant).updatePriority(priority)
    }

    /// Shortcut for `NSLayoutConstraint` which supports `priority`.
    public func width(lessThanOrEqualTo constant: CGFloat, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        widthAnchor.constraint(lessThanOrEqualToConstant: constant).updatePriority(priority)
    }

    /// Shortcut for `NSLayoutConstraint` which supports `priority`.
    public func width(greaterThanOrEqualTo constant: CGFloat, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        widthAnchor.constraint(greaterThanOrEqualToConstant: constant).updatePriority(priority)
    }

    /// Shortcut for `NSLayoutConstraint` which supports `priority`.
    public func height(equalTo constant: CGFloat, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        heightAnchor.constraint(equalToConstant: constant).updatePriority(priority)
    }

    /// Shortcut for `NSLayoutConstraint` which supports `priority`.
    public func height(lessThanOrEqualTo constant: CGFloat, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        heightAnchor.constraint(lessThanOrEqualToConstant: constant).updatePriority(priority)
    }

    /// Shortcut for `NSLayoutConstraint` which supports `priority`.
    public func height(greaterThanOrEqualTo constant: CGFloat, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        heightAnchor.constraint(greaterThanOrEqualToConstant: constant).updatePriority(priority)
    }

    /// Shortcut for `NSLayoutConstraint` for `width` and `height` by `CGSize`.
    public func size(equalTo constant: CGSize) -> [NSLayoutConstraint] {
        [width(equalTo: constant.width), height(equalTo: constant.height)]
    }

    /// Shortcut for `NSLayoutConstraint` for `width` and `height`.
    public func size(equalTo constant: CGFloat) -> [NSLayoutConstraint] {
        [width(equalTo: constant), height(equalTo: constant)]
    }
}

#endif
