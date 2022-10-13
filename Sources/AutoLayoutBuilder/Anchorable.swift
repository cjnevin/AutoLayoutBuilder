#if canImport(UIKit)

import UIKit

public protocol Anchorable: AnyObject, ConstraintBuilding {
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

extension UILayoutGuide: Anchorable {
    public func buildXAxis(_ anchor: KeyPath<Anchorable, NSLayoutXAxisAnchor>, constant: CGFloat, priority: UILayoutPriority) -> ConstraintBuilder {
        .init(view: self, keyPath: anchor, constant: constant, priority: priority)
    }

    public func buildYAxis(_ anchor: KeyPath<Anchorable, NSLayoutYAxisAnchor>, constant: CGFloat, priority: UILayoutPriority) -> ConstraintBuilder {
        .init(view: self, keyPath: anchor, constant: constant, priority: priority)
    }

    public func buildDimension(_ anchor: KeyPath<Anchorable, NSLayoutDimension>, constant: CGFloat, multiplier: CGFloat, priority: UILayoutPriority) -> ConstraintBuilder {
        .init(view: self, keyPath: anchor, constant: constant, multiplier: multiplier, priority: priority)
    }

    public func buildBaseline(_ anchor: KeyPath<BaselineAnchorable, NSLayoutYAxisAnchor>, constant: CGFloat, priority: UILayoutPriority) -> ConstraintBuilder {
        fatalError("Setting baseline on a layoutGuide is not possible.")
    }
}

extension UIView: BaselineAnchorable {
    public func buildXAxis(_ anchor: KeyPath<Anchorable, NSLayoutXAxisAnchor>, constant: CGFloat, priority: UILayoutPriority) -> ConstraintBuilder {
        .init(view: self, keyPath: anchor, constant: constant, priority: priority)
    }

    public func buildYAxis(_ anchor: KeyPath<Anchorable, NSLayoutYAxisAnchor>, constant: CGFloat, priority: UILayoutPriority) -> ConstraintBuilder {
        .init(view: self, keyPath: anchor, constant: constant, priority: priority)
    }

    public func buildDimension(_ anchor: KeyPath<Anchorable, NSLayoutDimension>, constant: CGFloat, multiplier: CGFloat, priority: UILayoutPriority) -> ConstraintBuilder {
        .init(view: self, keyPath: anchor, constant: constant, multiplier: multiplier, priority: priority)
    }

    public func buildBaseline(_ anchor: KeyPath<BaselineAnchorable, NSLayoutYAxisAnchor>, constant: CGFloat, priority: UILayoutPriority) -> ConstraintBuilder {
        .init(view: self, keyPath: anchor, constant: constant, priority: priority)
    }
}

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

    /// Allows for the storage of `[NSLayoutConstraint]` inside of `AutoLayoutBuilder` `@resultBuilder` blocks.
    /// ```
    /// addSubview(subView) {
    ///     $0.store(in: &edgeConstraints) {
    ///         $0.edges() == self
    ///     }
    /// }
    /// ```
    public func store(in output: inout [NSLayoutConstraint], @AutoLayoutBuilder work: (Self) -> Constrainable) -> Constrainable {
        let collected = Collect(self, work: work)
        output = collected.constraints
        return collected
    }

    /// Allows for the storage of `NSLayoutConstraint?` inside of `AutoLayoutBuilder` `@resultBuilder` blocks.
    /// ```
    /// addSubview(subView) {
    ///     $0.store(in: &optionalWidthAnchor) {
    ///         $0.widthAnchor == 50
    ///     }
    /// }
    /// ```
    public func store(in output: inout NSLayoutConstraint?, @AutoLayoutBuilder work: (Self) -> Constrainable) -> Constrainable {
        let collected = Collect(self, work: work)
        output = collected.constraints.first
        return collected
    }

    /// Allows for the storage of `NSLayoutConstraint?` inside of `AutoLayoutBuilder` `@resultBuilder` blocks.
    /// ```
    /// addSubview(subView) {
    ///     $0.store(\.width, in: &optionalWidthAnchor) {
    ///         $0.leading().verticalEdges() == self
    ///         $0.widthAnchor == 50
    ///     }
    /// }
    /// ```
    public func store(_ attribute: NSLayoutConstraint.Attribute, in output: inout NSLayoutConstraint?, @AutoLayoutBuilder work: (Self) -> Constrainable) -> Constrainable {
        let collected = Collect(self, work: work)
        output = collected.constraints.first { $0.firstAttribute == attribute }
        return collected
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
