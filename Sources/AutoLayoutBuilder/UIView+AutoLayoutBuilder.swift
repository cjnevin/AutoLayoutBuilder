#if canImport(UIKit)

import UIKit

extension UIView {
    /// This will not add your view to the view hierarchy. Useful for views already added to the hierarchy.
    @discardableResult public func constraints<View: UIView>(@AutoLayoutBuilder _ makeConstraints: (View) -> [Constrainable]) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = makeConstraints(self as! View).flatMap(\.constraints)
        NSLayoutConstraint.activate(constraints)
        return constraints
    }

    /// Add subview on top of view hierarchy and apply constraints.
    @discardableResult public func addSubview<View: UIView>(_ view: View, @AutoLayoutBuilder with makeConstraints: (View) -> [Constrainable]) -> [NSLayoutConstraint] {
        addSubview(view)
        return view.constraints(makeConstraints)
    }

    /// Insert subview at a particular index and apply constraints.
    @discardableResult public func insertSubview<View: UIView>(_ view: View, at index: Int, @AutoLayoutBuilder with makeConstraints: (View) -> [Constrainable]) -> [NSLayoutConstraint] {
        insertSubview(view, at: index)
        return view.constraints(makeConstraints)
    }
}

#endif
