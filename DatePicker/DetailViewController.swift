//
//  DetailViewController.swift
//  DatePicker
//
//  Created by Chakane Shegog on 5/17/21.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK: - outlets and properties
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var selectedDateLabel: UILabel!
    @IBOutlet weak var switchControl: UISwitch!
    
    
    
    // we need our object (Event) from our source view controller (CreateEventViewController)
    var event: Event?
    
    // Dateformatter helps us format the Date object
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyy h:mm a"
        return formatter
    }() // <- represents a closure that calls the function
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: - Actions and methods
    func updateUI() {
        guard let date = event?.date else {
            return
        }
        
        // set switch position based on value of willAttend
        // if true, switch will be turned on, else switch will be turned off.
        selectedDateLabel.text = dateFormatter.string(from: date)
        switchControl.isOn = event?.willAttend ?? false
        messageLabel.text = event?.name ?? "Event name not available"
    }
    
    @IBAction func rsvpChanged(_ sender: UISwitch) {
        event?.willAttend = sender.isOn
    }
    


}
