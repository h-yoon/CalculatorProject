import UIKit

class ViewController: UIViewController {

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

    let buttonTitles: [[String]] = [
        ["7", "8", "9", "+"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "*"],
        ["AC", "0", "=", "/"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupDisplayLabel()
        setupVerticalStackView()
    }

    private func setupDisplayLabel() {
        view.addSubview(displayLabel)
        NSLayoutConstraint.activate([
            displayLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            displayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            displayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            displayLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func setupVerticalStackView() {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 10
        verticalStackView.distribution = .fillEqually
        verticalStackView.backgroundColor = .black
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false

        for row in buttonTitles {
            let horizontalStack = UIStackView()
            horizontalStack.axis = .horizontal
            horizontalStack.spacing = 10
            horizontalStack.distribution = .fillEqually
            horizontalStack.translatesAutoresizingMaskIntoConstraints = false

            for title in row {
                let isOperator = ["+", "-", "*", "/", "=", "AC"].contains(title)
                let bgColor = isOperator ? UIColor.orange : UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
                let button = makeButton(title: title, backgroundColor: bgColor)
                horizontalStack.addArrangedSubview(button)
            }

            verticalStackView.addArrangedSubview(horizontalStack)
        }

        view.addSubview(verticalStackView)
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: displayLabel.bottomAnchor, constant: 60),
            verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStackView.widthAnchor.constraint(equalToConstant: 350)
        ])
    }

    @objc func buttonTapped(_ sender: UIButton) {
        guard let input = sender.titleLabel?.text else { return }

        switch input {
        case "AC":
            displayLabel.text = "0"
        case "=":
            if let expression = displayLabel.text,
               let result = CalculatorEngine.calculate(expression: expression) {
                displayLabel.text = "\(result)"
            } else {
                displayLabel.text = "Error"
            }
        default:
            if let currentText = displayLabel.text {
                if currentText == "0" {
                    displayLabel.text = input
                } else if ["+0", "-0", "*0", "/0"].contains(String(currentText.suffix(2))), Int(input) != nil {
                    displayLabel.text = String(currentText.dropLast()) + input
                } else {
                    displayLabel.text = currentText + input
                }
            }
        }
    }
}
