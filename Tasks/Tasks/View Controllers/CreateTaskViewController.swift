//
//  CreateTaskViewController.swift
//  Tasks
//
//  Created by Ben Gohlke on 4/20/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class CreateTaskViewController: UIViewController {

    // MARK: - Properties
    var complete = false
    
    // MARK: - IBOutlets
    @IBOutlet var namedTextField: UITextField!
    @IBOutlet var notesTextView: UITextView!
    @IBOutlet var priorityControl: UISegmentedControl!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func cancel(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        
        // Grab the individual values from the views
        guard let name = namedTextField.text,
            !name.isEmpty else { return }
        let notes = notesTextView.text
        
        let selectedPriority = priorityControl.selectedSegmentIndex
        
        let priority = TaskPriority.allCases[selectedPriority]
        
        Task(name: name,
             notes: notes,
             complete: complete,
             priority: priority,
            context: CoreDataStack.shared.mainContext)
        
        do {
            try CoreDataStack.shared.mainContext.save()
            navigationController?.dismiss(animated: true, completion: nil)
        } catch {
            NSLog("Error saving manage object context: \(error)")
        }
        
    }
    
    @IBAction func toggleComplete(_ sender: UIButton) {
        complete.toggle()
        
        let image = complete ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
        sender.setImage(image, for: .normal)
        
    }
    
    
}
