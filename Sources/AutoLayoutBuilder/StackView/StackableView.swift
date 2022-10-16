#if canImport(UIKit)

import UIKit

public protocol StackableView {
    var view: UIView { get }
    var originalView: UIView { get }
}

extension UIView: StackableView {
    public var view: UIView { self }
    public var originalView: UIView { self }
}

extension StackableView {
    public func top(_ padding: CGFloat = 0) -> StackableView {
        StackedView(view, originalView: originalView) {
            $0.horizontalEdges.top(padding) == Superview()
            $0.bottom <= Superview()
        }
    }

    public func leading(_ padding: CGFloat = 0) -> StackableView {
        StackedView(view, originalView: originalView) {
            $0.verticalEdges.leading(padding) == Superview()
            $0.trailing <= Superview()
        }
    }

    public func trailing(_ padding: CGFloat = 0) -> StackableView {
        StackedView(view, originalView: originalView) {
            $0.verticalEdges.trailing(-padding) == Superview()
            $0.leading >= Superview()
        }
    }

    public func bottom(_ padding: CGFloat = 0) -> StackableView {
        StackedView(view, originalView: originalView) {
            $0.horizontalEdges.bottom(-padding) == Superview()
            $0.top >= Superview()
        }
    }

    public func centered(_ padding: CGFloat = 0) -> StackableView {
        StackedView(view, originalView: originalView) {
            $0.centerX.centerY == Superview()
            $0.top(padding).leading(padding) >= Superview()
            $0.trailing(-padding).bottom(-padding) <= Superview()
        }
    }

    public func padding(_ padding: CGFloat) -> StackableView {
        StackedView(view, originalView: originalView) {
            $0.horizontalEdges(padding).verticalEdges == Superview()
        }
    }

    public func verticalPadding(_ padding: CGFloat) -> StackableView {
        StackedView(view, originalView: originalView) {
            $0.horizontalEdges.verticalEdges(padding) == Superview()
        }
    }
}

private struct StackedView: StackableView {
    let view: UIView = UIView()
    let originalView: UIView

    init<View: UIView>(_ targetView: View, originalView: UIView, @AutoLayoutBuilder constraints: (View) -> [Constrainable]) {
        self.originalView = originalView
        self.view.addSubview(targetView, with: constraints)
    }
}

#endif
