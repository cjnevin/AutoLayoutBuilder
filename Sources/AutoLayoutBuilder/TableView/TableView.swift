#if canImport(UIKit)

import UIKit

public class TableView: UIView {
    private let tableView: UITableView
    private let manager: TableViewManager

    public init(
        tableView: UITableView,
        @TableViewBuilder sections: () -> [TableViewSection]
    ) {
        self.tableView = tableView
        manager = TableViewManager(
            tableView: tableView,
            sections: sections
        )
        super.init(frame: .zero)
        addSubview(tableView) {
            $0.edges.equalToSuperview()
        }
        manager.reloadSections()
    }

    public var sections: [TableViewSection] {
        manager.sections
    }

    public convenience init(style: UITableView.Style = .plain, @TableViewBuilder sections: () -> [TableViewSection] = { [] }) {
        self.init(tableView: UITableView(frame: .zero, style: style), sections: sections)
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @discardableResult public func setIsEditing(_ isEditing: Bool) -> Self {
        tableView.setEditing(isEditing, animated: true)
        return self
    }

    @discardableResult public func setMultiselect(_ enabled: Bool) -> Self {
        tableView.allowsMultipleSelection = enabled
        return self
    }

    @discardableResult public func setMultiselectDuringEditing(_ enabled: Bool) -> Self {
        tableView.allowsMultipleSelectionDuringEditing = enabled
        return self
    }

    @discardableResult public func setOnInsertRow(_ callback: @escaping () -> TableViewRow) -> Self {
        manager.setOnInsertRow(callback)
        return self
    }

    @discardableResult public func setOnSectionsUpdated(_ callback: @escaping ([TableViewSection]) -> Void) -> Self {
        manager.setOnSectionsUpdated(callback)
        return self
    }

    @discardableResult public func updateSections(@TableViewBuilder _ sections: () -> [TableViewSection]) -> Self {
        manager.updateSections(sections())
        return self
    }
}

#endif
