//
//  DataManager.swift
//  Notepad.ver3
//
//  Created by gunhyeong on 2020/11/10.
//  Copyright © 2020 geonhyeong. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
    static let shared = DataManager()
    private init() {
        // Singleton 싱글톤
    }
    
    // 메모리에서 데이터 읽어오기
    var memoList = [Memo]()
    func fetchMemo() {
        let requestMemo: NSFetchRequest<Memo> = Memo.fetchRequest()
        
        let sortByDateDesc = NSSortDescriptor(key: "insertDate", ascending: false) // 내림차순
        requestMemo.sortDescriptors = [sortByDateDesc]
        
        do {
            memoList = try mainContext.fetch(requestMemo)
        } catch {
             print(error)
        }
    }
    
    
    
    func deleteMemo(_ memo: Memo?) {
        if let memo = memo {
            mainContext.delete(memo)
            saveContext()
        }
    }
    
    // Context : Core Data를 관리
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Notepad_ver3")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
