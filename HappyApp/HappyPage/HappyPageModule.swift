import UIKit

enum HappyPage {
    static func moduleAssembly() -> UIViewController {
        let viewModel = HappyPageViewModel()
        let view = HappyPageViewController(viewModel: viewModel)
        return view
    }
}
