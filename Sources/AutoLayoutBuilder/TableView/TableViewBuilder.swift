#if canImport(UIKit)

import UIKit

@resultBuilder
public enum TableViewBuilder {
    public static func buildBlock(_ components: TableViewSection...) -> [TableViewSection] {
        components
    }

    public static func buildBlock(_ components: [TableViewSection]...) -> [TableViewSection] {
        components.flatMap { $0 }
    }

    public static func buildArray(_ components: [[TableViewSection]]) -> [TableViewSection] {
        components.flatMap { $0 }
    }

    public static func buildOptional(_ component: [TableViewSection]?) -> [TableViewSection] {
        component ?? []
    }

    public static func buildEither(first component: [TableViewSection]) -> [TableViewSection] {
        component
    }

    public static func buildEither(second component: [TableViewSection]) -> [TableViewSection] {
        component
    }

    public static func buildLimitedAvailability(_ component: [TableViewSection]) -> [TableViewSection] {
        component
    }
}

#endif
