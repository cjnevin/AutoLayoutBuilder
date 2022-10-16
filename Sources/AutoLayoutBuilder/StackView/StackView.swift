#if canImport(UIKit)

import UIKit

public protocol StackViewProtocol: UIView {
    @discardableResult func addStackedView(_ view: StackableView) -> Self
    @discardableResult func insertStackedView(_ view: StackableView, at index: Int) -> Self
    @discardableResult func insertStackedView(_ view: StackableView, after: StackableView) -> Self
    @discardableResult func removeStackedView(_ view: StackableView) -> Self
    @discardableResult func hideStackedView(_ view: StackableView) -> Self
    @discardableResult func showStackedView(_ view: StackableView) -> Self
    @discardableResult func replaceStackedViews(@StackableViewBuilder _ views: () -> [StackableView]) -> Self
    @discardableResult func spacing(_ spacing: CGFloat) -> Self
    @discardableResult func spacing(_ spacing: CGFloat, after: StackableView) -> Self
}

public class StackView: UIView, StackViewProtocol {
    private let stackView = UIStackView()
    private var stackedViews: [StackableView]

    public init(axis: NSLayoutConstraint.Axis = .vertical, @StackableViewBuilder subviews: () -> [StackableView] = { [] }) {
        stackedViews = subviews()
        super.init(frame: .zero)
        stackedViews
            .lazy
            .map(\.view)
            .forEach(stackView.addArrangedSubview)
        stackView.axis = axis
        addSubview(stackView) {
            $0.edges == Superview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @discardableResult public func addStackedView(_ view: StackableView) -> Self {
        stackedViews.append(view)
        stackView.addArrangedSubview(view.view)
        return self
    }

    @discardableResult public func insertStackedView(_ view: StackableView, at index: Int) -> Self {
        stackedViews.insert(view, at: index + 1)
        stackView.insertArrangedSubview(view.view, at: index + 1)
        return self
    }

    @discardableResult public func insertStackedView(_ view: StackableView, after: StackableView) -> Self {
        stackedIndex(for: after.view).map { index in
            insertStackedView(view, at: index)
        } ?? self
    }

    @discardableResult public func removeStackedView(_ view: StackableView) -> Self {
        stackedIndex(for: view).map { index in
            stackedViews[index].view.removeFromSuperview()
            stackView.removeArrangedSubview(stackedViews[index].view)
            stackedViews.remove(at: index)
        }
        return self
    }

    @discardableResult public func hideStackedView(_ view: StackableView) -> Self {
        stackedView(for: view)?.view.isHidden = true
        return self
    }

    @discardableResult public func showStackedView(_ view: StackableView) -> Self {
        stackedView(for: view)?.view.isHidden = false
        return self
    }

    @discardableResult public func replaceStackedViews(@StackableViewBuilder _ views: () -> [StackableView]) -> Self {
        stackedViews.forEach {
            removeStackedView($0)
        }
        views().forEach {
            addStackedView($0)
        }
        return self
    }

    @discardableResult public func spacing(_ spacing: CGFloat) -> Self {
        stackView.spacing = spacing
        return self
    }

    @discardableResult public func spacing(_ spacing: CGFloat, after: StackableView) -> Self {
        (stackedView(for: after)?.view).map {
            stackView.setCustomSpacing(spacing, after: $0)
        }
        return self
    }

    private func stackedIndex(for view: StackableView) -> Int? {
        stackedViews.firstIndex { stackableView in
            stackableView.view == view.originalView
            || stackableView.originalView == view.originalView
            || stackableView.view == view.view
            || stackableView.originalView == view.view
        }
    }

    private func stackedView(for view: StackableView) -> StackableView? {
        stackedIndex(for: view).map {
            stackedViews[$0]
        }
    }
}

public class ScrollableStackView: UIView, StackViewProtocol {
    private let stackView: StackView
    private let scrollView: UIScrollView

    public init(axis: NSLayoutConstraint.Axis = .vertical, @StackableViewBuilder subviews: () -> [StackableView] = { [] }) {
        scrollView = UIScrollView()
        stackView = StackView(axis: axis, subviews: subviews)
        super.init(frame: .zero)
        addSubview(scrollView) {
            $0.edges == Superview()
            $0.addSubview(stackView) {
                if axis == .vertical {
                    $0.width == self
                } else {
                    $0.height == self
                }
                $0.edges == Superview()
            }
        }
    }

    @discardableResult public func addStackedView(_ view: StackableView) -> Self {
        stackView.addStackedView(view.view)
        return self
    }

    @discardableResult public func insertStackedView(_ view: StackableView, at index: Int) -> Self {
        stackView.insertStackedView(view, at: index)
        return self
    }

    @discardableResult public func insertStackedView(_ view: StackableView, after: StackableView) -> Self {
        stackView.insertStackedView(view, after: after)
        return self
    }

    @discardableResult public func removeStackedView(_ view: StackableView) -> Self {
        stackView.removeStackedView(view)
        return self
    }

    @discardableResult public func hideStackedView(_ view: StackableView) -> Self {
        stackView.hideStackedView(view)
        return self
    }

    @discardableResult public func showStackedView(_ view: StackableView) -> Self {
        stackView.showStackedView(view)
        return self
    }

    @discardableResult public func replaceStackedViews(@StackableViewBuilder _ views: () -> [StackableView]) -> Self {
        stackView.replaceStackedViews(views)
        return self
    }

    @discardableResult public func spacing(_ spacing: CGFloat) -> Self {
        stackView.spacing(spacing)
        return self
    }

    @discardableResult public func spacing(_ spacing: CGFloat, after: StackableView) -> Self {
        stackView.spacing(spacing, after: after)
        return self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#endif
