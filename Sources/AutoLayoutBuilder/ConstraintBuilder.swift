#if canImport(UIKit)

import UIKit

public struct ConstraintBuilder: ConstraintBuilding {
    public let anchorable: Anchorable

    private let anchorableBlock: (NSLayoutConstraint.Relation, Anchorable) -> [NSLayoutConstraint]
    private let anchorBlock: (NSLayoutConstraint.Relation, Anchor) -> [NSLayoutConstraint]
    private let superviewBlock: (NSLayoutConstraint.Relation) -> [NSLayoutConstraint]

    public func build(_ anchor: Anchor, constant: CGFloat, multiplier: CGFloat, priority: UILayoutPriority) -> ConstraintBuilder {
        combine(with: anchorable.build(anchor, constant: constant, multiplier: multiplier, priority: priority))
    }

    /// Constraint(s) equal to another view or layout guide for the same `KeyPath`.
    public func equalTo(_ otherView: Anchorable) -> [NSLayoutConstraint] {
        anchorableBlock(.equal, otherView)
    }

    /// Constraint(s) equal to another anchor.
    public func equalTo(_ otherAnchor: Anchor) -> [NSLayoutConstraint] {
        anchorBlock(.equal, otherAnchor)
    }

    /// Constraint(s) equal to superview.
    public func equalToSuperview() -> [NSLayoutConstraint] {
        superviewBlock(.equal)
    }

    /// Constraint(s) less than or equal to another view or layout guide for the same `KeyPath`.
    public func lessThanOrEqualTo(_ otherView: Anchorable) -> [NSLayoutConstraint] {
        anchorableBlock(.lessThanOrEqual, otherView)
    }

    /// Constraint(s) less than or equal to another anchor.
    public func lessThanOrEqualTo(_ otherAnchor: Anchor) -> [NSLayoutConstraint] {
        anchorBlock(.lessThanOrEqual, otherAnchor)
    }

    /// Constraint(s) less than or equal to superview.
    public func lessThanOrEqualToSuperview() -> [NSLayoutConstraint] {
        superviewBlock(.lessThanOrEqual)
    }

    /// Constraint(s) greater than or equal to another view or layout guide for the same `KeyPath`.
    public func greaterThanOrEqualTo(_ otherView: Anchorable) -> [NSLayoutConstraint] {
        anchorableBlock(.greaterThanOrEqual, otherView)
    }
    
    /// Constraint(s) greater than or equal to another anchor.
    public func greaterThanOrEqualTo(_ otherAnchor: Anchor) -> [NSLayoutConstraint] {
        anchorBlock(.greaterThanOrEqual, otherAnchor)
    }

    /// Constraint(s) greater than or equal to superview.
    public func greaterThanOrEqualToSuperview() -> [NSLayoutConstraint] {
        superviewBlock(.greaterThanOrEqual)
    }

    /// Flatten two constraints into a single `ConstraintBuilder`.
    public func combine(with other: ConstraintBuilder) -> ConstraintBuilder {
        assert(anchorable === other.anchorable)
        return ConstraintBuilder(
            anchorable: anchorable,
            anchorableBlock: {
                anchorableBlock($0, $1) + other.anchorableBlock($0, $1)
            },
            anchorBlock: {
                anchorBlock($0, $1) + other.anchorBlock($0, $1)
            },
            superviewBlock: {
                superviewBlock($0) + other.superviewBlock($0)
            }
        )
    }
}

extension ConstraintBuilder {
    public init(
        anchor lhs: Anchor,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        priority: UILayoutPriority = .required
    ) {
        var uiView: UIView? { lhs.anchorable as? UIView }
        var superview: UIView? { uiView?.superview }

        anchorableBlock = { relation, rhs in
            [
                lhs.constraint(
                    relation,
                    to: .init(anchorable: rhs, attribute: lhs.attribute),
                    constant: constant,
                    multiplier: multiplier
                )
            ]
        }
        anchorBlock = { relation, rhs in
            [
                lhs.constraint(
                    relation,
                    to: rhs,
                    constant: constant,
                    multiplier: multiplier
                )
            ]
        }
        superviewBlock = { relation in
            superview.map { rhs in
                lhs.constraint(
                    relation,
                    to: .init(anchorable: rhs, attribute: lhs.attribute),
                    constant: constant,
                    multiplier: multiplier
                )
            }.array
        }
        self.anchorable = lhs.anchorable
        uiView?.translatesAutoresizingMaskIntoConstraints = false
    }
}


private extension Optional {
    var array: [Wrapped] {
        [self].compactMap { $0 }
    }
}

#endif
