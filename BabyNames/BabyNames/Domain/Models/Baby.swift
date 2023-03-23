import Foundation

enum Gender: String {
    case male = "MALE"
    case female = "FEMALE"
}

struct Baby {
    let birthYear: Int
    let gender: Gender
    let ethnicity: String
    let name: String
    let noOfBabies: Int
    let rank: Int
}
