#if canImport(UIKit)

import UIKit

public protocol TableViewRow: TableViewElement {
    var cellType: UITableViewCell.Type { get }
    var reuseIdentifier: String { get }
    var estimatedHeight: CGFloat? { get }
}

extension TableViewRow {
    public var reuseIdentifier: String { String(describing: cellType) }
    public var estimatedHeight: CGFloat? { nil }

    func dequeue(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        (self as? ConfigurableTableViewRow)?.configure(cell: cell, at: indexPath, in: tableView)
        return cell
    }
}

public protocol EditableTableViewRow: TableViewRow {
    var canEdit: Bool { get }
    var editingStyle: UITableViewCell.EditingStyle { get }
    func delete(from sections: inout [TableViewSection], at indexPath: IndexPath)
}

extension EditableTableViewRow {
    public var canEdit: Bool { true }
    public var editingStyle: UITableViewCell.EditingStyle { .delete }
    public func delete(from sections: inout [TableViewSection], at indexPath: IndexPath) {
        var section = sections[indexPath.section]
        section.rows.remove(at: indexPath.row)
        sections[indexPath.section] = section
    }
}

public protocol MovableTableViewRow: EditableTableViewRow {
    var canMove: Bool { get }
    func onMove(from indexPath: IndexPath, to newIndexPath: IndexPath) -> IndexPath
}

extension MovableTableViewRow {
    public var canMove: Bool { true }
}

public protocol LeadingSwipeableTableViewRow: TableViewRow {
    var leadingSwipeActionsConfiguration: UISwipeActionsConfiguration? { get }
}

public protocol TrailingSwipeableTableViewRow: TableViewRow {
    var trailingSwipeActionsConfiguration: UISwipeActionsConfiguration? { get }
}

public protocol ConfigurableTableViewRow: TableViewRow {
    func configure(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView)
}

public protocol TappableTableViewRow: TableViewRow {
    func onTap(at indexPath: IndexPath, in tableView: UITableView)
}

#endif
