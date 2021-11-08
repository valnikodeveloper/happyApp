import RxSwift
import RxCocoa

final class HappyPageViewModel {
    private let errorText = PublishSubject<String>()
    let categories = PublishSubject<[CategoryDataSource]>()

    var happyPageViewBinder: Observable<[CategoryDataSource]> {
      return categories.asObservable()
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

private extension HappyPageViewModel {
    func modelData(index: Int) -> [String: Any] {
        var data = [String: Any]()
        switch index {
        case 0:
            data[DataSourceConstants.categoryName] = "Upcoming Events"
            let card0 = CategoryItem(imageName: "card0", subTitle: nil)
            let card1 = CategoryItem(imageName: "card1", subTitle: nil)
            let card2 = CategoryItem(imageName: "card2", subTitle: nil)
            let card3 = CategoryItem(imageName: "card3", subTitle: nil)
            data[DataSourceConstants.categoryItems] = [card0, card1, card2, card3]
        case 1:
            data[DataSourceConstants.categoryItems] = [CategoryItem(imageName: "horoscope", subTitle: nil)]
        case 2:
            let news1 = CategoryItem(imageName: "news1",
                                     subTitle: "How to choose a gift for your girlfriend and don’t get embarassed")
            let news2 = CategoryItem(imageName: "news2", subTitle: "subtitle is undefined")
            data[DataSourceConstants.categoryName] = "Articles & News"
            data[DataSourceConstants.categoryItems] = [news1, news2]
        default:
            break
        }
        return data
    }

    // MARK: Stub - Imagine that view recieve some data from server here
    func recievedSomeDataStub() {
        var localCategories = [CategoryDataSource]()

        for index in .zero ..< 3 {
            var info = [String: Any]()
            info = modelData(index: index)
            let category = CategoryDataSource(with: info)
            localCategories.append(category)
        }

        categories.onNext(localCategories)
    }
}

