//
//  Execute.swift
//  MyCreditManager
//
//  Created by mars on 2022/11/21.
//

import Foundation

class Execute {
    
    let input = ConsoleInput()
    
    let gradeType: [String : Double] = ["A+" : 4.5, "A" : 4,
                                        "B+" : 3.5, "B" : 3,
                                        "C+" : 2.5, "C" : 2,
                                        "D+" : 1.5, "D" : 1,
                                        "F" : 0]
    
    var students: [String] = []
    
    var studentArr: [StudentModel] = []
    
    func getOption(_ option: String) -> (option: OptionType, value: String) {
        return (OptionType(value: option), option)
    }
    
    func findName(_ students: [String], student: String) -> Bool {
        if(students.contains(where: {
            $0 == student
        })) {
            return true
        }else {
            return false
        }
    }
    
    func findStudent(_ students: [StudentModel], student: String) -> Bool {
        if(students.contains(where: { StudentModel in
            StudentModel.name == student
        })) {
            return true
        }else {
            return false
        }
    }
    
    func interactiveMode() {
        var shouldQuit = false
        
        while !shouldQuit {
            
            input.writeConsole("""
            원하는 기능을 입력해주세요
            1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료
            """)
            let (option, _) = getOption(input.getConsole())
            
            switch option {
            case .addStudent:
                input.writeConsole("추가할 학생의 이름을 입력해주세요")
                let inputData = input.getConsole()
                
                if(findName(students, student: inputData)) {
                    input.writeConsole("\(inputData)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
                }else {
                    students.append(inputData)
                    
                    input.writeConsole("\(inputData) 학생을 추가했습니다.")
                }
                
            case .deleteStudent:
                input.writeConsole("삭제할 학생의 이름을 입력해주세요")
                let inputData = input.getConsole()
                
                if(findName(students, student: inputData)) {
                    let filterd = students.filter {
                        $0 != inputData
                    }
                    students = filterd
                    
                    if(findStudent(studentArr, student: inputData)) {
                        let filterd = studentArr.filter {
                            $0.name != inputData
                        }
                        studentArr = filterd
                    }
                    
                    input.writeConsole("\(inputData) 학생을 삭제하였습니다.")
                }else {
                    input.writeConsole("\(inputData) 학생을 찾지 못했습니다.")
                }
                
            case .addGrade:
                input.writeConsole("""
                성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로
                    작성해주세요.
                입력예) Mickey Swift A+
                만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.
                """)
                
                let inputData = input.getConsole()
                
                let splitData = inputData.components(separatedBy: " ")
                
                if(splitData.count != 3) {
                    input.writeConsole("입력이 잘못되었습니다. 다시 확인해주세요.")
                }else {
                    
                    if(findName(students, student: splitData[0])) {
                        
                        if(findStudent(studentArr, student: splitData[0])) {
                            var filterd = studentArr.filter {
                                $0.subject == splitData[1]
                            }
                            
                            if(filterd.count == 0) {
                                let model = StudentModel(name: splitData[0], subject: splitData[1], grade: splitData[2])
                                studentArr.append(model)
                                
                                input.writeConsole("\(splitData[0]) 학생의 \(splitData[1]) 과목이 \(splitData[2])로 추가(변경)되었습니다.")
                            }else {
                                filterd[0].grade = splitData[2]
                                studentArr = filterd
                                
                                input.writeConsole("\(splitData[0]) 학생의 \(splitData[1]) 과목이 \(splitData[2])로 추가(변경)되었습니다.")
                            }
                            
                            
                        }else {
                            let model = StudentModel(name: splitData[0], subject: splitData[1], grade: splitData[2])
                            studentArr.append(model)
                            
                            input.writeConsole("\(splitData[0]) 학생의 \(splitData[1]) 과목이 \(splitData[2])로 추가(변경)되었습니다.")
                        }
                        
                    }else {
                        input.writeConsole("입력이 잘못되었습니다. 다시 확인해주세요.")
                    }
                }
                
            case .deleteGrade:
                input.writeConsole("""
                성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.
                입력예) Mickey Swift
                """)
                let inputData = input.getConsole()
                
                let splitData = inputData.components(separatedBy: " ")
                
                if(splitData.count != 2) {
                    input.writeConsole("입력이 잘못되었습니다. 다시 확인해주세요.")
                }else {
                    if(findStudent(studentArr, student: splitData[0])) {
                        let filtered = studentArr.filter {
                            $0.name != splitData[0] && $0.subject != splitData[1]
                        }
                        studentArr = filtered
                        input.writeConsole("\(splitData[0]) 학생의 \(splitData[1]) 과목의 성적이 삭제되었습니다.")
                    }else {
                        input.writeConsole("\(splitData[0]) 학생을 찾지 못했습니다.")
                    }
                }
                
            case .showAverage:
                input.writeConsole("평점을 알고싶은 학생의 이름을 입력해주세요")
                let inputData = input.getConsole()
                
                if(inputData == "") {
                    input.writeConsole("입력이 잘못되었습니다. 다시 확인해주세요.")
                }
                
                if(findStudent(studentArr, student: inputData)) {
                    let data = studentArr.filter {
                        $0.name == inputData
                    }
                    let average = data.reduce(0) {
                        $0 + gradeType[$1.grade]!
                    }
                    
                    let dataLabel = data.map {
                        return ("\($0.subject): \($0.grade)")
                    }
                    let printLabel: () = dataLabel.forEach {
                        input.writeConsole($0)
                    }
                    
                    printLabel
                    print("평점 : ", average / Double(data.count))
                    
                }else {
                    input.writeConsole("\(inputData) 학생을 찾지 못했습니다.")
                }
                
            case .exit:
                shouldQuit = true
                
            default:
                input.writeConsole("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요", to: .error)
            }
        }
    }
}
