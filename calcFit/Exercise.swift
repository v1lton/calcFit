//
//  Exercise.swift
//  calcFit
//
//  Created by Wilton Ramos on 20/03/20.
//  Copyright © 2020 Wilton Ramos. All rights reserved.
//

import Foundation

class Exercise {
    var exercise: String
    var repetition: Int
    var serie: Int
    
    init(Exercise exercise: String, Repetition repetition: Int, Serie serie: Int) {
        self.exercise = exercise
        self.repetition = repetition
        self.serie = serie
    }
}
