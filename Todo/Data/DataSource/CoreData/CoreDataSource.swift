//
//  CoreDataSource.swift
//  Todo
//
//  Created by Erkan Ugurlu on 28.03.2021.
//

import Foundation
import CoreData

class CodeDataSource {
    private let dataModelName = "ToDoList"
    private let dateColumnName = "createDate"

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: dataModelName)
        container.loadPersistentStores { _, error in
            guard let error = error else { return }
            fatalError("Error: \(error)")
        }
        return container
    }()

    private func save(context: NSManagedObjectContext) throws {
        guard context.hasChanges else { return }
        try context.save()
    }
}

extension CodeDataSource: DataSource {

    func create(item: ToDoItem) throws {
        let toDoDTO = ToDoDTO(context: persistentContainer.viewContext)
        toDoDTO.createDate = item.createDate
        toDoDTO.title = item.title
        toDoDTO.detail = item.detail
        try save(context: persistentContainer.viewContext)
    }

    func fetch(page: Int) throws -> [ToDoItem] {
        let request: NSFetchRequest<ToDoDTO> = ToDoDTO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "\(dateColumnName)", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        let result = try persistentContainer.viewContext.fetch(request)
        return result.todoItems
    }

    func delete(item: ToDoItem) throws {
        let request: NSFetchRequest<ToDoDTO> = ToDoDTO.fetchRequest()
        request.predicate = NSPredicate(format: "\(dateColumnName) = %@", argumentArray: [item.createDate])
        let records = try persistentContainer.viewContext.fetch(request)
        for record in records {
            persistentContainer.viewContext.delete(record)
        }
        try save(context: persistentContainer.viewContext)
    }

    func update(key: Date, item: ToDoItem) throws {
        let request: NSFetchRequest<ToDoDTO> = ToDoDTO.fetchRequest()
        request.predicate = NSPredicate(format: "\(dateColumnName) = %@", argumentArray: [key])
        let records = try persistentContainer.viewContext.fetch(request)
        let titleColumn = "title"
        let detailColumn = "detail"
        //There should be only one records at same date. But can be better!
        for record in records {
            record.setValue(item.title, forKey: "\(titleColumn)")
            record.setValue(item.detail, forKey: "\(detailColumn)")
            record.setValue(item.createDate, forKey: "\(dateColumnName)")
        }
        try save(context: persistentContainer.viewContext)
    }
}

extension Array where Element == ToDoDTO {

    var todoItems: [ToDoItem] {
        map {ToDoItem(title: $0.title, detail: $0.detail, createDate: $0.createDate!)}
    }
}
