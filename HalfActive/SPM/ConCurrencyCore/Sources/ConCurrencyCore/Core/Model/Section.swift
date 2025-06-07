//
//  File.swift
//  ConCurrencyCore
//
//  Created by Siddharth S on 07/05/25.
//

import Foundation

public struct ExcerciseSection: Codable {
    var excercises: [Excercise]
}


public struct Excercise: Codable {
    var id: Int
    var image: String?
    var name: String
    var muscleGroup: MuscleGroup?
    var lottieName: String?
}

public enum MuscleGroup: Codable {
    case shoulder
    case chest
    case back
    case biceps
    case triceps
    case core
    case legs
}
