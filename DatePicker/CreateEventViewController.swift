//
//  ViewController.swift
//  DatePicker
//
//  Created by Chakane Shegog on 5/16/21.
//

import UIKit

class CreateEventViewController: UIViewController {
    
    // MARK: - Outlets and Properties
    @IBOutlet weak var eventTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var createEventButton: UIButton!
    @IBOutlet weak var rsvpLabel: UILabel!
    
    var event: Event! {
        didSet {  // property observer, gets called when the property changes (when it gets assigned a new value)
            
            // update UI when the event changes
            if event.willAttend {
                // update label and button
                rsvpLabel.text = "RSVP YES"
                createEventButton.setTitle("View Event", for: .normal)
            } else {
                rsvpLabel.text = "RSVP NO"
                createEventButton.setTitle("RSVP to Event", for: .normal)
            }
            
        }
    }
    
    // MARK: - View Controller Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set this VC as the object for the eventTextField
        // Date() gets us the current date and time (instantiatiates)
        event = Event(name: "Event name not set", willAttend: false, date: Date())
        eventTextField.delegate = self
        
        // configure the date picker
        datePicker.minimumDate = Date() // user is not annlowed to set an event prior to todays date
        
        
    }
    
    
    // the segue in this method nows its source and destination
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepareForSegue")
        
        // setup and pass the event data to the detail view controller
        
        // we need an instance of the detail view controller (this is where we are transitioning to)
        guard  let detailViewController = segue.destination as? DetailViewController else {
            return
        }
        
        // we now set the event on the detail view controller
        detailViewController.event = event // our destination now has an event
        
        
        // let detailViewController: = segue.destination <- this is a UIviewController
        
    }
    
    // MARK: - Actions and methods
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        
        // updates the event's date
        event.date = sender.date
    }
    
    // unwinding a segue - retruning from a source VC
    // 1. write an @IBAction func
    // 2. a UIStoryBoardSegue is required e.g segue: UIStoryboardSegue
    // 3. type cast ( as? ) and get access to the source view cobtroller instance.
    // 4. setup UI accordingly see event = detailViewcontroller.event didSet{....} pn event property above
    // 5. in story board, connect action button to "exit" icon in source VC and select e.g this method (updateUIFromUnwindSegue)

    
    // unwind segue action - we need to create an IBAction for the unwind segue
    // we aslo need to connect the action button from the
    //   source view controller (DetailViewController) to this unwind segue action
    
    // were required to have a param of type UIStoryBoardSegue in the unwind segue action
    // why? -> this is the only wat the IB can recognize and unwind segue to connect to
    @IBAction func updateUIFromUnwindSegue(segue: UIStoryboardSegue) {
        
        // we need access to the source destination view controller
        guard let detailViewController = segue.source as? DetailViewController else {
            return
        }
        event = detailViewController.event
        // after the event is set here, didSet on the event property gets called and the UI is updated
        // ui elements that get updated are the rsvpLabel's text and createEventButton's title Label
        
        
        
    }
    
    
}




// allows the user to hit the return button and exit the keyboard
extension CreateEventViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        // updates the event's name
        event.name = eventTextField.text ?? "" // nil-coelescing to unwrap
        return true
    }
}


