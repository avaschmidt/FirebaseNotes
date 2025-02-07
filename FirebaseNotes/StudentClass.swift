import Foundation
import FirebaseCore
import FirebaseDatabase

var ref2 = Database.database().reference()

class StudentClass{
    
    var name : String
    var age : Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    init(dict : [String : Any]){
        if let a = dict["age"] as? Int{
                    age = a
                }
                else{
                    age = 0
                }
        if let n = dict["name"] as? String{
            name = n
                }
                else{
                    name = "John Doe"
                }

    }
    
    
    func saveToFirebase(){
        let dict = ["name": name, "age":age] as [String: Any]
        ref2.child("students2").childByAutoId().setValue(dict)
    }
    
    
}
