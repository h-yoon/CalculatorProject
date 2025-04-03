# Calculator Project

# 목차
1. [프로젝트 소개](#프로젝트-소개)
2. [팀소개](#팀소개)
3. [프로젝트 계기](#프로젝트-계기)
4. [주요기능](#주요기능)
5. [개발기간](#개발기간)
6. [기술스택](#기술스택)
7. [서비스 구조](#서비스-구조)
8. [와이어프레임](#와이어프레임)
9. [API 명세서](#api-명세서)
10. [프로젝트 파일 구조](#프로젝트-파일-구조)
    
---

# 프로젝트 소개

Swift와 UIKit을 사용해 구현한 iOS 계산기 앱입니다. 
코드베이스 UI로 구성되어 있으며, 버튼 입력을 통해 정수 사칙연산 계산이 가능합니다. 
기능별로 파일을 분리하고, 사용자 경험을 고려한 입력 처리 로직을 구현했습니다.

---

# 팀소개
- 개인 프로젝트입니다.

---

# 프로젝트 계기
- UIKit과 AutoLayout을 코드로 구현하는 연습을 위해 제작했습니다.
- 실전 프로젝트에서 사용할 수 있는 구조 분리, 코드 컨벤션 등을 직접 설계해보고자 했습니다.

---

# 주요기능

- 코드베이스 UI 구성 (UILabel, UIStackView, UIButton)
- 버튼 입력에 따른 실시간 텍스트 업데이트
- `AC` 버튼으로 화면 초기화
- `=` 버튼으로 수식 계산 (NSExpression 기반)
- 잘못된 수식 시 "Error" 처리
- 앞자리 0 자동 제거 (예: `6+02` → `6+2`)
- 기능별 파일 모듈화

---

# 개발기간
- 2024.03.27(목) ~ 2024.04.03(목)

---

# 기술스택

# Language
- Swift 5

# IDE
- Xcode 15

# Framework
- UIKit

# Deploy
- Xcode Simulator (로컬 테스트)

---

# 서비스 구조

> 단일 ViewController 기반의 로직 중심 앱으로,
> View → 버튼 입력 → 입력 처리 → 계산기 엔진 호출 → 결과 출력의 구조를 가집니다.

```
ViewController.swift
│
├── displayLabel (UILabel)
├── 버튼 생성 (makeButton)
├── 입력 처리 (buttonTapped)
└── 수식 계산 호출 (CalculatorEngine)
```

---

# 와이어프레임

> Xcode 내 AutoLayout 기반으로 직접 구성

---

# API 명세서

> 해당 앱은 외부 API를 사용하지 않습니다.

---

# 프로젝트 파일 구조

```
CalculatorApp/
├── ViewController.swift         // 전체 화면 구성과 입력 처리 담당
├── CalculatorEngine.swift       // 수식 계산 기능 담당
└── CalculatorButton.swift       // 버튼 생성 및 스타일 설정
```
