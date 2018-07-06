//
//  NotesController.swift
//  Notes
//
//  Created by Zachary Frew on 7/6/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import Foundation

class NoteController {
    
    // MARK: - Singleton Instance
    static let shared = NoteController()
    
    // MARK: - Properties
    var notes: [Note] = []
    
    // MARK: - CRUD Methods
    func createNoteWith(body: String) {
        let newNote = Note(body: body)
        notes.append(newNote)
        saveToPersistentStore()
    }
    
    func update(note: Note, with body: String) {
        note.body = body
        saveToPersistentStore()
    }
    
    func deleteNote(_ note: Note) {
        guard let noteToRemove = notes.index(of: note) else { return }
        notes.remove(at: noteToRemove)
        saveToPersistentStore()
    }
    
    // MARK: - Persistence
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let playlistLocation = "notes.json"
        let fullURL = documentsDirectory.appendingPathComponent(playlistLocation)
        return fullURL
    }
    
    func saveToPersistentStore() {
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(notes)
            try data.write(to: fileURL())
        } catch EncodingError.invalidValue {
            print(EncodingError.invalidValue.rawValue)
        } catch let error {
            print("Error occurred: \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistentStore() {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let notesFromDecoder = try jsonDecoder.decode([Note].self, from: data)
            notes = notesFromDecoder
        }
        catch DecodingErrors.dataCorrupted {
            print(DecodingErrors.dataCorrupted.rawValue)
        } catch DecodingErrors.keyNotFound {
            print(DecodingErrors.keyNotFound.rawValue)
        } catch DecodingErrors.typeMismatch {
            print(DecodingErrors.typeMismatch.rawValue)
        } catch DecodingErrors.valueNotFound {
            print(DecodingErrors.valueNotFound.rawValue)
        } catch let error {
            print("Unknown error occurred: \(error.localizedDescription).")
        }
    }
    
    // MARK: - Persistence Error Messages
    enum EncodingError: String, Error {
        case invalidValue = "The encoder or its contains could not encode the given value."
    }
    
    enum DecodingErrors: String, Error {
        case dataCorrupted = "The data is corrupted or otherwise invalid."
        case keyNotFound = "The keyed decoding container did not contain the given key."
        case typeMismatch = "The key cannot be decoded because he type does not match what was encoded."
        case valueNotFound = "The value cannot be found."
    }
    
}
