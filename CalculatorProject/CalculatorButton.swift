//
//  CalculatorButton.swift
//  CalculatorProject
//
//  Created by 형윤 on 4/1/25.
//

import UIKit

// ViewController의 확장으로 버튼 생성 로직을 분리하여 관리합니다.
extension ViewController {
    // 버튼을 생성하고 스타일을 지정하는 함수
    // title: 버튼에 표시될 텍스트
    // backgroundColor: 버튼의 배경색
    func makeButton(title: String, backgroundColor: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)                       // 버튼 텍스트 설정
        button.setTitleColor(.white, for: .normal)                // 텍스트 색상 흰색
        button.titleLabel?.font = .boldSystemFont(ofSize: 30)     // 굵고 큰 폰트
        button.backgroundColor = backgroundColor                  // 배경색 설정
        button.layer.cornerRadius = 40                             // 모서리를 둥글게
        button.translatesAutoresizingMaskIntoConstraints = false  // 오토레이아웃 사용 설정

        // 버튼의 너비와 높이 제약 설정 (80x80 크기 고정)
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 80),
            button.heightAnchor.constraint(equalToConstant: 80)
        ])

        // 버튼 터치 시 ViewController의 buttonTapped(_:) 메서드 실행되도록 설정
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }
}
