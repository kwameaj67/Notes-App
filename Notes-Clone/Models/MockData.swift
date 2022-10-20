//
//  MockData.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 11/10/2022.
//

import UIKit


struct FolderType{
    var title: String
    var totalCount: Int?
    
    static let data:[FolderType] = [
        FolderType(title: "personal notes", totalCount: 23),
        FolderType(title: "feelings", totalCount: 30),
        FolderType(title: "morning quotes", totalCount: nil),
        FolderType(title: "great ideas", totalCount: 32),
        FolderType(title: "schooling", totalCount: 15),
        FolderType(title: "to-do", totalCount: 66),
        FolderType(title: "passwords", totalCount: 40),
    ]
}

struct CategoryType{
    var title: String
    static let data = [
        CategoryType(title:"📚 Academic"),
        CategoryType(title:"🏥 Health"),
        CategoryType(title:"🎓 School"),
        CategoryType(title:"🤐 Secret"),
        CategoryType(title:"💍 Wedding"),
        CategoryType(title:"🎶 Music"),
        CategoryType(title:"💼 Work"),
        CategoryType(title:"🙇‍♂️ Personal"),
        CategoryType(title:"⚙️ Electronics"),
        CategoryType(title:"🥳 Events"),
        CategoryType(title:"👍🏽 Likes"),
        CategoryType(title:"🌚 Disklikes"),
        CategoryType(title:"💃 Adventure"),
        CategoryType(title:"✍️ Goals"),
        CategoryType(title:"🤑 Cash receipts"),
        CategoryType(title:"💰 Savings"),
        CategoryType(title:"🍿 Movies"),
        CategoryType(title:"👨‍💻 Technology"),
        CategoryType(title:"🔗 General Links"),
        CategoryType(title:"🏋🏽‍♀️ Workout"),
        CategoryType(title:"🎉 Birthdays"),
        CategoryType(title:"⚽️ Football"),
        CategoryType(title:"💬 Popular Quotes"),
        CategoryType(title:"🔬 Research"),
    ]
}


struct NoteType{
    var heading: String
    var body: String
    
    static let data:[NoteType] = [
        NoteType(heading: "Notice how Task 1, Task 2", body: "Task 3 start quickly one after the other. On the other hand, Task 1 took a while to start after Task 0. Also notice that while Task 3 started after Task 2, it finished first."),
        NoteType(heading: "three main types of queues", body: "Main queue: runs on the main thread and is a serial queue."),
        NoteType(heading: "Global queues:", body: "concurrent queues that are shared by the whole system. There are four such queues with different priorities : high, default, low, and background."),
        NoteType(heading: "Custom queues:", body: "queues that you create which can be serial or concurrent. Requests in these queues actually end up in one of the global queues."),
        NoteType(heading: "User-interactive", body: "This represents tasks that must complete immediately in order to provide a nice user experience."),
        NoteType(heading: "User-initiated: The user initiates", body: "these asynchronous tasks from the UI. Use them when the user is waiting for immediate results and for tasks required to continue user interaction."),
        NoteType(heading: "Utility", body: " This represents long-running tasks, typically with a user-visible progress indicator. Use it for computations"),
        NoteType(heading: "Synchronous vs. Asynchronous", body: "With GCD, you can dispatch a task either synchronously or asynchronously. A synchronous function returns control to the caller after the task completes. You can schedule a unit of work synchronously by calling DispatchQueue.sync(execute:)."),
        NoteType(heading: "Managing Tasks", body: "You’ve heard about tasks quite a bit by now. For the purposes of this tutorial you can consider a task to be a closure. Closures are self-contained, callable blocks of code you can store and pass around."),
    ]
}
