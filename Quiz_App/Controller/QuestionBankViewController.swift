//
//  QuestionBankViewController.swift
//  Quiz_App
//
//  Created by Manpreet Gulati on 05/11/24.
//

import UIKit



class QuestionBankViewController: UIViewController, QuestionBankDelegate, UITableViewDataSource, UITableViewDelegate {
        
       
    @IBOutlet weak var tableView: UITableView!
    
        
    var questions: [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register TableView Cell
               tableView.register(UITableViewCell.self, forCellReuseIdentifier: "QuestionCell")
               
               tableView.delegate = self
               tableView.dataSource = self
               
               // Load questions from QuizManager
               questions = QuizManager.shared.questions
    }
    
    func didAddQuestion(_ question: Question) {
           // Update QuizManager and local questions array
           QuizManager.shared.addQuestion(question)
           questions = QuizManager.shared.questions
           tableView.reloadData()
       }
       
       func didUpdateQuestion(_ question: Question, at index: Int) {
           guard index >= 0 && index < questions.count else { return }
           QuizManager.shared.updateQuestion(question, at: index)
           questions = QuizManager.shared.questions
           tableView.reloadData()
       }
   
//
//      func didFailWithError(error: Error) {
//          print("Error fetching questions: \(error.localizedDescription)")
//      }
//    
        
    @IBAction func addQuestionButtonTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let addQuestionVC = storyboard.instantiateViewController(identifier: "AddQuestionViewController") as? AddQuestionViewController {
                    addQuestionVC.delegate = self
                    present(addQuestionVC, animated: true)
           }
        
   
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let addQuestionVC = storyboard.instantiateViewController(identifier: "AddQuestionViewController") as? AddQuestionViewController {
                addQuestionVC.delegate = self
                addQuestionVC.isEditingQuestion = true
                addQuestionVC.questionToEdit = questions[indexPath.row]
                addQuestionVC.questionIndex = indexPath.row
                present(addQuestionVC, animated: true)
            }
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return questions.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath)
            cell.textLabel?.text = questions[indexPath.row].questionText
            return cell
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddQuestionViewController",
                   let addQuestionVC = segue.destination as? AddQuestionViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                addQuestionVC.questionToEdit = questions[indexPath.row]
                addQuestionVC.delegate = self
            }
        }
    }
}
