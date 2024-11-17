//
//  AddQuestionViewController.swift
//  Quiz_App
//
//  Created by Manpreet Gulati on 05/11/24.
//

import UIKit

class AddQuestionViewController: UIViewController {
    var questionToEdit: Question?
    var isEditingQuestion = false
    var questionIndex: Int? // Store the question index
    weak var delegate: QuestionBankDelegate?

    @IBOutlet weak var questionTextField: UITextField!
    
    @IBOutlet weak var correctAnswerField: UITextField!
    
    
    @IBOutlet weak var incorrectAnswer1Field: UITextField!
    
    @IBOutlet weak var incorrectAnswer2Field: UITextField!
    
    @IBOutlet weak var incorrectAnswer3Field: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let question = questionToEdit {
                    questionTextField.text = question.questionText
                    correctAnswerField.text = question.correctAnswer
                    if question.incorrectAnswers.count >= 3 {
                        incorrectAnswer1Field.text = question.incorrectAnswers[0]
                        incorrectAnswer2Field.text = question.incorrectAnswers[1]
                        incorrectAnswer3Field.text = question.incorrectAnswers[2]
            }
        }
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let questionText = questionTextField.text,
                     let correctAnswer = correctAnswerField.text,
                     let incorrectAnswer1 = incorrectAnswer1Field.text,
                     let incorrectAnswer2 = incorrectAnswer2Field.text,
                     let incorrectAnswer3 = incorrectAnswer3Field.text,
                     !questionText.isEmpty, !correctAnswer.isEmpty else {
            showAlert(message: "All fields must be filled out!")
                   return
               }
        let question = Question(
            questionText: questionText,
            correctAnswer: correctAnswer,
            incorrectAnswers: [incorrectAnswer1, incorrectAnswer2, incorrectAnswer3],
            color: .white, // Use a placeholder or selected color
            image: UIImage() // Use a placeholder or selected image
        )

               
               if isEditingQuestion, let index = questionIndex {
                   delegate?.didUpdateQuestion(question, at: index)
               } else {
                   delegate?.didAddQuestion(question)
               }
               
               dismiss(animated: true, completion: nil)
    }
    
    func showSuccessMessage(_ message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion()  // Dismiss after alert is tapped
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func showAlert(message: String) {
           let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default))
           present(alert, animated: true)
       }
}
