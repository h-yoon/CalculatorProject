//
//  Untitled.swift
//  CalculatorProject
//
//  Created by 형윤 on 4/1/25.
//

import Foundation

struct CalculatorEngine {
    static func calculate(expression: String) -> Int? {
        let expression = NSExpression(format: expression)
        if let result = expression.expressionValue(with: nil, context: nil) as? Int {
            return result
        } else {
            return nil
        }
    }
}
