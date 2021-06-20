//
//  ViewControllerManager.swift
//  CoreDataTestApp
//
//  Created by AP Aliaksandr Chekushkin on 6/20/21.
//

import Foundation
import CoreData
import UIKit

struct ProfilesManager {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //prevents outside world access to the source of truth
    private var profiles: [Profile] = []
    
    // value to use for UI purposes, hides the primal source
    var userProfiles: [Profile] {
        get { profiles }
    }
    
    init() {
        self.loadProfiles()
    }
    
    mutating func loadProfiles() {
        do { self.profiles = try context.fetch( Profile.fetchRequest() ) as! [Profile] }
        catch { print("An error occured") }
    }
    
    mutating func addNewEntry(name: String) {
        let newProfile = Profile(context: context)
        newProfile.name = name as NSObject
        
        self.saveEntry()
    }
    
    private mutating func saveEntry() {
        do {
            try context.save()
            self.loadProfiles()
        }
        catch { print("An error occured when tried to save profile entry.") }
    }
    
    mutating func removeEntry(at index: Int) {
        context.delete(profiles[index])
        saveEntry()
        loadProfiles()
    }
}
