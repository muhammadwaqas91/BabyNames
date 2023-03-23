import Foundation

protocol BabyPresenterBusinessLogic {
    func loadBabiesFromJSON(response: LoadBabies.LoadData.Response)
    func loadedBaby(response: LoadBabies.LoadPopular.Response)
}

class BabyPresenter: BabyPresenterBusinessLogic
{
    weak var viewController: BabyNamesViewControllerDisplayLogic?
    
    func loadBabiesFromJSON(response: LoadBabies.LoadData.Response) {
        let viewModel = LoadBabies.LoadData.ViewModel(babies: response.babies)
        viewController?.displayLoadedBabiesFromJSON(viewModel: viewModel)
    }
    
    func loadedBaby(response: LoadBabies.LoadPopular.Response) {
        let viewModel = LoadBabies.LoadPopular.ViewModel(baby: response.baby)
        viewController?.displayPopularBaby(viewModel: viewModel)
    }
}
