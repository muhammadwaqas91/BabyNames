import UIKit

protocol BabyNamesViewControllerDisplayLogic: AnyObject {
    func displayLoadedBabiesFromJSON(viewModel: LoadBabies.LoadData.ViewModel)
    func displayPopularBaby(viewModel: LoadBabies.LoadPopular.ViewModel)
}

class BabyNamesViewController: UIViewController {

    @IBOutlet var popularNameView: PopularNameView!
    
    var interactor: BabyInteractor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureVIP()
        
        popularNameView.delegate = self
        loadBabiesFromJSON()
    }
    
    func configureVIP() {
        let interactor = BabyInteractor()
        let presenter = BabyPresenter()
        
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
    }
    
    func loadBabiesFromJSON() {
        interactor?.loadBabiesFromJSON(request: LoadBabies.LoadData.Request())
    }
}

extension BabyNamesViewController: PopularNameViewDelegate {
    func filterBy(gender: Gender) {
        interactor?.loadBaby(request: LoadBabies.LoadPopular.Request(gender: gender, babies: popularNameView.vm.babiesVM?.babies ?? []))
    }
}

extension BabyNamesViewController: BabyNamesViewControllerDisplayLogic {
    func displayLoadedBabiesFromJSON(viewModel: LoadBabies.LoadData.ViewModel) {
        popularNameView.vm.babiesVM = viewModel
        popularNameView.updateUI()
    }
        
    func displayPopularBaby(viewModel: LoadBabies.LoadPopular.ViewModel) {
        popularNameView.vm.popularBaby = viewModel
        popularNameView.updateUI()
    }
}
