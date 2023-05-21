//
//  ViewController.swift
//  Yandex_HomeWork
//
//  Created by Дмитрий Шмаков on 20.05.2023.
//

import UIKit

        
class ViewController: UIViewController {
    
    var count = 0
    var history = "История изменений:\n"
    
    private let countNameLabel: UILabel = {
        let label = UILabel()
        var count = 0
        label.text = "\(count)"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.cornerRadius = 10
        button.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        button.setImage(UIImage(named: "plusButton"), for: .normal)
        /*button.imageEdgeInsets = UIEdgeInsets(top: 0,
         left: 20,
         bottom: 15,
         right: 0)
         */
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.cornerRadius = 10
        button.tintColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        button.setImage(UIImage(named: "minusButton"), for: .normal)
        button.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        button.layer.cornerRadius = 10
        button.setTitle("RESET", for: .normal)
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let eventLogTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        textField.textColor = .red
        textField.leftView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 15,
                                                  height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clearButtonMode = .always
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setContraints()
        
    }
    
    
    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        
        view.addSubview(countNameLabel)
        view.addSubview(plusButton)
        view.addSubview(eventLogTextField)
        view.addSubview(minusButton)
        view.addSubview(resetButton)
    }
    
    
    @objc private func plusButtonTapped() {
        print("plusButtonTapped")
    }
    @objc private func minusButtonTapped() {
        print("minusButtonTapped")
    }
    @objc private func resetButtonTapped() {
        print("resetButtonTapped")
    }
    
    @objc func incrementCount() {
       
        count += 1
        countNameLabel.text = "\(count)"
        let currentDate = getCurrentDate()
        history += "\(currentDate): значение изменено на +1\n"
        eventLogTextField.text = history
    }
    @objc func decrementCount() {
       
        if count > 0 {
            count -= 1
            countNameLabel.text = "\(count)"
            let currentDate = getCurrentDate()
            history += "\(currentDate): значение изменено на -1\n"
            eventLogTextField.text = history
        } else {
            let currentDate = getCurrentDate()
            history += "\(currentDate): попытка уменьшить значение счётчика ниже 0\n"
            eventLogTextField.text = history
        }
    }
    @objc func resetCount() {
            
            count = 0
            countNameLabel.text = "\(count)"
            let currentDate = getCurrentDate()
            history += "\(currentDate): значение сброшено\n"
            eventLogTextField.text = history
        }
        
        // Функция для получения текущей даты и времени в формате "dd.MM.yyyy HH:mm:ss"
        func getCurrentDate() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
            let currentDate = dateFormatter.string(from: Date())
            return currentDate
        }
    }
    
    extension  ViewController {
        private  func setContraints() {
            NSLayoutConstraint.activate([
                countNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
                countNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                countNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
               //countNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
              //  countNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
            
            NSLayoutConstraint.activate([
                eventLogTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
                eventLogTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                eventLogTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                eventLogTextField.heightAnchor.constraint(equalToConstant: 200)
                
            ])
            NSLayoutConstraint.activate([
                resetButton.topAnchor.constraint(equalTo: eventLogTextField.bottomAnchor, constant: 50),
                resetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                resetButton.heightAnchor.constraint(equalToConstant: 80),
                resetButton.widthAnchor.constraint(equalToConstant: 80)
            ])
            
            NSLayoutConstraint.activate([
                plusButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
              //plusButton.trailingAnchor.constraint(equalTo: minusButton.leadingAnchor,constant: -20),
              plusButton.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 30),
                plusButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
                plusButton.heightAnchor.constraint(equalToConstant: 80),
                plusButton.widthAnchor.constraint(equalToConstant: 150)
            ])
            
           NSLayoutConstraint.activate([
               //minusButton.leadingAnchor.constraint(equalTo: plusButton.trailingAnchor, constant: -20),
                minusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
              minusButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
                minusButton.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 30),
               minusButton.heightAnchor.constraint(equalToConstant: 80),
                minusButton.widthAnchor.constraint(equalToConstant: 150)
            ])
        }
}
            
            
            
            
            
            
            
            
            
            
     




