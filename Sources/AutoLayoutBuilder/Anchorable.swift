import UIKit

public protocol Anchorable: AnyObject, ConstraintBuilding {}

public protocol BaselineAnchorable: Anchorable {}

extension Anchorable {
    func anchor(_ attribute: NSLayoutConstraint.Attribute) -> Anchor {
        .init(anchorable: self, attribute: attribute)
    }

    public var left: Anchor { anchor(.left) }
    public var right: Anchor { anchor(.right) }
    public var leading: Anchor { anchor(.leading) }
    public var trailing: Anchor { anchor(.trailing) }
    public var top: Anchor { anchor(.top) }
    public var bottom: Anchor { anchor(.bottom) }
    public var width: Anchor { anchor(.width) }
    public var height: Anchor { anchor(.height) }
    public var centerX: Anchor { anchor(.centerX) }
    public var centerY: Anchor { anchor(.centerY) }
}

extension BaselineAnchorable {
    public var firstBaseline: Anchor { anchor(.firstBaseline) }
    public var lastBaseline: Anchor { anchor(.lastBaseline) }
}

extension UILayoutGuide: Anchorable {
    public var anchorable: Anchorable { self }
    public func build(_ anchor: Anchor, constant: CGFloat, multiplier: CGFloat, priority: UILayoutPriority) -> ConstraintBuilder {
        .init(
            anchor: anchor,
            constant: constant,
            multiplier: multiplier,
            priority: priority
        )
    }
}

extension UIView: BaselineAnchorable {
    public var anchorable: Anchorable { self }
    public func build(_ anchor: Anchor, constant: CGFloat, multiplier: CGFloat, priority: UILayoutPriority) -> ConstraintBuilder {
        .init(
            anchor: anchor,
            constant: constant,
            multiplier: multiplier,
            priority: priority
        )
    }
}

extension Anchorable {
    public var size: SizeAnchor {
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
