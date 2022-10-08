# AutoLayoutBuilder

## Adding subviews

Add subview on top of view hierarchy and apply constraints.

```swift
// view pinned to superview
addSubview(subview) {
  $0.edges().equalToSuperview()
}
```

## Inserting subviews

Insert subview at a particular index and apply constraints.

```swift
insertSubview(subview, at: 0) {
    $0.edges().equalToSuperview()
}
```

## Adding constraints

This will not add your view to the view hierarchy. Useful for views already added to the hierarchy.

```swift
subview.constraints {
    $0.edges().equalToSuperview()
}
```

## Nesting

You can nest calls inside any of the above blocks as long as you return a `Constrainable` object.

```swift
addSubview(scrollView) {
  $0.edges().equalToSuperview()
  $0.addSubview(stackView) {
    $0.edges().equalToSuperview()
    $0.width().equalTo(widthAnchor)
    $0.configure {
      $0.addArrangedSubviews([redView, greenView])
      $0.setCustomSpacing(10, after: redView)
    }
  }
}
```

---

## More Complex Examples

```swift
// view with custom insets inside superview
addSubview(insetView) {
  $0.leading(10).trailing(-10).top(20).bottom(-20).equalToSuperview()
}

// view inset 10 from each edge of safe area
addSubview(flexibleView) {
  $0.edges(10, trailingPriority: .notRequired).equalTo(safeAreaLayoutGuide)
}

// 60x30 rectangle with flexible width
addSubview(flexibleRectangularView) {
  $0.width(lessThanOrEqualTo: 60)
  $0.height(equalTo: 30)
}

// floating 30x30 subview hanging off left side of existing subview
addSubview(floatingButton) {
  $0.top().equalTo(myOtherSubview)
  $0.trailing(20).equalTo(myOtherSubview.leading)
  $0.size(equalTo: 44)
}

// view with same size and position as another view
addSubview(overlaidView) {
  $0.size().center().equalTo(otherView)
}
```
