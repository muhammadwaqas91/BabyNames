import Foundation

protocol BabyPresenterBusinessLogic {
    func loadedBabies(response: LoadBabies.LoadFromJSON.Response)
    func loadedBabies(response: LoadBabies.LoadPopular.Response)
}

class BabyPresenter: BabyPresenterBusinessLogic
{
    weak var viewController: BabyNamesViewControllerDisplayLogic?
    
    func loadedBabies(response: LoadBabies.LoadFromJSON.Response) {
        let viewModel = LoadBabies.LoadFromJSON.ViewModel(babies: response.babies)
        viewController?.displayLoadedBabies(viewModel: viewModel)
    }
    
    func loadedBabies(response: LoadBabies.LoadPopular.Response) {
        let viewModel = LoadBabies.LoadPopular.ViewModel(baby: response.baby)
        viewController?.displayPopularBaby(viewModel: viewModel)
    }
}
