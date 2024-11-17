//
//  QuizManager.swift
//  Quiz_App
//
//  Created by Manpreet Gulati on 05/11/24.
//

class QuizManager {
    static let shared = QuizManager()
    var questions: [Question] = []

       private init() {} // Private initializer to prevent creating new instances

       private(set) var currentQuestionIndex = 0
       private(set) var score = 0
    
    func goToNextQuestion() {
            if currentQuestionIndex < questions.count - 1 {
                currentQuestionIndex += 1
            }
        }
        
        func goToPreviousQuestion() {
            if currentQuestionIndex > 0 {
                currentQuestionIndex -= 1
            }
        }
    func addQuestion(_ question: Question) {
           questions.append(question)
       }
       
       func updateQuestion(_ question: Question, at index: Int) {
           guard index >= 0 && index < questions.count else { return }
           questions[index] = question
       }
       func getCurrentQuestion() -> Question? {
           return currentQuestionIndex < questions.count ? questions[currentQuestionIndex] : nil
       }

       func checkAnswer(_ answer: String) -> Bool {
           let correct = questions[currentQuestionIndex].correctAnswer == answer
           if correct { score += 1 }
           currentQuestionIndex += 1
           return correct
       }

       func resetQuiz() {
           score = 0
           currentQuestionIndex = 0
       }
}

