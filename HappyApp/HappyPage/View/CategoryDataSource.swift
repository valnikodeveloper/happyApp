import UIKit

struct CategoryItem {
    let imageName: String?
    let subTitle: String?
}

struct CategoryDataSource {
    let name: String?
    var categoryItems: [CategoryItem]
    let size: CGSize?

    init(with info: [String: Any]) {
        name = info[DataSourceConstants.categoryName] as? String
        categoryItems = info[DataSourceConstants.categoryItems] as? [CategoryItem] ?? []
        size = info[DataSourceConstants.itemSize] as? CGSize
    }
}

enum DataSourceConstants {
    static let categoryName = "categoryName"
    static let categoryItems = "categoryItems"
    static let itemSize = "itemSize"
}
