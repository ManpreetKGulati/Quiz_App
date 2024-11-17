//
//  ViewController.swift
//  Quiz_App
//
//  Created by Manpreet Gulati on 05/11/24.
//

import UIKit

class ViewController: UIViewController {

  //  let questionBank = QuestionBank()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundImage()


    }
    
    func setBackgroundImage() {
           // Create an UIImageView for the background
           let backgroundImageView = UIImageView()
           backgroundImageView.image = UIImage(named: "backgroundImage")
           backgroundImageView.contentMode = .scaleAspectFill
           backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
           
           // Add the UIImageView as a subview to the main view
           view.addSubview(backgroundImageView)
           
           // Set constraints to cover the entire screen
           NSLayoutConstraint.activate([
               backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
               backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
               backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
           ])
        
        let titleLabel = UILabel()
        titleLabel.text = "QUIZZZ TIME!"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 50)
        titleLabel.textColor = .yellow
        titleLabel.textAlignment = .center
        
        // Add constraints if needed
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 145)
        ])
           
           // Move the background image to the back of all other views
           view.sendSubviewToBack(backgroundImageView)
       }
       
    

    @IBAction func startQuizButtonTapped(_ sender: Any) {
        
      //  performSegue(withIdentifier: "startQuizSegue", sender: self)
        print("Start Quiz Button Pressed")  // Debug print statement
           
           if QuizManager.shared.questions.isEmpty {
               let alertController = UIAlertController(
                   title: "No Questions",
                   message: "There are no questions in your question bank. Please add questions before starting the quiz.",
                   preferredStyle: .alert
               )
               alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alertController, animated: true, completion: nil)
           } else {
               performSegue(withIdentifier: "startQuizSegue", sender: self)
           }

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startQuizSegue" && segue.destination is InitiateQuizViewController {
            // Only checking the type, no need to assign to a variable
        }
    }

    }

