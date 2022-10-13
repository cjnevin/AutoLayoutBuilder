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
    var firstBaselineAnchor: NSLayoutYAxisAnchor { get }
    var lastBaselineAnchor: NSLayoutYAxisAnchor { get }
}

public struct Anchor<T: AnyObject> {
    let anchor: NSLayoutAnchor<T>
}

extension Anchor where T == NSLayoutDimension {
    var dimension: NSLayoutDimension {
        anchor as! NSLayoutDimension
    }
}

extension Anchorable {
    public var left: Anchor<NSLayoutXAxisAnchor> { .init(anchor: leftAnchor) }
    public var right: Anchor<NSLayoutXAxisAnchor> { .init(anchor: rightAnchor) }
    public var leading: Anchor<NSLayoutXAxisAnchor> { .init(anchor: leadingAnchor) }
    public var trailing: Anchor<NSLayoutXAxisAnchor> { .init(anchor: trailingAnchor) }
    public var top: Anchor<NSLayoutYAxisAnchor> { .init(anchor: topAnchor) }
    public var bottom: Anchor<NSLayoutYAxisAnchor> { .init(anchor: bottomAnchor) }
    public var width: Anchor<NSLayoutDimension> { .init(anchor: widthAnchor) }
    public var height: Anchor<NSLayoutDimension> { .init(anchor: heightAnchor) }
    public var centerX: Anchor<NSLayoutXAxisAnchor> { .init(anchor: centerXAnchor) }
    public var centerY: Anchor<NSLayoutYAxisAnchor> { .init(anchor: centerYAnchor) }
}

extension BaselineAnchorable {
    public var firstBaseline: Anchor<NSLayoutYAxisAnchor> { .init(anchor: firstBaselineAnchor) }
    public var lastBaseline: Anchor<NSLayoutYAxisAnchor> { .init(anchor: lastBaselineAnchor) }
}

extension UILayoutGuide: Anchorable {
    public func buildXAxis(_ anchor: KeyPath<Anchorable, Anchor<NSLayoutXAxisAnchor>>, constant: CGFloat, priority: UILayoutPriority) -> ConstraintBuilder {
        .init(view: self, keyPath: anchor, constant: constant, priority: priority)
    }

    public func buildYAxis(_ anchor: KeyPath<Anchorable, Anchor<NSLayoutYAxisAnchor>>, constant: CGFloat, priority: UILayoutPriority) -> ConstraintBuilder {
        .init(view: self, keyPath: anchor, constant: constant, priority: priority)
    }

    public func buildDimension(_ anchor: KeyPath<Anchorable, Anchor<NSLayoutDimension>>, constant: CGFloat, multiplier: CGFloat, priority: UILayoutPriority) -> ConstraintBuilder {
        .init(view: self, keyPath: anchor, constant: constant, multiplier: multiplier, priority: priority)
    }

    public func buildBaseline(_ anchor: KeyPath<BaselineAnchorable, Anchor<NSLayoutYAxisAnchor>>, constant: CGFloat, priority: UILayoutPriority) -> ConstraintBuilder {
        fatalError("Setting baseline on a layoutGuide is not possible.")
    }
}

extension UIView: BaselineAnchorable {
    public func buildXAxis(_ anchor: KeyPath<Anchorable, Anchor<NSLayoutXAxisAnchor>>, constant: CGFloat, priority: UILayoutPriority) -> ConstraintBuilder {
        .init(view: self, keyPath: anchor, constant: constant, priority: priority)
    }

    public func buildYAxis(_ anchor: KeyPath<Anchorable, Anchor<NSLayoutYAxisAnchor>>, constant: CGFloat, priority: UILayoutPriority) -> ConstraintBuilder {
        .init(view: self, keyPath: anchor, constant: constant, priority: priority)
    }

    public func buildDimension(_ anchor: KeyPath<Anchorable, Anchor<NSLayoutDimension>>, constant: CGFloat, multiplier: CGFloat, priority: UILayoutPriority) -> ConstraintBuilder {
        .init(view: self, keyPath: anchor, constant: constant, multiplier: multiplier, priority: priority)
    }

    public func buildBaseline(_ anchor: KeyPath<BaselineAnchorable, Anchor<NSLayoutYAxisAnchor>>, constant: CGFloat, priority: UILayoutPriority) -> ConstraintBuilder {
        .init(view: self, keyPath: anchor, constant: constant, priority: priority)
    }
}

extension Anchorable {
    public var size: SizeLayoutDimension {
        .init(width: width, height: height)
    }

    /// Allows you to do some additional layout/styling within an `AutoLayoutBuilder` block.
    /// Useful for adding arranged subviews to a stackView for example.
    public func configure(_ work: (Self) -> Void) -> Constrainable {
        Configure(self, work: work)
    }

    /// Useful when you want to store multiple constraints with different `equalTo` configurations (i.e. `lessThan`, `greaterThan` or pointing at a different `Anchorable`).
    /// Typically, you collect the constraints to do something with the result, such as `store(in: &...)`.
    public func collect(@AutoLayoutBuilder work: (Self) -> Constrainable) -> Constrainable {
        Collect(self, work: work)
    }

    /// Allows for the storage of `[NSLayoutConstraint]` inside of `AutoLayoutBuilder` `@resultBuilder` blocks.
    /// ```
    /// addSubview(subView) {
    ///     $0.store(in: &edgeConstraints) {
    ///         $0.edges == self
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
    ///     $0.store(in: &widthConstraint) {
    ///         $0.width == 50
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
    ///     $0.store(.width, in: &widthConstraint) {
    ///         $0.leading.verticalEdges == self
    ///         $0.width == 50
    ///     }
    /// }
    /// ```
    public func store(_ attribute: NSLayoutConstraint.Attribute, in output: inout NSLayoutConstraint?, @AutoLayoutBuilder work: (Self) -> Constrainable) -> Constrainable {
        let collected = Collect(self, work: work)
        output = collected.constraints.first { $0.firstAttribute == attribute }
        return collected
    }

    /// Allows for the storage of `[NSLayoutConstraint]` inside of `AutoLayoutBuilder` `@resultBuilder` blocks.
    /// ```
    /// addSubview(subView) {
    ///     $0.store([.top, .bottom], in: &verticalConstraints) {
    ///         $0.leading.verticalEdges == self
    ///         $0.width == 50
    ///     }
    /// }
    /// ```
    public func store(_ attributes: [NSLayoutConstraint.Attribute], in output: inout [NSLayoutConstraint], @AutoLayoutBuilder work: (Self) -> Constrainable) -> Constrainable {
        let collected = Collect(self, work: work)
        output = collected.constraints.filter { attributes.contains($0.firstAttribute) }
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
