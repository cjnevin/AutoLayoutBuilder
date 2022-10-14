#if canImport(UIKit)

import UIKit

public struct Anchor: CustomStringConvertible {
    let anchorable: Anchorable
    let attribute: NSLayoutConstraint.Attribute

    public var description: String {
        switch attribute {
        case .left: return "left"
        case .leftMargin: return "leftMargin"
        case .right: return "right"
        case .rightMargin: return "rightMargin"
        case .leading: return "leading"
        case .leadingMargin: return "leadingMargin"
        case .trailing: return "trailing"
        case .trailingMargin: return "trailingMargin"
        case .top: return "top"
        case .topMargin: return "topMargin"
        case .bottom: return "bottom"
        case .bottomMargin: return "bottomMargin"
        case .centerX: return "centerX"
        case .centerXWithinMargins: return "centerXWithinMargins"
        case .centerY: return "centerY"
        case .centerYWithinMargins: return "centerYWithinMargins"
        case .firstBaseline: return "firstBaseline"
        case .lastBaseline: return "lastBaseline"
        case .width: return "width"
        case .height: return "height"
        case .notAnAttribute: return "notAnAttribute"
        @unknown default: return "unknown"
        }
    }
}

public struct SizeAnchor {
    let width: Anchor
    let height: Anchor
}

extension Anchor {
    func constraint(
        _ relation: NSLayoutConstraint.Relation,
        to anchor: Anchor,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1
    ) -> NSLayoutConstraint {
        Anchor.assertAnchors(self, anchor)
        return NSLayoutConstraint(
            item: anchorable,
            attribute: attribute,
            relatedBy: relation,
            toItem: anchor.attribute == .notAnAttribute ? nil : anchor.anchorable,
            attribute: anchor.attribute,
            multiplier: multiplier,
            constant: constant
        )
    }

    func constraint(
        _ relation: NSLayoutConstraint.Relation,
        to value: CGFloat
    ) -> NSLayoutConstraint {
        constraint(relation, to: anchorable.anchor(.notAnAttribute), constant: value)
    }
}

private extension Anchor {
    var trait: Trait {
        if xAxis.contains(attribute) { return .x }
        if yAxis.contains(attribute) { return .y }
        if dimensions.contains(attribute) { return .dimension }
        return .none
    }

    static func assertAnchors(
        _ lhs: Anchor,
        _ rhs: Anchor
    ) {
        switch (lhs.trait, rhs.trait) {
        case (.x, .x),
            (.y, .y),
            (.dimension, .dimension),
            (.dimension, .none):
            if baselines.contains(lhs.attribute) {
                assert(lhs.anchorable is UIView, "Only views can apply '\(lhs)' constraints.")
            }
            if baselines.contains(rhs.attribute) {
                assert(rhs.anchorable is UIView, "Only views can apply '\(lhs)' constraints.")
            }
            return
        case (.x, .y),
            (.y, .x),
            (.x, .dimension),
            (.y, .dimension),
            (.dimension, .x),
            (.dimension, .y):
            assertionFailure("Cannot anchor '\(lhs)' (\(lhs.trait)) to '\(rhs)' (\(rhs.trait))")
        case (.x, .none), (.y, .none):
            assertionFailure("'\(lhs)' must be linked to another \(lhs.trait) anchor")
        case (.none, _):
            assertionFailure("Must have a starting anchor")
        }
    }
}

private enum Trait: String, CustomStringConvertible {
    case x = "x axis", y = "y axis", dimension, none

    var description: String {
        rawValue
    }
}

private let xAxis: [NSLayoutConstraint.Attribute] = [
    .left, .leading, .right, .trailing, .centerX, .leftMargin, .leadingMargin, .rightMargin, .trailingMargin, .centerXWithinMargins
]

private let yAxis: [NSLayoutConstraint.Attribute] = [
    .top, .bottom, .centerY, .firstBaseline, .lastBaseline, .topMargin, .bottomMargin, .centerYWithinMargins
]

private let baselines: [NSLayoutConstraint.Attribute] = [
    .firstBaseline, .lastBaseline
]

private let dimensions: [NSLayoutConstraint.Attribute] = [
    .width, .height
]

#endif
