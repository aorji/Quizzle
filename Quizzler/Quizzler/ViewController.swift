//
//  ViewController.swift
//  Quizzler
//
//  Created by Anastasiia ORJI on 8/16/18.
//  Copyright © 2018 Anastasiia ORJI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var numberOfQuestionLabel: UILabel!
    @IBOutlet weak var levelBar: UIView!
    @IBOutlet weak var questionView: UITextView!
    
    var questionNumber: Int = 0
    var score: Int = 0
    let questionList = QuestionCollection()
    var senderAnswer: Bool = false
    
    var numberList: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextQuestion()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func answerButton(_ sender: UIButton) {

        if sender.tag == 1 {
            senderAnswer = true
        } else if sender.tag == 2 {
            senderAnswer = false
        }
        checkAnswer()
        nextQuestion()

    }
    
    func nextQuestion() {
        
        if questionNumber <= 12 {
            
            questionNumber += 1
            updateLabels()
        
        }else {
            let alert = UIAlertController(title: "Quiz is complited!", message: "Do you want to start over?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: {
                UIAlertAction in self.update()
            })
            
            alert.addAction(restartAction)
            
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    func updateLabels() {
        scoreLabel.text = "Score: \(score)"
        numberOfQuestionLabel.text = "\(questionNumber) / 13"
        questionView.text = questionList.list[questionNumber - 1].questionText
        levelBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber)
    }
    
    func checkAnswer() {

        if senderAnswer == questionList.list[questionNumber - 1].questionAnswer {
            ProgressHUD.showSuccess("Correct")
            score += 1
        }else {
            ProgressHUD.showError("Wrong!")
        }
    }
    
    func update () {
        
        questionNumber = 0
        score = 0
        nextQuestion()
        
    }
    
}

