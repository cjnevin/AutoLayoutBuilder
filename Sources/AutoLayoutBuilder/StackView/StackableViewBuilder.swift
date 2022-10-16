#if canImport(UIKit)

import UIKit

@resultBuilder
public enum StackableViewBuilder {
    public static func buildBlock(_ components: StackableView...) -> [StackableView] {
        components
    }

    public static func buildArray(_ components: [[StackableView]]) -> [StackableView] {
        components.flatMap { $0 }
    }

    public static func buildOptional(_ component: [StackableView]?) -> [StackableView] {
        component ?? []
    }

    public static func buildEither(first component: [StackableView]) -> [StackableView] {
        component
    }

    public static func buildEither(second component: [StackableView]) -> [StackableView] {
        component
    }

    public static func buildLimitedAvailability(_ component: [StackableView]) -> [StackableView] {
        component
    }
}

#endif
