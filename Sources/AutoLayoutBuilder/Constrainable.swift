#if canImport(UIKit)

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

// MARK: - Storage

extension NSLayoutConstraint {
    /// Allows for the storage of `NSLayoutConstraint?` inside of `AutoLayoutBuilder` `@resultBuilder` blocks.
    /// ```
    /// addSubview(subView) {
    ///     $0.width(equalTo: 50).store(in: &optionalWidthAnchor)
    /// }
    /// ```
    @discardableResult public func store(in output: inout NSLayoutConstraint?) -> NSLayoutConstraint {
        output = self
        return self
    }
}

extension Constrainable {
    /// Allows for the storage of `[NSLayoutConstraint]` inside of `AutoLayoutBuilder` `@resultBuilder` blocks.
    /// ```
    /// addSubview(subView) {
    ///     $0.edges().equalToSuperview().store(in: &subViewEdgeConstraints)
    /// }
    /// ```
    public func store(in output: inout [NSLayoutConstraint]) -> Self {
        output = constraints
        return self
    }

    /// Allows for the storage of `NSLayoutConstraint?` inside of `AutoLayoutBuilder` `@resultBuilder` blocks.
    /// ```
    /// addSubview(subView) {
    ///     $0.leading().trailing().top().equalToSuperview().store(.leading, in: &optionalLeadingConstraint)
    /// }
    /// ```
    public func store(_ attribute: NSLayoutConstraint.Attribute, in output: inout NSLayoutConstraint?) -> Self {
        output = constraints.first { $0.firstAttribute == attribute }
        return self
    }
}

// MARK: - Update Constraints

extension Constrainable {
    /// Update a specific constraint.
    @discardableResult public func constraint(for attribute: NSLayoutConstraint.Attribute, update: (NSLayoutConstraint) -> Void) -> Self {
        for constraint in constraints where constraint.firstAttribute == attribute {
            update(constraint)
        }
        return self
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
        constraints().flatMap { $0.activate() }
    }

    /// @resultBuilder replacement for `NSLayoutConstraint.deactivate()`
    @discardableResult public static func deactivate(@AutoLayoutBuilder with constraints: () -> [Constrainable]) -> [Constrainable] {
        constraints().flatMap { $0.deactivate() }
    }
}

#endif
