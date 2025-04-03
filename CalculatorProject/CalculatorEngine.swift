//
//  Untitled.swift
//  CalculatorProject
//
//  Created by 형윤 on 4/1/25.
//

import Foundation

// 수식 문자열을 받아 정수 결과로 반환하는 계산 엔진 구조체
struct CalculatorEngine {
    // 입력된 수식을 계산하여 Int 결과를 반환하는 정적 함수
    // 유효하지 않은 수식이면 nil 반환
    static func calculate(expression: String) -> Int? {
        let expression = NSExpression(format: expression) // 수식 파싱을 위한 NSExpression 생성
        
        // 계산 결과를 Any? 타입으로 받아 Int로 캐스팅
        if let result = expression.expressionValue(with: nil, context: nil) as? Int {
            return result  // 성공적으로 계산된 경우 반환
        } else {
            return nil     // 계산 실패 시 nil 반환
        }
    }
}
