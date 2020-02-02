//
//  ViewController.swift
//  QuizApp
//
//  Created by TR on 2/2/20.
//  Copyright © 2020 TR. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var quizImage: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    let quiz = Quiz()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
      
        setupQuestion()
    }
    
    func setupQuestion(){
        let currentQuestion = quiz.getQuestion()
          quizImage.image = currentQuestion.image
          
          questionLabel.text = currentQuestion.question
    }

    @IBAction func trueButtonDidTouch(_ sender: Any) {
        
        let result = quiz.check(answer: true)
        
        showResult(isCorrect: result)
        
    }
    
    
    @IBAction func falseButtonDidTouch(_ sender: Any) {
        let result = quiz.check(answer: false)
        showResult(isCorrect: result)
    }
    
    func showResult(isCorrect correct: Bool){
        
        let title = correct ? "Correct" : "Incorrect"
        
        let message = correct ? "You got the right answer" : "You got the wrong answer"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let nextQuestionAction = UIAlertAction(title: "Next Question", style: .default){ (action) in
            if self.quiz.nextQuestion(){
                self.setupQuestion()
                alert.dismiss(animated: true, completion: nil)
            } else{
                alert.dismiss(animated: true, completion: nil)
                self.showFinalScore()
            }
            
        }
        
        alert.addAction(nextQuestionAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showFinalScore(){
        let alert = UIAlertController(title: "Final Score", message: "\(quiz.getScore())", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default){ (action) in
            self.quiz.reset()
            
            self.setupQuestion()
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}

