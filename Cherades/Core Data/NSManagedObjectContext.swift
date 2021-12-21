//
//  NSManagedObjectContext.swift
//  Cherades
//
//  Created by Dave Bage on 27/11/2021.
//

import CoreData

extension NSManagedObjectContext {
    func fetchAll<T: NSManagedObject>(_ type: T.Type, batch: Int? = nil, predicate: NSPredicate? = nil, sorting: [NSSortDescriptor]? = nil) -> [T] {
        guard let fetchRequest = fetchRequestFor(type) else {
            return []
        }
        
        if let batch = batch {
            fetchRequest.fetchLimit = batch
        }
        
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sorting
        
        do {
            return try fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    private func fetchRequestFor<T: NSManagedObject>(_ type: T.Type) -> NSFetchRequest<T>? {
        guard let name = T.entity().name else {
            return nil
        }
        
        return NSFetchRequest<T>(entityName: name)
    }
    
    func fetch<T: NSManagedObject>(_ type: T.Type, predicate: NSPredicate? = nil, sorting: [NSSortDescriptor]? = nil) -> [T]? {
        guard let fetchRequest = fetchRequestFor(type) else {
            return nil
        }
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sorting
        
        return try? fetch(fetchRequest)
    }
    
    func fetchWithID<T: NSManagedObject>(_ type: T.Type, id: NSManagedObjectID) -> T? {
        return object(with: id) as? T
    }
}

