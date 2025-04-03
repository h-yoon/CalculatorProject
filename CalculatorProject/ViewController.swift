import UIKit

class ViewController: UIViewController {

    // 계산 결과를 표시할 UILabel (오른쪽 정렬, 큰 글씨, 검정 배경)
    let displayLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .white
        label.text = "0"
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 60)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // 계산기에 표시될 버튼 텍스트들을 행 단위로 나열한 2차원 배열
    let buttonTitles: [[String]] = [
        ["7", "8", "9", "+"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "*"],
        ["AC", "0", "=", "/"]
    ]

    // 뷰가 메모리에 로드된 직후 호출되는 생명주기 메서드
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black // 배경색 설정
        setupDisplayLabel()           // 결과 레이블 배치
        setupVerticalStackView()      // 버튼 스택뷰 구성
    }

    // 결과 레이블을 화면에 배치하는 함수
    private func setupDisplayLabel() {
        view.addSubview(displayLabel)
        NSLayoutConstraint.activate([
            displayLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            displayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            displayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            displayLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    // 계산기 버튼들을 수직 스택뷰 형태로 구성하고 제약 추가
    private func setupVerticalStackView() {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 10
        verticalStackView.distribution = .fillEqually
        verticalStackView.backgroundColor = .black
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false

        // 각 행(row)에 해당하는 버튼을 수평 스택으로 구성
        for row in buttonTitles {
            let horizontalStack = UIStackView()
            horizontalStack.axis = .horizontal
            horizontalStack.spacing = 10
            horizontalStack.distribution = .fillEqually
            horizontalStack.translatesAutoresizingMaskIntoConstraints = false

            for title in row {
                // 연산자 또는 특수 기능 버튼 여부 확인
                let isOperator = ["+", "-", "*", "/", "=", "AC"].contains(title)
                let bgColor = isOperator ? UIColor.orange : UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
                let button = makeButton(title: title, backgroundColor: bgColor) // 버튼 생성
                horizontalStack.addArrangedSubview(button)
            }

            verticalStackView.addArrangedSubview(horizontalStack) // 수직 스택에 행 추가
        }

        view.addSubview(verticalStackView)
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: displayLabel.bottomAnchor, constant: 60),
            verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStackView.widthAnchor.constraint(equalToConstant: 350)
        ])
    }

    // 버튼이 눌렸을 때 호출되는 메서드
    @objc func buttonTapped(_ sender: UIButton) {
        guard let input = sender.titleLabel?.text else { return } // 버튼 텍스트가 없으면 종료

        switch input {
        case "AC":
            // 초기화 버튼 → 화면을 0으로 리셋
            displayLabel.text = "0"
        case "=":
            // = 버튼 → 문자열 수식을 계산
            if let expression = displayLabel.text,
               let result = CalculatorEngine.calculate(expression: expression) {
                displayLabel.text = "\(result)"
            } else {
                displayLabel.text = "Error" // 계산 실패 시 에러 표시
            }
        default:
            // 숫자 또는 연산자 입력 처리
            if let currentText = displayLabel.text {
                if currentText == "0" {
                    // 현재가 0이면 새로운 값으로 대체
                    displayLabel.text = input
                } else if ["+0", "-0", "*0", "/0"].contains(String(currentText.suffix(2))), Int(input) != nil {
                    // 연산자 뒤 0이 있을 경우 → 0 제거 후 숫자 입력
                    displayLabel.text = String(currentText.dropLast()) + input
                } else {
                    // 일반 입력 → 기존 문자열에 추가
                    displayLabel.text = currentText + input
                }
            }
        }
    }
}
