import RxSwift
import RxCocoa

final class HappyPageViewModel {
    private let categoryDataSource = PublishSubject<[CategoryDataSource]>()
    private let errorText = PublishSubject<String>()

    var happyPageViewBinder: Observable<[CategoryDataSource]> {
      return categoryDataSource.asObservable()
    }

    var happyPageErrorBinder: Observable<String> {
      return errorText.asObservable()
    }

    func readyToRecieve() {
        recievedSomeDataStub()
    }

    func makeStubCall() {
        errorText.onNext("Under construction, sorry")
    }
}

extension HappyPageViewModel {
    private func modelData(index: Int) -> [String: Any] {
        var data = [String: Any]()
        switch index {
        case 0:
            data[DataSourceConstants.categoryName] = "Upcoming Events"
            let card0 = CategoryItem(imageName: "card0", subTitle: nil)
            let card1 = CategoryItem(imageName: "card1", subTitle: nil)
            let card2 = CategoryItem(imageName: "card2", subTitle: nil)
            let card3 = CategoryItem(imageName: "card3", subTitle: nil)
            data[DataSourceConstants.categoryItems] = [card0, card1, card2, card3]
            data[DataSourceConstants.itemSize] = CGSize(width: 158, height: 178)
        case 1:
            data[DataSourceConstants.categoryItems] = [CategoryItem(imageName: "horoscope", subTitle: nil)]
            data[DataSourceConstants.itemSize] = CGSize(width: 355, height: 180 + 60)
        case 2:
            let subTitle = "How to choose a gift for your girlfriend and don’t get embarassed"
            let extendedHeight = subTitle.calculatedHeight(with: 316,
                                             and: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium))
            let news1 = CategoryItem(imageName: "news1",
                                     subTitle: "How to choose a gift for your girlfriend and don’t get embarassed")
            let news2 = CategoryItem(imageName: "news2", subTitle: "subtitle is undefined")
            data[DataSourceConstants.categoryName] = "Articles & News"
            data[DataSourceConstants.categoryItems] = [news1, news2]
            let heightOfPicture: CGFloat = 170
            let constraintBetween: CGFloat = 22
            data[DataSourceConstants.itemSize] = CGSize(width: 328, height:
                                                            extendedHeight +
                                                            heightOfPicture +
                                                            constraintBetween)
        default:
            break
        }
        return data
    }

    // MARK: Stub - Imagine that view recieve some data from server here
    private func recievedSomeDataStub() {
        var categories = [CategoryDataSource]()

        for index in .zero ..< 3 {
            var info = [String: Any]()
            info = modelData(index: index)
            let category = CategoryDataSource(with: info)
            categories.append(category)
        }

        categoryDataSource.onNext(categories)
    }
}

