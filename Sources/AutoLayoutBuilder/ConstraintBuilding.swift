import UIKit

public protocol ConstraintBuilding {
    var anchorable: Anchorable { get }
    func build(
        _ anchor: Anchor,
        constant: CGFloat,
        multiplier: CGFloat,
        priority: UILayoutPriority
    ) -> ConstraintBuilder
}

extension ConstraintBuilding {
    private func anchor(_ attribute: NSLayoutConstraint.Attribute) -> Anchor {
        anchorable.anchor(attribute)
    }

    /// Create builder for `left` constraint.
    public func left(_ constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        build(anchor(.left), constant: constant, multiplier: multiplier, priority: priority)
    }

    /// Create builder for `left` constraint.
    public var left: ConstraintBuilder { left() }

    /// Create builder for `right` constraint.
    /// You are responsible for passing in a positive/negative value.
    public func right(_ constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        build(anchor(.right), constant: constant, multiplier: multiplier, priority: priority)
    }

    /// Create builder for `right` constraint.
    public var right: ConstraintBuilder { right() }

    /// Create builder for `leading` constraint.
    public func leading(_ constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        build(anchor(.leading), constant: constant, multiplier: multiplier, priority: priority)
    }

    /// Create builder for `leading` constraint.
    public var leading: ConstraintBuilder { leading() }

    /// Create builder for `trailing` constraint.
    /// You are responsible for passing in a positive/negative value.
    public func trailing(_ constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        build(anchor(.trailing), constant: constant, multiplier: multiplier, priority: priority)
    }

    /// Create builder for `trailing` constraint.
    public var trailing: ConstraintBuilder { trailing() }

    /// Create builder for `top` constraint.
    public func top(_ constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        build(anchor(.top), constant: constant, multiplier: multiplier, priority: priority)
    }

    /// Create builder for `top` constraint.
    public var top: ConstraintBuilder { top() }

    /// Create builder for `bottom` constraint.
    /// You are responsible for passing in a positive/negative value.
    public func bottom(_ constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        build(anchor(.bottom), constant: constant, multiplier: multiplier, priority: priority)
    }

    /// Create builder for `bottom` constraint.
    public var bottom: ConstraintBuilder { bottom() }

    /// Create builder for `centerX` constraint.
    public func centerX(_ constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        build(anchor(.centerX), constant: constant, multiplier: multiplier, priority: priority)
    }

    /// Create builder for `centerX` constraint.
    public var centerX: ConstraintBuilder { centerX() }

    /// Create builder for `centerY` constraint.
    public func centerY(_ constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        build(anchor(.centerY), constant: constant, multiplier: multiplier, priority: priority)
    }

    /// Create builder for `centerY` constraint.
    public var centerY: ConstraintBuilder { centerY() }

    /// Create builder for `firstBaseline` constraint.
    public func firstBaseline(_ constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        build(anchor(.firstBaseline), constant: constant, multiplier: multiplier, priority: priority)
    }

    /// Create builder for `firstBaseline` constraint.
    public var firstBaseline: ConstraintBuilder { firstBaseline() }

    /// Create builder for `lastBaseline` constraint.
    public func lastBaseline(_ constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        build(anchor(.lastBaseline), constant: constant, multiplier: multiplier, priority: priority)
    }

    /// Create builder for `lastBaseline` constraint.
    public var lastBaseline: ConstraintBuilder { lastBaseline() }

    /// Create builder for `width` constraint.
    public func width(_ constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        build(anchor(.width), constant: constant, multiplier: multiplier, priority: priority)
    }

    /// Create builder for `width` constraint.
    public var width: ConstraintBuilder { width() }

    /// Create builder for `height` constraint.
    public func height(_ constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        build(anchor(.height), constant: constant, multiplier: multiplier, priority: priority)
    }

    /// Create builder for `height` constraint.
    public var height: ConstraintBuilder { height() }

    /// Create builder for `top`, `leading`, `trailing` and `bottom` constraints for `constant`.
    /// `trailing` value will be flipped to negative if `constant.right` is non-zero.
    /// `bottom` value will be flipped to negative if `constant.bottom` is non-zero.
    public func edges(
        _ constant: UIEdgeInsets = .zero,
        multiplier: CGFloat = 1,
        topPriority: UILayoutPriority = .required,
        leadingPriority: UILayoutPriority = .required,
        trailingPriority: UILayoutPriority = .required,
        bottomPriority: UILayoutPriority = .required
    ) -> ConstraintBuilder {
        top(constant.top, multiplier: multiplier, priority: topPriority)
            .leading(constant.left, multiplier: multiplier, priority: leadingPriority)
            .trailing(-constant.right, multiplier: multiplier, priority: trailingPriority)
            .bottom(-constant.bottom, multiplier: multiplier, priority: bottomPriority)
    }

    /// Create builder for `top`, `leading`, `trailing` and `bottom` constraints for `constant`.
    /// `trailing` value will be flipped to negative if `constant.right` is non-zero.
    /// `bottom` value will be flipped to negative if `constant.bottom` is non-zero.
    public func edges(
        _ constant: UIEdgeInsets = .zero,
        multiplier: CGFloat = 1,
        allEdgePriorities: UILayoutPriority
    ) -> ConstraintBuilder {
        edges(
            constant,
            multiplier: multiplier,
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
        multiplier: CGFloat = 1,
        topPriority: UILayoutPriority = .required,
        leadingPriority: UILayoutPriority = .required,
        trailingPriority: UILayoutPriority = .required,
        bottomPriority: UILayoutPriority = .required
    ) -> ConstraintBuilder {
        top(constant, multiplier: multiplier, priority: topPriority)
            .leading(constant, multiplier: multiplier, priority: leadingPriority)
            .trailing(-constant, multiplier: multiplier, priority: trailingPriority)
            .bottom(-constant, multiplier: multiplier, priority: bottomPriority)
    }

    /// Create builder for `top`, `leading`, `trailing` and `bottom` constraints for `constant`.
    /// `trailing` value will be flipped to negative if `constant` is non-zero.
    /// `bottom` value will be flipped to negative if `constant` is non-zero.
    public func edges(
        _ constant: CGFloat,
        multiplier: CGFloat = 1,
        allEdgePriorities: UILayoutPriority
    ) -> ConstraintBuilder {
        edges(
            constant,
            multiplier: multiplier,
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
        multiplier: CGFloat = 1,
        leadingPriority: UILayoutPriority = .required,
        trailingPriority: UILayoutPriority = .required
    ) -> ConstraintBuilder {
        leading(constant, multiplier: multiplier, priority: leadingPriority)
            .trailing(-constant, multiplier: multiplier, priority: trailingPriority)
    }

    /// Create builder for `leading` and `trailing` constraints.
    public var horizontalEdges: ConstraintBuilder { horizontalEdges() }

    /// Create builder for `top` and `bottom` constraints for `constant`.
    /// `bottom` value will be flipped to negative if `constant` is non-zero.
    public func verticalEdges(
        _ constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        topPriority: UILayoutPriority = .required,
        bottomPriority: UILayoutPriority = .required
    ) -> ConstraintBuilder {
        top(constant, multiplier: multiplier, priority: topPriority)
            .bottom(-constant, multiplier: multiplier, priority: bottomPriority)
    }

    /// Create builder for `top` and `bottom` constraints.
    public var verticalEdges: ConstraintBuilder { verticalEdges() }

    /// Create builder for `centerX` and `centerY` constraints.
    public func center(
        _ constant: CGPoint = .zero,
        multiplier: CGFloat = 1,
        centerXPriority: UILayoutPriority = .required,
        centerYPriority: UILayoutPriority = .required
    ) -> ConstraintBuilder {
        centerX(constant.x, multiplier: multiplier, priority: centerXPriority)
            .centerY(constant.y, multiplier: multiplier, priority: centerYPriority)
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
