#if canImport(UIKit)

import UIKit

public protocol TableViewElement {}

public struct TableViewSection {
    var header: TableViewHeaderType
    var footer: TableViewFooterType
    var rows: [TableViewRow]
}

@resultBuilder
public enum TableViewSectionBuilder {
    public static func buildBlock(_ components: TableViewRow...) -> [TableViewElement] {
        components
    }
    
    public static func buildExpression(_ expression: TableViewRow) -> [TableViewElement] {
        [expression]
    }

    public static func buildExpression(_ expression: TableViewHeader) -> [TableViewElement] {
        [TableViewHeaderType.view(expression)]
    }

    public static func buildExpression(_ expression: TableViewHeaderTitle) -> [TableViewElement] {
        [TableViewHeaderType.title(expression.text)]
    }

    public static func buildExpression(_ expression: TableViewFooter) -> [TableViewElement] {
        [TableViewFooterType.view(expression)]
    }

    public static func buildExpression(_ expression: TableViewFooterTitle) -> [TableViewElement] {
        [TableViewFooterType.title(expression.text)]
    }

    public static func buildBlock(_ components: TableViewElement...) -> [TableViewElement] {
        components
    }

    public static func buildBlock(_ components: [TableViewElement]...) -> [TableViewElement] {
        components.flatMap { $0 }
    }

    public static func buildArray(_ components: [[TableViewElement]]) -> [TableViewElement] {
        components.flatMap { $0 }
    }

    public static func buildOptional(_ component: [TableViewElement]?) -> [TableViewElement] {
        component ?? []
    }

    public static func buildEither(first component: [TableViewElement]) -> [TableViewElement] {
        component
    }

    public static func buildEither(second component: [TableViewElement]) -> [TableViewElement] {
        component
    }

    public static func buildLimitedAvailability(_ component: [TableViewElement]) -> [TableViewElement] {
        component
    }

    public static func buildFinalResult(_ component: [TableViewElement]) -> TableViewSection {
        let header = component.compactMap { $0 as? TableViewHeaderType }.first
        let footer = component.compactMap { $0 as? TableViewFooterType }.first
        let rows = component.compactMap { $0 as? TableViewRow }
        return TableViewSection(header: header ?? .none, footer: footer ?? .none, rows: rows)
    }
}

extension TableViewSection {
    public init(@TableViewSectionBuilder builder: () -> TableViewSection) {
        let _section = builder()
        header = _section.header
        footer = _section.footer
        rows = _section.rows
    }
}

#endif
