#if canImport(UIKit)

import UIKit

extension ConstraintBuilder {
    /// Combine `self` with builder for `left` constraint.
    public func left(_ constant: CGFloat = 0, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        combine(with: view.left(constant, priority: priority))
    }

    /// Combine `self` with builder for `right` constraint.
    /// You are responsible for passing in a positive/negative value.
    public func right(_ constant: CGFloat = 0, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        combine(with: view.right(constant, priority: priority))
    }

    /// Combine `self` with builder for `leading` constraint.
    public func leading(_ constant: CGFloat = 0, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        combine(with: view.leading(constant, priority: priority))
    }

    /// Combine `self` with builder for `trailing` constraint.
    /// You are responsible for passing in a positive/negative value.
    public func trailing(_ constant: CGFloat = 0, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        combine(with: view.trailing(constant, priority: priority))
    }

    /// Combine `self` with builder for `top` constraint.
    public func top(_ constant: CGFloat = 0, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        combine(with: view.top(constant, priority: priority))
    }

    /// Combine `self` with builder for `bottom` constraint.
    /// You are responsible for passing in a positive/negative value.
    public func bottom(_ constant: CGFloat = 0, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        combine(with: view.bottom(constant, priority: priority))
    }

    /// Combine `self` with builder for `centerX` constraint.
    public func centerX(_ constant: CGFloat = 0, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        combine(with: view.centerX(constant, priority: priority))
    }

    /// Combine `self` with builder for `centerY` constraint.
    public func centerY(_ constant: CGFloat = 0, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        combine(with: view.centerY(constant, priority: priority))
    }

    /// Combine `self` with builder for `width` constraint.
    public func width(_ constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        combine(with: view.width(constant, multiplier: multiplier, priority: priority))
    }

    /// Combine `self` with builder for `height` constraint.
    public func height(_ constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        combine(with: view.height(constant, multiplier: multiplier, priority: priority))
    }

    /// Combine `self` with builder for `top`, `leading`, `trailing` and `bottom` constraints for `constant`.
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

    /// Combine `self` with builder for `top`, `leading`, `trailing` and `bottom` constraints for `constant`.
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

    /// Combine `self` with builder for `leading` and `trailing` constraints for `constant`.
    /// `trailing` value will be flipped to negative if `constant` is non-zero.
    public func horizontalEdges(
        _ constant: CGFloat = 0,
        leadingPriority: UILayoutPriority = .required,
        trailingPriority: UILayoutPriority = .required
    ) -> ConstraintBuilder {
        leading(constant, priority: leadingPriority)
            .trailing(-constant, priority: trailingPriority)
    }

    /// Combine `self` with builder for `top` and `bottom` constraints for `constant`.
    /// `bottom` value will be flipped to negative if `constant` is non-zero.
    public func verticalEdges(
        _ constant: CGFloat = 0,
        topPriority: UILayoutPriority = .required,
        bottomPriority: UILayoutPriority = .required
    ) -> ConstraintBuilder {
        top(constant, priority: topPriority)
            .bottom(-constant, priority: bottomPriority)
    }

    /// Combine `self` with builder for `centerX` and `centerY` constraints.
    public func center(
        _ constant: CGPoint = .zero,
        centerXPriority: UILayoutPriority = .required,
        centerYPriority: UILayoutPriority = .required
    ) -> ConstraintBuilder {
        centerX(constant.x, priority: centerXPriority)
            .centerY(constant.y, priority: centerYPriority)
    }

    /// Combine `self` with builder for `width` and `height` constraints.
    public func size(
        _ constant: CGSize = .zero,
        multiplier: CGFloat = 1,
        widthPriority: UILayoutPriority = .required,
        heightPriority: UILayoutPriority = .required
    ) -> ConstraintBuilder {
        width(constant.width, multiplier: multiplier, priority: widthPriority)
            .height(constant.height, multiplier: multiplier, priority: heightPriority)
    }
}

extension ConstraintBuilder {
    /// Combine `self` with builder for `firstBaseline` constraint.
    public func firstBaseline(_ constant: CGFloat = 0, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        if let baselineAnchorable = view as? BaselineAnchorable {
            return combine(with: baselineAnchorable.firstBaseline(constant, priority: priority))
        } else {
            assertionFailure("Calling firstBaseline on a layoutGuide is not possible")
            return self
        }
    }

    /// Combine `self` with builder for `lastBaseline` constraint.
    public func lastBaseline(_ constant: CGFloat = 0, priority: UILayoutPriority = .required) -> ConstraintBuilder {
        if let baselineAnchorable = view as? BaselineAnchorable {
            return combine(with: baselineAnchorable.lastBaseline(constant, priority: priority))
        } else {
            assertionFailure("Calling lastBaseline on a layoutGuide is not possible")
            return self
        }
    }
}

#endif
