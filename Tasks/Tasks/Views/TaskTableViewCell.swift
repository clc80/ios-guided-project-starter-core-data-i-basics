//
//  TaskTableViewCell.swift
//  Tasks
//
//  Created by Ben Gohlke on 4/20/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    // To manage it's own reuse identifier
    static let reuseIdentifier = "TaskCell"
    
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    
    
    // MARK: - IBOutlets
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var completedButton: UIButton!
    
    // MARK: - Functions
    func updateViews() {
        guard let task = task else { return }
        
        let buttonImage = task.complete ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
        completedButton.setImage(buttonImage, for: .normal)
        
        nameLabel.text = task.name
    }
    
    @IBAction func completeToggled(_ sender: Any) {
        guard let task = task else { return }
        task.complete.toggle()
        
        do {
            try CoreDataStack.shared.mainContext.save()
        } catch {
            NSLog("Error saving context: \(error)")
            CoreDataStack.shared.mainContext.reset()
        }
        
        let buttonImage = task.complete ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
        completedButton.setImage(buttonImage, for: .normal)
    }
}
