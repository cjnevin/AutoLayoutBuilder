#if canImport(UIKit)

import UIKit

class TableViewManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    private let tableView: UITableView
    private var onInsertRow: (() -> TableViewRow)?
    private(set) var sections: [TableViewSection] {
        didSet { onSectionsUpdated?(sections) }
    }
    private var onSectionsUpdated: (([TableViewSection]) -> Void)? {
        didSet { onSectionsUpdated?(sections) }
    }

    init(
        tableView: UITableView,
        @TableViewBuilder sections: () -> [TableViewSection]
    ) {
        self.tableView = tableView
        self.sections = sections()
        super.init()
        tableView.dataSource = self
        tableView.delegate = self
        reloadSections()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    subscript(row indexPath: IndexPath) -> TableViewRow {
        sections[indexPath.section].rows[indexPath.row]
    }

    subscript(headerConfig section: Int) -> TableViewHeaderType? {
        sections[section].header
    }

    subscript(header section: Int) -> TableViewHeader? {
        self[headerConfig: section]?.viewValue
    }

    subscript(footerConfig section: Int) -> TableViewFooterType? {
        sections[section].footer
    }

    subscript(footer section: Int) -> TableViewFooter? {
        self[footerConfig: section]?.viewValue
    }

    func reloadSections() {
        sections.forEach {
            $0.header.viewValue.map {
                tableView.register($0.viewType, forHeaderFooterViewReuseIdentifier: $0.reuseIdentifier)
            }
            $0.footer.viewValue.map {
                tableView.register($0.viewType, forHeaderFooterViewReuseIdentifier: $0.reuseIdentifier)
            }
            $0.rows.forEach {
                tableView.register($0.cellType, forCellReuseIdentifier: $0.reuseIdentifier)
            }
        }
        tableView.reloadData()
    }

    @discardableResult func setOnSectionsUpdated(_ callback: @escaping ([TableViewSection]) -> Void) -> Self {
        onSectionsUpdated = callback
        return self
    }

    @discardableResult func setOnInsertRow(_ callback: @escaping () -> TableViewRow) -> Self {
        onInsertRow = callback
        return self
    }

    func updateSections(_ newSections: [TableViewSection]) {
        sections = newSections
        reloadSections()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        self[row: indexPath].estimatedHeight ?? UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        self[header: section]?.estimatedHeight ?? UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        self[footer: section]?.estimatedHeight ?? UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        self[headerConfig: section]?.titleValue
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        self[header: section]?.dequeue(in: tableView, at: section)
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        self[footerConfig: section]?.titleValue
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        self[footer: section]?.dequeue(in: tableView, at: section)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self[row: indexPath].dequeue(in: tableView, at: indexPath)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .insert:
            if let insert = onInsertRow?() {
                var section = sections[indexPath.section]
                section.rows.append(insert)
                sections[indexPath.section] = section
                tableView.insertRows(at: [IndexPath(row: section.rows.count - 1, section: indexPath.section)], with: .automatic)
            }
        case .delete:
            var section = sections[indexPath.section]
            section.rows.remove(at: indexPath.row)
            sections[indexPath.section] = section
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            break
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        (self[row: indexPath] as? TappableTableViewRow)?.onTap(at: indexPath, in: tableView)
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        (self[row: indexPath] as? LeadingSwipeableTableViewRow)?.leadingSwipeActionsConfiguration
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        (self[row: indexPath] as? TrailingSwipeableTableViewRow)?.trailingSwipeActionsConfiguration
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        (self[row: indexPath] as? EditableTableViewRow)?.editingStyle ?? .none
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        (self[row: indexPath] as? EditableTableViewRow)?.canEdit ?? false
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        (self[row: indexPath] as? MovableTableViewRow)?.canMove ?? false
    }

    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        (self[row: sourceIndexPath] as? MovableTableViewRow)?.onMove(
            from: sourceIndexPath,
            to: proposedDestinationIndexPath
        ) ?? proposedDestinationIndexPath
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var sourceSection = sections[sourceIndexPath.section]
        let sourceRow = sourceSection.rows[sourceIndexPath.row]
        sourceSection.rows.remove(at: sourceIndexPath.row)
        sections[sourceIndexPath.section] = sourceSection

        var destinationSection = sections[destinationIndexPath.section]
        destinationSection.rows.insert(sourceRow, at: destinationIndexPath.row)
        sections[destinationIndexPath.section] = destinationSection
    }
}

#endif
