import Foundation

class Utility {
    class func loadBabiesFromJSON(fileName: String, success: (([Baby])-> Void), failure: ((String)-> Void)) {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            failure("\(fileName) not found")
            return
        }
        do {
            let decoder = JSONDecoder()
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let rawDataSet = try decoder.decode([[String]].self, from: data)
            
            let result = rawDataSet.compactMap({ array in
                parseBaby(array: array,
                          birthYearIndex:0,
                          genderIndex:1,
                          ethnicityIndex:2,
                          nameIndex:3,
                          noOfBabiesIndex:4,
                          rankIndex:5)
                
            })
            
            success(result)
        }
        
        catch let DecodingError.dataCorrupted(context) {
            print("DecodingError.dataCorrupted '\(context)'")
            failure(context.debugDescription)
        }
        catch let DecodingError.keyNotFound(key, context) {
            print("DecodingError.keyNotFound")
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            failure(context.debugDescription)
            
        }
        catch let DecodingError.valueNotFound(value, context) {
            print("DecodingError.valueNotFound")
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            failure(context.debugDescription)
        }
        catch let DecodingError.typeMismatch(type, context)  {
            print("DecodingError.typeMismatch")
            
            for key in context.codingPath {
                print(key)
            }
            
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            failure(context.debugDescription)
        }
        catch {
            print("localizedDescription:", error.localizedDescription)
            failure(error.localizedDescription)
        }
    }
    
    class func parseBaby(array: [String],
                         birthYearIndex: Int,
                         genderIndex: Int,
                         ethnicityIndex: Int,
                         nameIndex: Int,
                         noOfBabiesIndex: Int,
                         rankIndex: Int) -> Baby {
        Baby(birthYear: Int(array[birthYearIndex]) ?? 0,
                   gender: Gender(rawValue: array[genderIndex]) ?? .male,
                   ethnicity: array[ethnicityIndex],
                   name: array[nameIndex],
                   noOfBabies: Int(array[noOfBabiesIndex]) ?? 0,
                   rank: Int(array[rankIndex]) ?? 0)
    }
}
 
