# AutoLayoutBuilder

## Adding subviews

Add subview on top of view hierarchy and apply constraints.

```swift
// view pinned to superview
addSubview(subview) {
  $0.edges == Superview()
}
```

## Inserting subviews

Insert subview at a particular index and apply constraints.

```swift
insertSubview(subview, at: 0) {
  $0.edges == Superview()
}
```

## Adding constraints

This will not add your view to the view hierarchy. Useful for views already added to the hierarchy.

```swift
subview.constraints {
  $0.edges == Superview()
}
```

## Nesting

You can nest calls inside any of the above blocks as long as you return a `Constrainable` object.

```swift
addSubview(scrollView) {
  $0.edges == Superview()
  $0.addSubview(stackView) {
    $0.edges == Superview()
    $0.width == width
    $0.configure {
      $0.addArrangedSubviews([redView, greenView])
      $0.setCustomSpacing(10, after: redView)
    }
  }
}
```

### StackViews

There is actually a cleaner way of doing the above, it's called `ScrollableStackView` and you could write the above code as:

```swift
addSubview(ScrollableStackView()) {
  $0.edges == Superview()
  $0.stackedViews {
    redView
    greenView
  }
  $0.spacing(10, after: redView)
}
```

There is an extension to this package for working with StackViews, located here: 
https://github.com/cjnevin/StackViewBuilder

### TableViews

There is an extension to this package for working with TableViews, located here:
https://github.com/cjnevin/TableViewBuilder

## Relative Constraints

If you have several views all being added to the same superview you may have three separate blocks:

```swift
addSubview(leftView) {
  $0.verticalEdges.leading == Superview()
}
addSubview(rightView) {
  $0.verticalEdges.trailing == Superview()
}
addSubview(middleView) {
  $0.verticalEdges == Superview()
  $0.leading(20) >= leftView.trailing
  $0.trailing(-20) <= rightView.leading
}

```

There is a slight readability issue here in that we need to add `leftView` and `rightView` before we can configure `middleView` as it relies on both of them. 

If we were to move this code around and put `rightView` under `middleView` it would no longer run without crashing because `rightView` isn't added to the view at the time `middleView` is laying out.

In this scenario, you might instead consider doing something like:

```swift
addSubviews(leftView, middleView, rightView) { leftView, middleView, rightView in
  leftView.verticalEdges.leading == Superview()

  middleView.verticalEdges == Superview()
  middleView.leading(20) >= leftView.trailing
  middleView.trailing(-20) <= rightView.leading

  rightView.verticalEdges.trailing == Superview()
}
```

## Storage

If you need to store an array of constraints:

```swift
addSubview(insetView) {
  $0.store(in: &edgeConstraints) {
    $0.verticalEdges(20).horizontalEdges(10) == self
  }
}
```

If you need to store a single constraint (note this will take 'first' if you provide more than one):

```swift
addSubview(button) {
  $0.top.leading == self
  $0.height == 50
  $0.store(in: &widthConstraint) {
    $0.width == 50
  }
}
```

If you need to store a single constraint but want all of the code in one block:

```swift
addSubview(button) {
  $0.store(.width, in: &widthConstraint) {
    $0.top.leading == self
    $0.size == 50
  }
}
```

---

## Other Examples

```swift
// view with custom insets inside superview
addSubview(insetView) {
  $0.horizontalEdges(10).verticalEdges(20) == Superview()
}

// view inset 10 from each edge of safe area
addSubview(flexibleView) {
  $0.edges(10, trailingPriority: .notRequired) == safeAreaLayoutGuide
}

// 60x30 rectangle with flexible width
addSubview(flexibleRectangularView) {
  $0.width <= 60
  $0.height == 30
}

// floating 44x44 subview hanging off left side of existing subview
addSubview(floatingButton) {
  $0.top == myOtherSubview
  $0.trailing(20) == myOtherSubview.leading
  $0.size == 44
}

// view with same size and position as another view
addSubview(overlaidView) {
  $0.size.center == otherView
}
```
