//
//  BlockGame.swift
//  Yandex_HomeWork
//
//  Created by Дмитрий Шмаков on 06.06.2023.
//


import UIKit

struct QuizStepViewModel {
    let image: UIImage
    let question: String
    let questionNumber: String
}

struct QuizResultsViewModel {
    let title: String
    let text: String
    let buttonText: String
}

struct QuizQuestion {
    let image: String
    let text: String
    let correctAnswer: Bool
}

final class MovieQuizViewController: UIViewController {
    
    private var currentQuestionIndex = 0
    private var correctAnswers = 0
    
    private let questions: [QuizQuestion] = [
        QuizQuestion(
            image: "The Godfather",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Dark Knight",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "Kill Bill",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Avengers",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "Deadpool",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Green Knight",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "Old",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "The Ice Age Adventures of Buck Wild",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "Tesla",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "Vivarium",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        showNextQuestionOrResults()
        setConstraints()
    }
  
    private func setupViews() {
        view.backgroundColor = .ypBlack
        
        view.addSubview(noButton)
        view.addSubview(yesButton)
        view.addSubview(questionTextLable)
        view.addSubview(cinemaImageView)
        view.addSubview(questionLable)
        view.addSubview(numberQuestion)
        
        
    }
    private  let questionLable: UILabel = {
        let lable = UILabel()
        lable.text = "Вопрос:"
        lable.font = .ysDisplayMedium()
        lable.textColor = .white
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private lazy var  noButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(noButtonClicked), for: .touchUpInside)
        button.backgroundColor = .ypWhite
        button.layer.cornerRadius = 15
        button.setTitle("Нет", for: .normal)
        button.titleLabel?.font = .ysDisplayMedium()
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var  yesButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(yesButtonClicked), for: .touchUpInside)
        button.backgroundColor = .ypWhite
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .ysDisplayMedium()
        button.setTitle("Да", for: .normal)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let questionTextLable: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .ypWhite
        label.numberOfLines = 0
        label.font = .ysDisplayBold()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cinemaImageView: UIImageView = {
        let cinemaImage = UIImageView()
        cinemaImage.contentMode = .scaleAspectFit
        cinemaImage.layer.cornerRadius = 20
        cinemaImage.clipsToBounds = true
        cinemaImage.translatesAutoresizingMaskIntoConstraints = false
        return cinemaImage
    }()
    
    let numberQuestion: UILabel = {
        let label = UILabel()
        label.font = .ysDisplayMedium()
        label.textColor = .ypWhite
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @objc private func yesButtonClicked(_ sender: Any) {
        let currentQuestion = questions[currentQuestionIndex]
        let givenAnswer = true
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
        
    }
    
    @objc private func noButtonClicked(_ sender: Any) {
        let currentQuestion = questions[currentQuestionIndex]
        let givenAnswer = false
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
        
    }
    
   private func setEnabledButtons(isEnabled: Bool)  {
         noButton.isEnabled = isEnabled
         yesButton.isEnabled = isEnabled
     }
    
    private func showAnswerResult(isCorrect: Bool) {
        if isCorrect {
            correctAnswers += 1
            cinemaImageView.layer.borderColor = UIColor.ypGreen.cgColor
        } else {
            cinemaImageView.layer.borderColor = UIColor.ypRed.cgColor
        }
        cinemaImageView.layer.borderWidth = 8.0
        cinemaImageView.layer.cornerRadius = 20
        yesButton.isEnabled = false
        noButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.showNextQuestionOrResults()
            self?.clearAnswerButtonBorders()
        }
    }
    
    private func clearAnswerButtonBorders() {
        cinemaImageView.layer.borderColor  = UIColor.ypBlack.cgColor
    }
    
    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questions.count - 1 {
            
            
             let resultsViewModel = QuizResultsViewModel(
             title: "Раунд окончен",
             text: "Вы отвели правильно \(correctAnswers) из \(questions.count) ",
             buttonText: "Сыграть ещё раз")
             
             show(viewModel: resultsViewModel)
             
            currentQuestionIndex += 1
        } else {
            let currentQuestion = questions[currentQuestionIndex]
            let questionViewModel = convert(model: currentQuestion)
            setEnabledButtons(isEnabled: true)
            show(viewModel: questionViewModel)
            currentQuestionIndex += 1
        }
    }
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        let questionStep = QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questions.count)")
        return questionStep
    }
    
    private func show(viewModel: QuizStepViewModel) {
        cinemaImageView.image = viewModel.image
        questionTextLable.text = viewModel.question
        numberQuestion.text = viewModel.questionNumber
    }
    
    private func show(viewModel: QuizResultsViewModel) {
        let alertController = UIAlertController(
            title: viewModel.title,
            message: viewModel.text,
            preferredStyle: .alert)
        
        let restartAction = UIAlertAction(
            title: viewModel.buttonText,
            style: .default) { [weak self] _ in
                self?.currentQuestionIndex = 0
                self?.correctAnswers = 0
                self?.showNextQuestionOrResults()
            }
        
        alertController.addAction(restartAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
    extension MovieQuizViewController {
        
        private func setConstraints(){
            
            NSLayoutConstraint.activate([
                numberQuestion.topAnchor.constraint(equalTo: view.topAnchor, constant: 54),
                numberQuestion.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
            
            NSLayoutConstraint.activate([
                questionLable.topAnchor.constraint(equalTo: view.topAnchor, constant: 54),
                questionLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
            ])
            NSLayoutConstraint.activate([
                cinemaImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                cinemaImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                cinemaImageView.widthAnchor.constraint(equalToConstant: 335),
                cinemaImageView.heightAnchor.constraint(equalToConstant: 502),
                cinemaImageView.topAnchor.constraint(equalTo: numberQuestion.bottomAnchor, constant: 20)
                
            ])
            NSLayoutConstraint.activate([
                questionTextLable.topAnchor.constraint(equalTo: cinemaImageView.bottomAnchor, constant: 33),
                questionTextLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -62),
                questionTextLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 62)
            ])
            NSLayoutConstraint.activate([
                noButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 718),
                noButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                noButton.heightAnchor.constraint(equalToConstant: 60),
                noButton.widthAnchor.constraint(equalToConstant: 157)
            ])
            NSLayoutConstraint.activate([
                yesButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 718),
                yesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 197),
                yesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                yesButton.heightAnchor.constraint(equalToConstant: 60),
                yesButton.widthAnchor.constraint(equalToConstant: 158)
            ])
            
        }
    }

    
    

