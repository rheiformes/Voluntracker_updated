//
//  ViewController.swift
//  IP11_Voluntracker
//
//  Created by Rai, Rhea on 12/16/22.
//

import UIKit




class ViewController: UIViewController {

    //login view
    @IBOutlet var usInput: UITextField!
    @IBOutlet var pwInput: UITextField!
    
    let username = "rhea"
    let password = "123"
    
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var signUpBtn: UIButton!
    
    //hours view
    @IBOutlet var eventTime: UIDatePicker!
    @IBOutlet var eventTitle: UITextField!
    @IBOutlet var logActivityBtn: UIButton!
    
    @IBOutlet var hoursBar: UIProgressView!
    @IBOutlet var currentHrsLbl: UILabel!
    
    var goalHours = 100
    var storedHours = 20.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
    /*LOG IN*/
    
    @IBAction func loginPressed(_ sender: Any) {
        performSegue(withIdentifier: "login", sender: sender)
        setStartingVals()
    }

    func verifyLogin() {
        
    }
    
    func addNewAccount() {
        
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        performSegue(withIdentifier: "login", sender: sender)
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
    
    
    
    /* ENTERING HOURS */
    
    
    func setStartingVals() {
        self.currentHrsLbl?.text = String(format: "%.2f", self.storedHours)
        self.hoursBar?.progress = Float(self.storedHours / Double(self.goalHours))
    }
    
    @IBAction func logActivityPressed(_ sender: Any) {
        updateHours()
        clearEntry()
    }
    
    func clearEntry() {
        self.eventTime.countDownDuration = 0
        self.eventTitle.text = ""
    }
    
    
    func updateHours() {
        //calculate hour change
        guard let currHrs = Double(self.currentHrsLbl.text!) else {
            return
        }
        
        let eventHrs = Double (self.eventTime.countDownDuration / 3600.0)
        print(eventHrs)
        
        let newTotalHrs = currHrs + eventHrs
        
        //update and format hour label
        self.currentHrsLbl.text = String(format: "%.2f", newTotalHrs)
        
        //update bar
        self.hoursBar.progress = Float(newTotalHrs / Double(self.goalHours))
        
    }


}

