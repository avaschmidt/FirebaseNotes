//inputing firebase packages
import FirebaseCore
import FirebaseDatabase
import UIKit

//making firebase variables
var ref: DatabaseReference!

var studentArray = [StudentClass]()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var ageOutlet: UITextField!
    @IBOutlet weak var tableViewOutlet: UITableView!
    var name = ""
    var names = [String]()
    @IBOutlet weak var nameOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        //initializing firebase variable
        ref = Database.database().reference()
        readFromFirebase()
    
    }
    
    @IBAction func saveStudentAction(_ sender: UIButton) {
        var theName = nameOutlet.text!
        var theAge = Int(ageOutlet.text!)!
       var newStu = StudentClass(name: theName, age: theAge)
        studentArray.append(newStu)
        newStu.saveToFirebase()
    }
    
    

    @IBAction func saveAction(_ sender: UIButton) {
        name = nameOutlet.text!
        names.append(name)
        //saving to firebase
        ref.child("students").childByAutoId().setValue(name)
        self.tableViewOutlet.reloadData()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        cell.textLabel?.text = "\(names[indexPath.row])"
        return cell
    }
    

    

    func readFromFirebase(){
        ref.child("students").observe(.childAdded, with: { (snapshot) in
                   // snapshot is a dictionary with a key and a value
                    
                    // this gets each name from each snapshot
                    let n = snapshot.value as! String
                    // adds the name to an array if the name is not already there
                    if !self.names.contains(n){
                        self.names.append(n)
                        print(n)
                    self.tableViewOutlet.reloadData()
                    }
                })
        
        //called after .childAdded is done
                ref.child("students").observeSingleEvent(of: .value, with: { snapshot in
                        print("--inital load has completed and the last user was read--")
                    print(self.names)
                    self.tableViewOutlet.reloadData()
                    })
    }
    
}

