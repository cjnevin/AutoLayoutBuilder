#if canImport(UIKit)

import UIKit

public protocol TableViewFooter {
    var viewType: UITableViewHeaderFooterView.Type { get }
    var reuseIdentifier: String { get }
    var estimatedHeight: CGFloat? { get }
}

extension TableViewFooter {
    public var reuseIdentifier: String { String(describing: viewType) }
    public var estimatedHeight: CGFloat? { nil }

    func dequeue(in tableView: UITableView, at section: Int) -> UITableViewHeaderFooterView? {
        tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier).map { view in
            (self as? ConfigurableTableViewFooter)?.configure(view: view, at: section, in: tableView)
            return view
        }
    }
}

public struct TableViewFooterTitle: TableViewElement {
    let text: String

    public init(_ text: String) {
        self.text = text
    }
}

public protocol ConfigurableTableViewFooter: TableViewFooter {
    func configure(view: UITableViewHeaderFooterView, at section: Int, in tableView: UITableView)
}

public typealias TableViewFooterType = TableViewHeaderFooterType<TableViewFooter>

#endif
