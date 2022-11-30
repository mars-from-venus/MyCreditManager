//
//  Model.swift
//  MyCreditManager
//
//  Created by mars on 2022/11/28.
//

import Foundation

struct StudentModel {
    var name: String
    var subject: String
    var grade: String
    
    init(name: String, subject: String, grade: String) {
        self.name = name
        self.subject = subject
        self.grade = grade
    }
}
