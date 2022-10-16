#if canImport(UIKit)

import UIKit

public enum TableViewHeaderFooterType<View>: TableViewElement {
    case title(String)
    case view(View)
    case none

    var titleValue: String? {
        guard case .title(let value) = self else { return nil }
        return value
    }

    var viewValue: View? {
        guard case .view(let value) = self else { return nil }
        return value
    }
}

#endif
