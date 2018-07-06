//
//  NotesDetailViewController.swift
//  Notes
//
//  Created by Zachary Frew on 7/6/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import UIKit

class NotesDetailViewController: UIViewController {
    
    // MARK: - Properties
    var note: Note?
    
    // MARK: - Outlets
    @IBOutlet weak var noteBodyTV: UITextView!
    
    // MARK: - Actions
    @IBAction func saveNote(_ sender: UIBarButtonItem) {
        guard let noteBody = noteBodyTV.text, !noteBody.isEmpty else { return }
        if let note = note {
            NoteController.shared.update(note: note, with: noteBody)
        } else {
            NoteController.shared.createNoteWith(body: noteBody)
        }
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        NoteController.shared.loadFromPersistentStore()
        updateViews()
    }
    
    // MARK: - Methods
    func updateViews() {
        guard let note = note else { return }
        noteBodyTV.text = note.body
    }
    
}
