//
//  InitiateQuizViewController.swift
//  Quiz_App
//
//  Created by Manpreet Gulati on 05/11/24.
//

import UIKit

class InitiateQuizViewController: UIViewController {

    @IBOutlet weak var answerButton1: UIButton!
    
    @IBOutlet weak var answerButton2: UIButton!
    
    @IBOutlet weak var answerButton3: UIButton!
    
    
    
    
    @IBOutlet weak var answerButton4: UIButton!
    
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuestion()

    }
    
    func loadQuestion() {
        guard let question = QuizManager.shared.getCurrentQuestion() else { return }
        questionLabel.text = question.questionText
        var answers = question.incorrectAnswers
        answers.append(question.correctAnswer)
        answers.shuffle() // Shuffle to randomize answer order
        answerButton1.setTitle(answers[0], for: .normal)
        answerButton2.setTitle(answers[1], for: .normal)
        answerButton3.setTitle(answers[2], for: .normal)
        answerButton4.setTitle(answers[3], for: .normal)
        
        progressLabel.text = "Question \(QuizManager.shared.currentQuestionIndex + 1) of \(QuizManager.shared.questions.count)"
            progressView.progress = Float(QuizManager.shared.currentQuestionIndex + 1) / Float(QuizManager.shared.questions.count)
        }
    
    func checkAnswer(_ answer: String) {
        let isCorrect = QuizManager.shared.checkAnswer(answer)
        
        // Use isCorrect to show feedback to the user
        if isCorrect {
            print("Correct answer!")
            // You could also show an alert or update a label here
        } else {
            print("Incorrect answer!")
        }
        
        if QuizManager.shared.getCurrentQuestion() == nil {
            showQuizCompletion()
        } else {
            loadQuestion()
        }
    }


    func showQuizCompletion() {
        let alertController = UIAlertController(
            title: "Quiz Completed",
            message: "Your score: \(QuizManager.shared.score) out of \(QuizManager.shared.questions.count)",
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
            QuizManager.shared.resetQuiz() // Reset quiz for another attempt
        })
        present(alertController, animated: true, completion: nil)
    }

    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        guard let answer = sender.titleLabel?.text else { return }
           checkAnswer(answer)
    }
}
