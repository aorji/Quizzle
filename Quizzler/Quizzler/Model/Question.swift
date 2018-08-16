//
//  Question.swift
//  Quizzler
//
//  Created by Anastasiia ORJI on 8/16/18.
//  Copyright © 2018 Anastasiia ORJI. All rights reserved.
//

import Foundation

class Question {
    
    let questionText: String
    let questionAnswer: Bool
    
    init(text: String, answer: Bool) {
        
        questionText = text
        questionAnswer = answer
        
    }
}
