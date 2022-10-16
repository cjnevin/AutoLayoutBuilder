#if canImport(UIKit)

import UIKit

public protocol TableViewHeader {
    var viewType: UITableViewHeaderFooterView.Type { get }
    var reuseIdentifier: String { get }
    var estimatedHeight: CGFloat? { get }
}

extension TableViewHeader {
    public var reuseIdentifier: String { String(describing: viewType) }
    public var estimatedHeight: CGFloat? { nil }

    func dequeue(in tableView: UITableView, at section: Int) -> UITableViewHeaderFooterView? {
        tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier).map { view in
            (self as? ConfigurableTableViewHeader)?.configure(view: view, at: section, in: tableView)
            return view
        }
    }
}

public protocol ConfigurableTableViewHeader: TableViewHeader {
    func configure(view: UITableViewHeaderFooterView, at section: Int, in tableView: UITableView)
}

public struct TableViewHeaderTitle: TableViewElement {
    let text: String

    public init(_ text: String) {
        self.text = text
    }
}

public typealias TableViewHeaderType = TableViewHeaderFooterType<TableViewHeader>

#endif
