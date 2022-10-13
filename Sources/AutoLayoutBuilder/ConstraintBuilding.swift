#if canImport(UIKit)

import UIKit

public protocol ConstraintBuilding {
    public func buildXAxis(
        _ anchor: KeyPath<Anchorable, NSLayoutXAxisAnchor>,
        constant: CGFloat,
        priority: UILayoutPriority
    ) -> ConstraintBuilder

    public func buildYAxis(
        _ anchor: KeyPath<Anchorable, NSLayoutYAxisAnchor>,
        constant: CGFloat,
        priority: UILayoutPriority
    ) -> ConstraintBuilder

    public func buildDimension(
        _ anchor: KeyPath<Anchorable, NSLayoutDimension>,
        constant: CGFloat,
        multiplier: CGFloat,
        priority: UILayoutPriority
    ) -> ConstraintBuilder

    public func buildBaseline(
        _ anchor: KeyPath<BaselineAnchorable, NSLayoutYAxisAnchor>,
        constant: CGFloat,
        priority: UILayoutPriority
    ) -> ConstraintBuilder
}

extension ConstraintBuilding {
    /// Create builder for `left` constraint.
    public func left(_ constant: CGFloat = 0, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        buildXAxis(\.leftAnchor, constant: constant, priority: priority)
    }

    /// Create builder for `left` constraint.
    public var left: ConstraintBuilder { left() }

    /// Create builder for `right` constraint.
    /// You are responsible for passing in a positive/negative value.
    public func right(_ constant: CGFloat = 0, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        buildXAxis(\.rightAnchor, constant: constant, priority: priority)
    }

    /// Create builder for `right` constraint.
    public var right: ConstraintBuilder { right() }

    /// Create builder for `leading` constraint.
    public func leading(_ constant: CGFloat = 0, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        buildXAxis(\.leadingAnchor, constant: constant, priority: priority)
    }

    /// Create builder for `leading` constraint.
    public var leading: ConstraintBuilder { leading() }

    /// Create builder for `trailing` constraint.
    /// You are responsible for passing in a positive/negative value.
    public func trailing(_ constant: CGFloat = 0, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        buildXAxis(\.trailingAnchor, constant: constant, priority: priority)
    }

    /// Create builder for `trailing` constraint.
    public var trailing: ConstraintBuilder { trailing() }

    /// Create builder for `top` constraint.
    public func top(_ constant: CGFloat = 0, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        buildYAxis(\.topAnchor, constant: constant, priority: priority)
    }

    /// Create builder for `top` constraint.
    public var top: ConstraintBuilder { top() }

    /// Create builder for `bottom` constraint.
    /// You are responsible for passing in a positive/negative value.
    public func bottom(_ constant: CGFloat = 0, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        buildYAxis(\.bottomAnchor, constant: constant, priority: priority)
    }

    /// Create builder for `bottom` constraint.
    public var bottom: ConstraintBuilder { bottom() }

    /// Create builder for `centerX` constraint.
    public func centerX(_ constant: CGFloat = 0, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        buildXAxis(\.centerXAnchor, constant: constant, priority: priority)
    }

    /// Create builder for `centerX` constraint.
    public var centerX: ConstraintBuilder { centerX() }

    /// Create builder for `centerY` constraint.
    public func centerY(_ constant: CGFloat = 0, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        buildYAxis(\.centerYAnchor, constant: constant, priority: priority)
    }

    /// Create builder for `centerY` constraint.
    public var centerY: ConstraintBuilder { centerY() }

    /// Create builder for `width` constraint.
    public func width(_ constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        buildDimension(\.widthAnchor, constant: constant, multiplier: multiplier, priority: priority)
    }

    /// Create builder for `width` constraint.
    public var width: ConstraintBuilder { width() }

    /// Create builder for `height` constraint.
    public func height(_ constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        buildDimension(\.heightAnchor, constant: constant, multiplier: multiplier, priority: priority)
    }

    /// Create builder for `height` constraint.
    public var height: ConstraintBuilder { height() }

    /// Create builder for `top`, `leading`, `trailing` and `bottom` constraints for `constant`.
    /// `trailing` value will be flipped to negative if `constant.right` is non-zero.
    /// `bottom` value will be flipped to negative if `constant.bottom` is non-zero.
    public func edges(
        _ constant: UIEdgeInsets = .zero,
        topPriority: UILayoutPriority = .required,
        leadingPriority: UILayoutPriority = .required,
        trailingPriority: UILayoutPriority = .required,
        bottomPriority: UILayoutPriority = .required
    ) -> ConstraintBuilder {
        top(constant.top, priority: topPriority)
            .leading(constant.left, priority: leadingPriority)
            .trailing(-constant.right, priority: trailingPriority)
            .bottom(-constant.bottom, priority: bottomPriority)
    }

    /// Create builder for `top`, `leading`, `trailing` and `bottom` constraints for `constant`.
    /// `trailing` value will be flipped to negative if `constant.right` is non-zero.
    /// `bottom` value will be flipped to negative if `constant.bottom` is non-zero.
    public func edges(
        _ constant: UIEdgeInsets = .zero,
        allEdgePriorities: UILayoutPriority
    ) -> ConstraintBuilder {
        edges(
            constant,
            topPriority: allEdgePriorities,
            leadingPriority: allEdgePriorities,
            trailingPriority: allEdgePriorities,
            bottomPriority: allEdgePriorities
        )
    }

    /// Create builder for `top`, `leading`, `trailing` and `bottom` constraints.
    public var edges: ConstraintBuilder { edges() }

    /// Create builder for `top`, `leading`, `trailing` and `bottom` constraints for `constant`.
    /// `trailing` value will be flipped to negative if `constant` is non-zero.
    /// `bottom` value will be flipped to negative if `constant` is non-zero.
    public func edges(
        _ constant: CGFloat,
        topPriority: UILayoutPriority = .required,
        leadingPriority: UILayoutPriority = .required,
        trailingPriority: UILayoutPriority = .required,
        bottomPriority: UILayoutPriority = .required
    ) -> ConstraintBuilder {
        top(constant, priority: topPriority)
            .leading(constant, priority: leadingPriority)
            .trailing(-constant, priority: trailingPriority)
            .bottom(-constant, priority: bottomPriority)
    }

    /// Create builder for `top`, `leading`, `trailing` and `bottom` constraints for `constant`.
    /// `trailing` value will be flipped to negative if `constant` is non-zero.
    /// `bottom` value will be flipped to negative if `constant` is non-zero.
    public func edges(
        _ constant: CGFloat,
        allEdgePriorities: UILayoutPriority
    ) -> ConstraintBuilder {
        edges(
            constant,
            topPriority: allEdgePriorities,
            leadingPriority: allEdgePriorities,
            trailingPriority: allEdgePriorities,
            bottomPriority: allEdgePriorities
        )
    }

    /// Create builder for `leading` and `trailing` constraints for `constant`.
    /// `trailing` value will be flipped to negative if `constant` is non-zero.
    public func horizontalEdges(
        _ constant: CGFloat = 0,
        leadingPriority: UILayoutPriority = .required,
        trailingPriority: UILayoutPriority = .required
    ) -> ConstraintBuilder {
        leading(constant, priority: leadingPriority)
            .trailing(-constant, priority: trailingPriority)
    }

    /// Create builder for `leading` and `trailing` constraints.
    public var horizontalEdges: ConstraintBuilder { horizontalEdges() }

    /// Create builder for `top` and `bottom` constraints for `constant`.
    /// `bottom` value will be flipped to negative if `constant` is non-zero.
    public func verticalEdges(
        _ constant: CGFloat = 0,
        topPriority: UILayoutPriority = .required,
        bottomPriority: UILayoutPriority = .required
    ) -> ConstraintBuilder {
        top(constant, priority: topPriority)
            .bottom(-constant, priority: bottomPriority)
    }

    /// Create builder for `top` and `bottom` constraints.
    public var verticalEdges: ConstraintBuilder { verticalEdges() }

    /// Create builder for `centerX` and `centerY` constraints.
    public func center(
        _ constant: CGPoint = .zero,
        centerXPriority: UILayoutPriority = .required,
        centerYPriority: UILayoutPriority = .required
    ) -> ConstraintBuilder {
        centerX(constant.x, priority: centerXPriority)
            .centerY(constant.y, priority: centerYPriority)
    }

    /// Create builder for `centerX` and `centerY` constraints.
    public var center: ConstraintBuilder { center() }

    /// Create builder for `width` and `height` constraints.
    public func size(
        _ constant: CGSize = .zero,
        multiplier: CGFloat = 1,
        widthPriority: UILayoutPriority = .required,
        heightPriority: UILayoutPriority = .required
    ) -> ConstraintBuilder {
        width(constant.width, multiplier: multiplier, priority: widthPriority)
            .height(constant.height, multiplier: multiplier, priority: heightPriority)
    }

    /// Create builder for `width` and `height` constraints.
    public var size: ConstraintBuilder { size() }
}

extension ConstraintBuilding where Self: BaselineAnchorable {
    /// Create builder for `firstBaseline` constraint.
    public func firstBaseline(_ constant: CGFloat = 0, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        buildBaseline(\.firstBaselineAnchor, constant: constant, priority: priority)
    }

    /// Create builder for `firstBaseline` constraint.
    public var firstBaseline: ConstraintBuilder { firstBaseline() }

    /// Create builder for `lastBaseline` constraint.
    public func lastBaseline(_ constant: CGFloat = 0, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        buildBaseline(\.lastBaselineAnchor, constant: constant, priority: priority)
    }

    /// Create builder for `lastBaseline` constraint.
    public var lastBaseline: ConstraintBuilder { lastBaseline() }
}

#endif
