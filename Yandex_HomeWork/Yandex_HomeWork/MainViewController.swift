//
//  MainViewController.swift
//  Yandex_HomeWork
//
//  Created by Дмитрий Шмаков on 21.05.2023.
//
import UIKit



class MainViewController: UIViewController {
    
    var count = 0
    var history = "История изменений:\n"
    let countNameLabel = UILabel()
    let plusButton = UIButton()
    let minusButton = UIButton()
    let resetButton = UIButton()
    let eventLogTextField = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        //setContraints() Хотел  реализовать констрайны
         func setupViews() {
        
                 view.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
                 
                 view.addSubview(countNameLabel)
                 view.addSubview(plusButton)
                 view.addSubview(eventLogTextField)
                 view.addSubview(minusButton)
                 view.addSubview(resetButton)
             }
        
        // Настройка лейбла
    countNameLabel.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    countNameLabel.center = view.center
    countNameLabel.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
    countNameLabel.layer.cornerRadius = 10 //Не получилось сделать, возможно у label нет такого свойства 
    countNameLabel.textAlignment = .center
    countNameLabel.text = "\(count)"
    countNameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    countNameLabel.textAlignment = .center
    countNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        // Настройка кнопки "+"
    plusButton.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    plusButton.center = CGPoint(x: view.center.x - 50, y: view.center.y + 100)
    plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
    plusButton.addTarget(self, action: #selector(increaseCount), for: .touchUpInside)
    plusButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
    plusButton.layer.cornerRadius = 10
    plusButton.setImage(UIImage(named: "plusButton"), for: .normal)
    plusButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Настройка кнопки "-"
    minusButton.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    minusButton.center = CGPoint(x: view.center.x + 50, y: view.center.y + 100)
    minusButton.setImage(UIImage(systemName: "minus"), for: .normal)
    minusButton.addTarget(self, action: #selector(decreaseCount), for: .touchUpInside)
    minusButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
    minusButton.layer.cornerRadius = 10
    minusButton.setImage(UIImage(named: "minusButton"), for: .normal)
    minusButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Настройка кнопки обнуления
    resetButton.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
    resetButton.center = CGPoint(x: view.center.x, y: view.center.y + 200)
    resetButton.setTitle("RESET", for: .normal)
    resetButton.addTarget(self, action: #selector(resetCount), for: .touchUpInside)
    resetButton.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
    resetButton.layer.cornerRadius = 10
    resetButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Настройка текстового поля
    eventLogTextField.frame = CGRect(x: 0, y: 0, width: view.frame.width - 20, height: 200)
    eventLogTextField.center = CGPoint(x: view.center.x, y: view.center.y + 350)
    eventLogTextField.textAlignment = .left
    eventLogTextField.isEditable = false
    eventLogTextField.text = history
    eventLogTextField.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    eventLogTextField.layer.cornerRadius = 10
    eventLogTextField.textColor = .red
    eventLogTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    /* Хотел сделать нажатие на кнопку не смог разобраться с selector в настройках кнопках
    @objc private func plusButtonTapped() {
        print("plusButtonTapped")
    }
    @objc private func minusButtonTapped() {
        print("minusButtonTapped")
    }
    @objc private func resetButtonTapped() {
        print("resetButtonTapped")
    }
    */
    // Функция для увеличения значения счётчика
    @objc func increaseCount() {
        count += 1
        countNameLabel.text = "\(count)"
        let currentDate = getCurrentDate()
        history += "\(currentDate): значение изменено на +1\n"
        eventLogTextField.text = history
    }
    
    // Функция для уменьшения значения счётчика
    @objc func decreaseCount() {
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
    
    // Функция для обнуления значения счётчика
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
    /* Хотел  реализовать констрайны
extension  MainViewController {
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
*/
