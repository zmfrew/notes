//
//  NotesListTableViewController.swift
//  Notes
//
//  Created by Zachary Frew on 7/6/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import UIKit

class NotesListTableViewController: UITableViewController {
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        NoteController.shared.loadFromPersistentStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NoteController.shared.notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        let noteToDisplay = NoteController.shared.notes[indexPath.row]
        cell.textLabel?.text = noteToDisplay.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let noteToDelete = NoteController.shared.notes[indexPath.row]
            NoteController.shared.deleteNote(noteToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditNote" {
            guard let destinationVC = segue.destination as? NotesDetailViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
            let noteToEdit = NoteController.shared.notes[indexPath.row]
            destinationVC.note = noteToEdit
        }
    }
    
}
