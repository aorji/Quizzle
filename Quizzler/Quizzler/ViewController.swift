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
    var questionArray = QuestionCollection()
    var senderAnswer: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        update()
        
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
        
        numberOfQuestionLabel.text = "\(questionNumber) / \(questionArray.list.count)"
        questionView.text = questionArray.list[questionNumber - 1].questionText
        levelBar.frame.size.width = (view.frame.size.width / CGFloat(questionArray.list.count)) * CGFloat(questionNumber)
        
    }
    
    func checkAnswer() {

        if senderAnswer == questionArray.list[questionNumber - 1].questionAnswer {
            ProgressHUD.showSuccess("Correct")
            score += 1
            scoreLabel.text = "Score: \(score)"
        }else {
            ProgressHUD.showError("Wrong!")
        }
        
    }
    
    func update () {
        
        questionNumber = 0
        score = 0
        scoreLabel.text = "Score: \(score)"
        shuffleQuestionArray()
        nextQuestion()
        
    }
    
    func shuffleQuestionArray() {
        
        let shuffled = QuestionCollection()
        
        shuffled.list.removeAll()
        
        for _ in 0..<questionArray.list.count
        {
            let rand = Int(arc4random_uniform(UInt32(questionArray.list.count)))
            shuffled.list.append(questionArray.list[rand])
            questionArray.list.remove(at: rand)
        }
      
        questionArray = shuffled

    }
    
}

