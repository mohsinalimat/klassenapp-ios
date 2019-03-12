//
//  RememberTD.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 07.10.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import Foundation

class ToDoItem
{
    var title: String
    var done: Bool
    
    public init(title: String)
    {
        self.title = title
        self.done = false
    }
}

extension ToDoItem
{
    public class func getMockData() -> [ToDoItem]
    {
        return [
            ToDoItem(title: "Milk"),
            ToDoItem(title: "Chocolate"),
            ToDoItem(title: "Light bulb"),
            ToDoItem(title: "Dog food")
        ]
    }
}
