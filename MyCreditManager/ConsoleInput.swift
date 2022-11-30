//
//  ConsoleInput.swift
//  MyCreditManager
//
//  Created by mars on 2022/11/21.
//

import Foundation

enum OutputType {
    case standard
    case error
}

class ConsoleInput {
    func writeConsole(_ text: String, to: OutputType = .standard) {
        switch to {
        case .standard:
            print("\(text)")
        case .error:
            print("error : ", "\(text)")
        }
    }
    
    func printConsole() {
        let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
        
        writeConsole(executableName)
    }
    
    func getConsole() -> String {
        let keyboard = FileHandle.standardInput
        let inputData = keyboard.availableData
        let strData = String(data: inputData, encoding: String.Encoding.utf8)!
        return strData.trimmingCharacters(in: CharacterSet.newlines)
    }
}
