#if canImport(UIKit)

import UIKit

public protocol Anchorable: AnyObject {
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

public protocol BaselineAnchorable: Anchorable {
    var lastBaselineAnchor: NSLayoutYAxisAnchor { get }
    var firstBaselineAnchor: NSLayoutYAxisAnchor { get }
}

extension UILayoutGuide: Anchorable {}

extension UIView: BaselineAnchorable {}

extension Anchorable {
    public var sizeAnchor: SizeLayoutDimension {
        .init(width: widthAnchor, height: heightAnchor)
    }

    /// Allows you to do some additional layout/styling within an `AutoLayoutBuilder` block.
    /// Useful for adding arranged subviews to a stackView for example.
    public func configure(_ work: (Self) -> Void) -> Constrainable {
        Configure(self, work: work)
    }

    /// Allows for collection of several constraints useful for then storing them using `store(in: &...)` functions.
    public func collect(@AutoLayoutBuilder work: (Self) -> Constrainable) -> Constrainable {
        Collect(self, work: work)
    }
}

private struct Configure: Constrainable {
    let constraints: [NSLayoutConstraint] = []
    init<T>(_ object: T, work: (T) -> Void) {
        work(object)
    }
}

private struct Collect: Constrainable {
    let constraints: [NSLayoutConstraint]
    init<T>(_ object: T, @AutoLayoutBuilder work: (T) -> Constrainable) {
        constraints = work(object).constraints
    }
}

#endif
