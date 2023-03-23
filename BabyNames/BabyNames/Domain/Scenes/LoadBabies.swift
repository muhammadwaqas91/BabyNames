import Foundation

enum LoadBabies {
       
    enum LoadData {
        struct Request {
        }
        
        struct Response {
            var babies: [Baby]
        }
        
        struct ViewModel {
            var babies: [Baby]
        }
    }
    
    enum LoadPopular {
        struct Request {
            var gender: Gender
            var babies: [Baby]
        }
        
        struct Response {
            var baby: Baby?
        }
        
        struct ViewModel {
            var baby: Baby?
        }
    }
}

