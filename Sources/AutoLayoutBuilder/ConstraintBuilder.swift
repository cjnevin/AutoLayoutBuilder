#if canImport(UIKit)

import UIKit

private extension NSLayoutAnchor {
    @objc func constraint(
        _ relation: NSLayoutConstraint.Relation,
        to anchor: NSLayoutAnchor<AnchorType>,
        constant: CGFloat,
        priority: UILayoutPriority
    ) -> NSLayoutConstraint {
        switch relation {
        case .equal:
            return constraint(equalTo: anchor, constant: constant)
                .updatePriority(priority)
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualTo: anchor, constant: constant)
                .updatePriority(priority)
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualTo: anchor, constant: constant)
                .updatePriority(priority)
        @unknown default:
            fatalError("Unknown relation")
        }
    }
}

private extension NSLayoutDimension {
    func constraint(
        _ relation: NSLayoutConstraint.Relation,
        to anchor: NSLayoutDimension,
        constant: CGFloat,
        multiplier: CGFloat,
        priority: UILayoutPriority
    ) -> NSLayoutConstraint {
        switch relation {
        case .equal:
            return constraint(equalTo: anchor, multiplier: multiplier, constant: constant)
                .updatePriority(priority)
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
                .updatePriority(priority)
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
                .updatePriority(priority)
        @unknown default:
            fatalError("Unknown relation")
        }
    }
}

public struct ConstraintBuilder {
    let view: Anchorable

    private let anchorableBlock: (NSLayoutConstraint.Relation, Anchorable) -> [NSLayoutConstraint]
    private let xAxisBlock: (NSLayoutConstraint.Relation, NSLayoutXAxisAnchor) -> [NSLayoutConstraint]
    private let yAxisBlock: (NSLayoutConstraint.Relation,NSLayoutYAxisAnchor) -> [NSLayoutConstraint]
    private let dimensionBlock: (NSLayoutConstraint.Relation,NSLayoutDimension) -> [NSLayoutConstraint]
    private let superviewBlock: (NSLayoutConstraint.Relation) -> [NSLayoutConstraint]

    /// Constraint(s) equal to another view or layout guide for the same `KeyPath`.
    public func equalTo(_ otherView: Anchorable) -> [NSLayoutConstraint] {
        anchorableBlock(.equal, otherView)
    }

    /// Constraint(s) equal to another X anchor.
    public func equalTo(_ otherAnchor: NSLayoutXAxisAnchor) -> [NSLayoutConstraint] {
        xAxisBlock(.equal, otherAnchor)
    }

    /// Constraint(s) equal to another Y anchor.
    public func equalTo(_ otherAnchor: NSLayoutYAxisAnchor) -> [NSLayoutConstraint] {
        yAxisBlock(.equal, otherAnchor)
    }

    /// Constraint(s) equal to another dimension.
    public func equalTo(_ otherAnchor: NSLayoutDimension) -> [NSLayoutConstraint] {
        dimensionBlock(.equal, otherAnchor)
    }

    /// Constraint(s) equal to superview.
    public func equalToSuperview() -> [NSLayoutConstraint] {
        superviewBlock(.equal)
    }

    /// Constraint(s) less than or equal to another view or layout guide for the same `KeyPath`.
    public func lessThanOrEqualTo(_ otherView: Anchorable) -> [NSLayoutConstraint] {
        anchorableBlock(.lessThanOrEqual, otherView)
    }

    /// Constraint(s) less than or equal to another X anchor.
    public func lessThanOrEqualTo(_ otherAnchor: NSLayoutXAxisAnchor) -> [NSLayoutConstraint] {
        xAxisBlock(.lessThanOrEqual, otherAnchor)
    }

    /// Constraint(s) less than or equal to another Y anchor.
    public func lessThanOrEqualTo(_ otherAnchor: NSLayoutYAxisAnchor) -> [NSLayoutConstraint] {
        yAxisBlock(.lessThanOrEqual, otherAnchor)
    }

    /// Constraint(s) less than or equal to another dimension.
    public func lessThanOrEqualTo(_ otherAnchor: NSLayoutDimension) -> [NSLayoutConstraint] {
        dimensionBlock(.lessThanOrEqual, otherAnchor)
    }

    /// Constraint(s) less than or equal to superview.
    public func lessThanOrEqualToSuperview() -> [NSLayoutConstraint] {
        superviewBlock(.lessThanOrEqual)
    }

    /// Constraint(s) greater than or equal to another view or layout guide for the same `KeyPath`.
    public func greaterThanOrEqualTo(_ otherView: Anchorable) -> [NSLayoutConstraint] {
        anchorableBlock(.greaterThanOrEqual, otherView)
    }

    /// Constraint(s) greater than or equal to another X anchor.
    public func greaterThanOrEqualTo(_ otherAnchor: NSLayoutXAxisAnchor) -> [NSLayoutConstraint] {
        xAxisBlock(.greaterThanOrEqual, otherAnchor)
    }

    /// Constraint(s) greater than or equal to another Y anchor.
    public func greaterThanOrEqualTo(_ otherAnchor: NSLayoutYAxisAnchor) -> [NSLayoutConstraint] {
        yAxisBlock(.greaterThanOrEqual, otherAnchor)
    }

    /// Constraint(s) greater than or equal to another dimension.
    public func greaterThanOrEqualTo(_ otherAnchor: NSLayoutDimension) -> [NSLayoutConstraint] {
        dimensionBlock(.greaterThanOrEqual, otherAnchor)
    }

    /// Constraint(s) greater than or equal to superview.
    public func greaterThanOrEqualToSuperview() -> [NSLayoutConstraint] {
        superviewBlock(.greaterThanOrEqual)
    }

    /// Flatten two constraints into a single `ConstraintBuilder`.
    public func combine(with other: ConstraintBuilder) -> ConstraintBuilder {
        assert(view === other.view)
        return ConstraintBuilder(
            view: view,
            anchorableBlock: {
                anchorableBlock($0, $1) + other.anchorableBlock($0, $1)
            },
            xAxisBlock: {
                xAxisBlock($0, $1) + other.xAxisBlock($0, $1)
            },
            yAxisBlock: {
                yAxisBlock($0, $1) + other.yAxisBlock($0, $1)
            },
            dimensionBlock: {
                dimensionBlock($0, $1) + other.dimensionBlock($0, $1)
            },
            superviewBlock: {
                superviewBlock($0) + other.superviewBlock($0)
            }
        )
    }
}

extension ConstraintBuilder {
    public init(
        view: Anchorable,
        keyPath: KeyPath<Anchorable, NSLayoutXAxisAnchor>,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) {
        var uiView: UIView? { view as? UIView }
        var superview: UIView? { uiView?.superview }
        let anchor = view[keyPath: keyPath]

        self.view = view

        anchorableBlock = { relation, otherAnchorable in
            [anchor.constraint(relation, to: otherAnchorable[keyPath: keyPath], constant: constant, priority: priority)]
        }
        xAxisBlock = { relation, otherAnchor in
            [anchor.constraint(relation, to: otherAnchor, constant: constant, priority: priority)]
        }
        yAxisBlock = { _, _ in [] }
        dimensionBlock = { _, _ in [] }
        superviewBlock = { relation in
            superview.map { anchor.constraint(relation, to: $0[keyPath: keyPath], constant: constant, priority: priority) }.array
        }
        uiView?.translatesAutoresizingMaskIntoConstraints = false
    }

    public init(
        view: Anchorable,
        keyPath: KeyPath<Anchorable, NSLayoutYAxisAnchor>,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) {
        var uiView: UIView? { view as? UIView }
        var superview: UIView? { uiView?.superview }
        let anchor = view[keyPath: keyPath]

        self.view = view

        anchorableBlock = { relation, otherAnchorable in
            [anchor.constraint(relation, to: otherAnchorable[keyPath: keyPath], constant: constant, priority: priority)]
        }
        xAxisBlock = { _, _ in [] }
        yAxisBlock = { relation, otherAnchor in
            [anchor.constraint(relation, to: otherAnchor, constant: constant, priority: priority)]
        }
        dimensionBlock = { _, _ in [] }
        superviewBlock = { relation in
            superview.map { anchor.constraint(relation, to: $0[keyPath: keyPath], constant: constant, priority: priority) }.array
        }

        uiView?.translatesAutoresizingMaskIntoConstraints = false
    }

    public init(
        view: BaselineAnchorable,
        keyPath: KeyPath<BaselineAnchorable, NSLayoutYAxisAnchor>,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) {
        var uiView: UIView? { view as? UIView }
        var superview: UIView? { uiView?.superview }
        let anchor = view[keyPath: keyPath]

        self.view = view

        anchorableBlock = { relation, otherAnchorable in
            (otherAnchorable as? BaselineAnchorable).map {
                anchor.constraint(relation, to: $0[keyPath: keyPath], constant: constant, priority: priority)
            }.array
        }
        xAxisBlock = { _, _ in [] }
        yAxisBlock = { relation, otherAnchor in
            [anchor.constraint(relation, to: otherAnchor, constant: constant, priority: priority)]
        }
        dimensionBlock = { _, _ in [] }
        superviewBlock = { relation in
            superview.map { anchor.constraint(relation, to: $0[keyPath: keyPath], constant: constant, priority: priority) }.array
        }

        uiView?.translatesAutoresizingMaskIntoConstraints = false
    }

    public init(
        view: Anchorable,
        keyPath: KeyPath<Anchorable, NSLayoutDimension>,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority = .required
    ) {
        var uiView: UIView? { view as? UIView }
        var superview: UIView? { uiView?.superview }
        let anchor = view[keyPath: keyPath]

        self.view = view

        anchorableBlock = { relation, otherAnchorable in
            [anchor.constraint(relation, to: otherAnchorable[keyPath: keyPath], constant: constant, priority: priority)]
        }
        xAxisBlock = { _, _ in [] }
        yAxisBlock = { _, _ in [] }
        dimensionBlock = { relation, otherAnchor in
            [anchor.constraint(relation, to: otherAnchor, constant: constant, multiplier: multiplier, priority: priority)]
        }
        superviewBlock = { relation in
            superview.map { anchor.constraint(relation, to: $0[keyPath: keyPath], constant: constant, priority: priority) }.array
        }
        uiView?.translatesAutoresizingMaskIntoConstraints = false
    }
}

private extension Optional {
    var array: [Wrapped] {
        [self].compactMap { $0 }
    }
}

#endif
