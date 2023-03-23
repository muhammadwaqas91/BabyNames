import Foundation

protocol BabyInteractorBusinessLogic {
    func loadBabiesFromJSON(request: LoadBabies.LoadData.Request)
    func loadBaby(request: LoadBabies.LoadPopular.Request)
}

class BabyInteractor {
    var presenter: BabyPresenterBusinessLogic?
}

extension BabyInteractor: BabyInteractorBusinessLogic {
    
    func loadBabiesFromJSON(request: LoadBabies.LoadData.Request) {
        Utility.loadBabiesFromJSON(fileName: "BabyList", success: { babies in
            let response = LoadBabies.LoadData.Response(babies: babies)
            presenter?.loadBabiesFromJSON(response: response)
            
        }, failure: { message in
            print(message)
        })
    }
    
    func loadBaby(request: LoadBabies.LoadPopular.Request) {
        
        let babiesByGender = request.babies.filter({$0.gender == request.gender})
        
        guard !babiesByGender.isEmpty else {
            presenter?.loadedBaby(response: LoadBabies.LoadPopular.Response())
            return
        }
        
        let baby = babiesByGender.randomElement()
        let response = LoadBabies.LoadPopular.Response(baby: baby)
        presenter?.loadedBaby(response: response)
    }
}
