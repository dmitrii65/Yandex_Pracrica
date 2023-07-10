//
//  fail2.swift
//  Yandex_HomeWork
//
//  Created by Дмитрий Шмаков on 06.06.2023.
//

import UIKit

class Question {
    let text: String
    let image: UIImage?
    let answer: Bool
    
    init(text: String, image: UIImage?, answer: Bool) {
        self.text = text
        self.image = image
        self.answer = answer
    }
}

class MovieQuizViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let questionLabel = UILabel()
    private let imageView = UIImageView()
    private let yesButton = UIButton(type: .system)
    private let noButton = UIButton(type: .system)
    
    private var questions: [Question] = []
    private var currentQuestionIndex = 0
    private var correctAnswers = 0
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Загрузка вопросов
        loadQuestions()
        
        // Настройка метки вопроса
        questionLabel.font = UIFont.systemFont(ofSize: 20)
        questionLabel.numberOfLines = 0
        view.addSubview(questionLabel)
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Настройка изображения фильма
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.clear.cgColor
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // Настройка кнопки "Да"
        yesButton.setTitle("Да", for: .normal)
        yesButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        yesButton.addTarget(self, action: #selector(yesButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(yesButton)
        yesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            yesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            yesButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)
        ])
        
        // Настройка кнопки "Нет"
        noButton.setTitle("Нет", for: .normal)
        noButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        noButton.addTarget(self, action: #selector(noButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(noButton)
        noButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            noButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)
        ])
        
        // Показ первого вопроса
        showQuestion()
    }
    
    // MARK: - Private Methods
    
    private func loadQuestions() {
        // Загрузка вопросов из базы данных или любого другого источника
        questions = [
            Question(text: "Рейтинг этого фильма больше 6?", image: UIImage(named: "movie1"), answer: true),
            Question(text: "Этот фильм вышел в 2000 году?", image: UIImage(named: "movie2"), answer: false),
            Question(text: "Этот фильм получил награду Оскар?", image: UIImage(named: "movie3"), answer: true),
            // Добавьте свои собственные вопросы здесь
        ]
