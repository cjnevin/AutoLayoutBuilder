import UIKit

public protocol Constrainable {
    var constraints: [NSLayoutConstraint] { get }
}

extension NSLayoutConstraint: Constrainable {
    public var constraints: [NSLayoutConstraint] { [self] }
}

extension Array: Constrainable where Element == NSLayoutConstraint {
    public var constraints: [NSLayoutConstraint] { self }
}

// MARK: - Update Constraints

extension Constrainable {
    @discardableResult private func withEach(_ function: (NSLayoutConstraint) -> Void) -> Self {
        constraints.forEach(function)
        return self
    }

    /// Update a specific constraint.
    @discardableResult public func constraint(for attribute: NSLayoutConstraint.Attribute, source: Anchorable, update: (NSLayoutConstraint) -> Void) -> Self {
        for constraint in constraints where constraint.firstAttribute == attribute &&  constraint.firstItem === source {
            update(constraint)
        }
        return self
    }

    /// Update a specific constraint.
    @discardableResult public func replaceConstraint(for attribute: NSLayoutConstraint.Attribute, source: Anchorable, update: (NSLayoutConstraint, Anchorable) -> NSLayoutConstraint) -> Self {
        for constraint in constraints where constraint.firstAttribute == attribute &&  constraint.firstItem === source {
            constraint.deactivate()
            update(constraint, source).activate()
        }
        return self
    }

    /// Update a specific constraint.
    @discardableResult public func constraint(for attribute: NSLayoutConstraint.Attribute, update: (NSLayoutConstraint) -> Void) -> Self {
        for constraint in constraints where constraint.firstAttribute == attribute {
            update(constraint)
        }
        return self
    }

    /// Update constant for a specific constraint.
    @discardableResult public func updateMultiplier(for attribute: NSLayoutConstraint.Attribute, update: @autoclosure () -> CGFloat) -> Self {
        constraint(for: attribute) { constraint in
            constraint.deactivate()
            constraint.firstItem.map {
                NSLayoutConstraint(
                    item: $0,
                    attribute: constraint.firstAttribute,
                    relatedBy: constraint.relation,
                    toItem: constraint.secondItem,
                    attribute: constraint.secondAttribute,
                    multiplier: update(),
                    constant: constraint.constant
                )
            }?.activate()
        }
    }

    /// Update constant for a specific constraint.
    @discardableResult public func updateConstant(for attribute: NSLayoutConstraint.Attribute, update: @autoclosure () -> CGFloat) -> Self {
        constraint(for: attribute) {
            $0.constant = update()
        }
    }

    /// Update constraints for edges.
    @discardableResult public func updateConstants(to edgeInsets: UIEdgeInsets) -> Self {
        withEach {
            switch $0.firstAttribute {
            case .left, .leading: $0.constant = edgeInsets.left
            case .right, .trailing: $0.constant = -abs(edgeInsets.right)
            case .top: $0.constant = edgeInsets.top
            case .bottom: $0.constant = -abs(edgeInsets.bottom)
            default: break
            }
        }
    }

    /// Update priority of a specific constraint.
    @discardableResult public func updatePriority(for attribute: NSLayoutConstraint.Attribute, update: @autoclosure () -> UILayoutPriority) -> Self {
        constraint(for: attribute) {
            $0.priority = update()
        }
    }

    /// Update priority of all constraints.
    @discardableResult public func updatePriority(_ priority: UILayoutPriority) -> Self {
        withEach { $0.priority = priority }
    }

    /// Update constraints for size.
    @discardableResult public func updateSize(_ size: CGSize) -> Self {
        updateConstant(for: .width, update: size.width)
        return updateConstant(for: .height, update: size.height)
    }
}

// MARK: - Activate/Deactivate

extension Constrainable {
    /// Activate all constraints.
    @discardableResult public func activate() -> Self {
        NSLayoutConstraint.activate(constraints)
        return self
    }

    /// Deactivate all constraints.
    @discardableResult public func deactivate() -> Self {
        NSLayoutConstraint.deactivate(constraints)
        return self
    }
}

extension NSLayoutConstraint {
    /// @resultBuilder replacement for `NSLayoutConstraint.activate()`
    @discardableResult public static func activate(@AutoLayoutBuilder with constraints: () -> [Constrainable]) -> [Constrainable] {
        constraints().map { $0.activate() }
    }

    /// @resultBuilder replacement for `NSLayoutConstraint.deactivate()`
    @discardableResult public static func deactivate(@AutoLayoutBuilder with constraints: () -> [Constrainable]) -> [Constrainable] {
        constraints().map { $0.deactivate() }
    }
}
