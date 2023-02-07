//
//  ViewController.swift
//  IP11_Voluntracker
//
//  Created by Rai, Rhea on 12/16/22.
//

import UIKit

//TODO: (Jan 30th) all else finished, just need to add set goal, tie it into the value of the account class. 
//UPDATE 2/7 : DONE FINALLY THANK GOD, ITS BEEN A MONTH

//var accounts: [String:Account] = ["rhea" : Account(username: "rhea", password: "123", goalHours: 100, completedHours: 10)] //[:]
//
//var currAcctKey: String = "rhea"
//let defaults = UserDefaults.standard


class ViewController: UIViewController {

    
    //login view
    @IBOutlet var usInput: UITextField!
    @IBOutlet var pwInput: UITextField!
    @IBOutlet var goalInput: UITextField!
    
    //var allAcctsCredentials: Dictionary = ["rhea":"123"]
    //TODO: FIX THIS LINE
    
    
    //let accountsDict:
    
    
    var accounts: [String:Account] = ["rhea" : Account(username: "rhea", password: "123", goalHours: 100, completedHours: 0)] //[:]
    var currAcctKey: String = "rhea"

    let defaults = UserDefaults.standard
    
    
    
    
    
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var signUpBtn: UIButton!
    
    //hours view
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("got here")
        loginView()
        

        
        //set the useable accounts variable (for referencing/editing) to
        if let myDefaultAccounts = defaults.data(forKey: "myAccounts") {
            do {
                let decoder = JSONDecoder()
                
                self.accounts = try decoder.decode([String: Account].self, from: myDefaultAccounts)

            } catch {
                print("unable to decode")
            }
        }
                                     
        
        //self.accounts = (defaults.dictionary(forKey: "myAccounts")! as? [String: Account])!
    }
    
    @IBAction func loginView() {
        self.usInput.isEnabled = true
        self.pwInput.isEnabled = true
        self.goalInput.isEnabled = false
        self.goalInput.isHidden = true
        //self.goalInput.removeFromSuperview()
        
        
        self.loginBtn.isEnabled = true
        self.signUpBtn.isEnabled = true
        self.signUpBtn.titleLabel!.text = "sign up"
    }
    
    @IBAction func setGoalView() {
        self.usInput.isEnabled = false
        self.pwInput.isEnabled = false
        self.goalInput.isEnabled = true
        self.goalInput.isHidden = false
        
        self.signUpBtn.titleLabel!.text = "let's go!"
        self.loginBtn.isEnabled = false
        self.loginBtn.isHidden = true
        
    }
    

    
    /*LOG IN*/
    
    @IBAction func loginPressed(_ sender: Any) {
        let usernameInput = self.usInput?.text ?? ""
        let passwordInput = self.pwInput?.text ?? ""
              
        if verifyLogin(usernameInput, passwordInput) {
            currAcctKey = usernameInput
            defaults.set(currAcctKey, forKey: "currAcctKey")
            performSegue(withIdentifier: "login", sender: sender)
            
//            setStartingVals()
            //TODO: FIX THIS SO IT CALLES FROM THE NEXT VIEW COTRNROLLER
            
        }
        
        
    }

    func verifyLogin(_ usInput:String, _ pwInput:String) -> Bool {
        if let AccountExists = self.accounts[usInput] {
            if AccountExists.password == pwInput {
                return true
            }
        }
        return false
        
    }
    
    func addNewAccount(userName: String, pwd: String, goalHrs: Double) { //TODO: add hours functionality
        self.accounts[userName] = Account(username: userName, password: pwd, goalHours: goalHrs, completedHours: 0)
        do {
                let encoder = JSONEncoder()
                let encodedAccts = try encoder.encode(accounts) //encode(accountsDict)

                defaults.set(encodedAccts, forKey: "myAccounts")

        } catch {
            print("encoding didn't work, check the defaults again")

        }
        
        
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        let usernameInput = self.usInput?.text ?? ""
        let passwordInput = self.pwInput?.text ?? ""
        let goalHours = Double(self.goalInput?.text ?? "100.0") ?? 100.0 //no idea what's going on with the 2 100s but it works for now, fix it later
        if (!self.goalInput.isEnabled) {
            setGoalView()
        }
        
        else if (self.goalInput.isEnabled) {
            addNewAccount(userName: usernameInput, pwd: passwordInput, goalHrs: goalHours)
            currAcctKey = usernameInput
            defaults.set(currAcctKey, forKey: "currAcctKey")
            performSegue(withIdentifier: "login", sender: sender)
            loginView()
        }
        
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender = sender as? UIButton else {return}
        
        if sender == self.loginBtn {
            segue.destination.navigationItem.title = "Welcome back, " + (self.usInput.text ?? "user")
            
        }
        else if sender == self.signUpBtn {
            segue.destination.navigationItem.title = "Hi, " + (self.usInput.text ?? "user")!
        }

        
    }
    


}

class ViewController2: UIViewController {
    
    
    @IBOutlet var eventTime: UIDatePicker!
    @IBOutlet var eventTitle: UITextField!
    @IBOutlet var logActivityBtn: UIButton!
    
    @IBOutlet var hoursBar: UIProgressView!
    @IBOutlet var currentHrsLbl: UILabel!
    
    @IBOutlet var goalHoursConstantLbl: UILabel!
    
    var accounts: [String:Account] = ["rhea" : Account(username: "rhea", password: "123", goalHours: 100, completedHours: 10)] //[:]
    
    var currAcctKey: String = ""
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currAcctKey = defaults.string(forKey: "currAcctKey")!
        
        if let myDefaultAccounts = defaults.data(forKey: "myAccounts") {
            do {
                let decoder = JSONDecoder()
                
                self.accounts = try decoder.decode([String: Account].self, from: myDefaultAccounts)

               
            } catch {
                print("unable to decode")
            }
        }
        setStartingVals()
        
        
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//
//    }
    
    
    /* ENTERING HOURS */
    
    
    func setStartingVals() {
        print(accounts[currAcctKey]!.completedHours)
        //self.currentHrsLbl
        //self.loadViewIfNeeded()
        //TODO: FIX THIS PART - Unexpectedly found nil while implicitly unwrapping an Optional value
        //self.currentHrsLbl?.text = "50"
        self.currentHrsLbl.text = String(format: "%.2f", accounts[currAcctKey]!.completedHours)
        self.hoursBar.progress = Float(accounts[currAcctKey]!.completedHours / accounts[currAcctKey]!.goalHours) //TODO: fix - it doesn't update this
        goalHoursConstantLbl.text = "Goal: \(accounts[currAcctKey]!.goalHours) hours"
    }
    
    @IBAction func logActivityPressed(_ sender: Any) {
        updateHours()
        clearEntry()
    }
    
    func clearEntry() {
        self.eventTime.countDownDuration = 0
        self.eventTitle.text = ""
    }
    
    
    //TODO: FIX THIS:
    func updateHours() {
        //calculate hour change
               
        let eventHrs = Double (self.eventTime.countDownDuration / 3600.0)
        
        
        
        accounts[currAcctKey]!.completedHours += eventHrs
        print("Event Hours: \(eventHrs)\tTotal Hours: \(accounts[currAcctKey]!.completedHours)")
        //update and format hour label
        self.currentHrsLbl.text = String(format: "%.2f", accounts[currAcctKey]!.completedHours)
        
        //update bar
        
        self.hoursBar.progress = Float(accounts[currAcctKey]!.completedHours / accounts[currAcctKey]!.goalHours)
        
        //set defaults
        //TODO: FIX THIS
        do {
            let encoder = JSONEncoder()
            let encodedAccts = try encoder.encode(accounts)
            defaults.set(encodedAccts, forKey: "myAccounts")
            
        } catch {
            print("encoding didn't work after updating, check the default again")
        }
        //defaults.set(accounts, forKey: "myAccounts")
        if let myDefaultAccounts = defaults.data(forKey: "myAccounts") {
            do {
                let decoder = JSONDecoder()
                
                self.accounts = try decoder.decode([String: Account].self, from: myDefaultAccounts)
                print(accounts["rhea"]?.completedHours)

            } catch {
                print("unable to decode")
            }
        }
    }
    
    
}
