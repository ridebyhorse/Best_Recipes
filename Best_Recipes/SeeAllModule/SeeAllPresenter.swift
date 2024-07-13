import UIKit

protocol SeeAllPresenter: AnyObject {
    var view: (any SeeAllController)? { get }
    init(view: any HomeController)
    func viewDidLoad()
    var flowHandler: HomeNavigationHandler? { get set }
}

protocol SeeAllController: Configurable {
    typealias Model = SeeAllViewModel
    var presenter: SeeAllPresenter? { get }
}
