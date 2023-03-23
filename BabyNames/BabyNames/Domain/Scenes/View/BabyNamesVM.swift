import Foundation

class BabyNamesVM {
    var babiesVM: LoadBabies.LoadData.ViewModel?
    var popularBaby: LoadBabies.LoadPopular.ViewModel?
    
    var gender: Gender?
    var ethnicity: String = ""
    
    var ethnicities: [String] {
        get {
            guard let babiesVM else { return [] }
            
            let result = babiesVM.babies.filter({$0.gender == gender}).compactMap({$0.ethnicity}) 
            return result.removingDuplicates()
        }
    }
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}


