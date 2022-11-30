//
//  Type.swift
//  MyCreditManager
//
//  Created by mars on 2022/11/28.
//

import Foundation

enum OptionType: String {
    case addStudent = "1"
    case deleteStudent = "2"
    case addGrade = "3"
    case deleteGrade = "4"
    case showAverage = "5"
    case exit = "X"
    case unknown
    
    init(value: String) {
        switch value {
        case "1": self = .addStudent
        case "2": self = .deleteStudent
        case "3": self = .addGrade
        case "4": self = .deleteGrade
        case "5": self = .showAverage
        case "X": self = .exit
        default: self = .unknown
        }
    }
}
