import Foundation

protocol BabyInteractorBusinessLogic {
    func loadBabies(request: LoadBabies.LoadFromJSON.Request)
    func loadBabies(request: LoadBabies.LoadPopular.Request)
}

class BabyInteractor {
    var presenter: BabyPresenterBusinessLogic?
}

extension BabyInteractor: BabyInteractorBusinessLogic {
    
    func loadBabies(request: LoadBabies.LoadFromJSON.Request) {
        Utility.loadBabiesFromJSON(fileName: "BabyList", success: { babies in
            let response = LoadBabies.LoadFromJSON.Response(babies: babies)
            presenter?.loadedBabies(response: response)
            
        }, failure: { message in
            print(message)
        })
    }
    
    func loadBabies(request: LoadBabies.LoadPopular.Request) {
        
        let babiesByGender = request.babies.filter({$0.gender == request.gender})
        
        guard !babiesByGender.isEmpty else {
            presenter?.loadedBabies(response: LoadBabies.LoadPopular.Response())
            return
        }
        
        let baby = babiesByGender.randomElement()
        let response = LoadBabies.LoadPopular.Response(baby: baby)
        presenter?.loadedBabies(response: response)
    }
}
