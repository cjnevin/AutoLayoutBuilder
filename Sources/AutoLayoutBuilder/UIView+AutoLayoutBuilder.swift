#if canImport(UIKit)

import UIKit

extension UIView {
    /// This will not add your view to the view hierarchy. Useful for views already added to the hierarchy.
    /// `translatesAutoresizingMask` is a proxy to `View.translatesAutoresizingMaskIntoConstraints`.
    @discardableResult public func constraints<View: UIView>(translatesAutoresizingMask: Bool = false, @AutoLayoutBuilder _ makeConstraints: (View) -> [Constrainable]) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMask
        let constraints = makeConstraints(self as! View).flatMap(\.constraints)
        NSLayoutConstraint.activate(constraints)
        return constraints
    }

    /// Add subview on top of view hierarchy and apply constraints.
    @discardableResult public func addSubview<View: UIView>(_ view: View, @AutoLayoutBuilder with makeConstraints: (View) -> [Constrainable]) -> [NSLayoutConstraint] {
        addAutoLayoutSubviews(view)
        let constraints = makeConstraints(view).flatMap(\.constraints)
        NSLayoutConstraint.activate(constraints)
        return constraints
    }

    /// Add subviews on top of view hierarchy and apply constraints.
    @discardableResult public func addSubviews<
        ViewA: UIView,
        ViewB: UIView
    >(
    _ viewA: ViewA,
    _ viewB: ViewB,
    @AutoLayoutBuilder with makeConstraints: (ViewA, ViewB) -> [Constrainable]
    ) -> [NSLayoutConstraint] {
        addAutoLayoutSubviews(viewA, viewB)
        let constraints = makeConstraints(viewA, viewB).flatMap(\.constraints)
        NSLayoutConstraint.activate(constraints)
        return constraints
    }

    /// Add subviews on top of view hierarchy and apply constraints.
    @discardableResult public func addSubviews<
        ViewA: UIView,
        ViewB: UIView,
        ViewC: UIView
    >(
    _ viewA: ViewA,
    _ viewB: ViewB,
    _ viewC: ViewC,
    @AutoLayoutBuilder with makeConstraints: (ViewA, ViewB, ViewC) -> [Constrainable]
    ) -> [NSLayoutConstraint] {
        addAutoLayoutSubviews(viewA, viewB, viewC)
        let constraints = makeConstraints(viewA, viewB, viewC).flatMap(\.constraints)
        NSLayoutConstraint.activate(constraints)
        return constraints
    }

    /// Add subviews on top of view hierarchy and apply constraints.
    @discardableResult public func addSubviews<
        ViewA: UIView,
        ViewB: UIView,
        ViewC: UIView,
        ViewD: UIView
    >(
    _ viewA: ViewA,
    _ viewB: ViewB,
    _ viewC: ViewC,
    _ viewD: ViewD,
    @AutoLayoutBuilder with makeConstraints: (ViewA, ViewB, ViewC, ViewD) -> [Constrainable]
    ) -> [NSLayoutConstraint] {
        addAutoLayoutSubviews(viewA, viewB, viewC, viewD)
        let constraints = makeConstraints(viewA, viewB, viewC, viewD).flatMap(\.constraints)
        NSLayoutConstraint.activate(constraints)
        return constraints
    }

    /// Add subviews on top of view hierarchy and apply constraints.
    @discardableResult public func addSubviews<
        ViewA: UIView,
        ViewB: UIView,
        ViewC: UIView,
        ViewD: UIView,
        ViewE: UIView
    >(
    _ viewA: ViewA,
    _ viewB: ViewB,
    _ viewC: ViewC,
    _ viewD: ViewD,
    _ viewE: ViewE,
    @AutoLayoutBuilder with makeConstraints: (ViewA, ViewB, ViewC, ViewD, ViewE) -> [Constrainable]
    ) -> [NSLayoutConstraint] {
        addAutoLayoutSubviews(viewA, viewB, viewC, viewD, viewE)
        let constraints = makeConstraints(viewA, viewB, viewC, viewD, viewE).flatMap(\.constraints)
        NSLayoutConstraint.activate(constraints)
        return constraints
    }

    /// Add subviews on top of view hierarchy and apply constraints.
    @discardableResult public func addSubviews<
        ViewA: UIView,
        ViewB: UIView,
        ViewC: UIView,
        ViewD: UIView,
        ViewE: UIView,
        ViewF: UIView
    >(
    _ viewA: ViewA,
    _ viewB: ViewB,
    _ viewC: ViewC,
    _ viewD: ViewD,
    _ viewE: ViewE,
    _ viewF: ViewF,
    @AutoLayoutBuilder with makeConstraints: (ViewA, ViewB, ViewC, ViewD, ViewE, ViewF) -> [Constrainable]
    ) -> [NSLayoutConstraint] {
        addAutoLayoutSubviews(viewA, viewB, viewC, viewD, viewE, viewF)
        let constraints = makeConstraints(viewA, viewB, viewC, viewD, viewE, viewF).flatMap(\.constraints)
        NSLayoutConstraint.activate(constraints)
        return constraints
    }

    /// Insert subview at a particular index and apply constraints.
    @discardableResult public func insertSubview<View: UIView>(_ view: View, at index: Int, @AutoLayoutBuilder with makeConstraints: (View) -> [Constrainable]) -> [NSLayoutConstraint] {
        insertSubview(view, at: index)
        return view.constraints(translatesAutoresizingMask: false, makeConstraints)
    }

    private func addAutoLayoutSubviews(_ views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
}

#endif
