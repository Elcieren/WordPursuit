//
//  GameViewController.swift
//  WordPursuit
//
//  Created by Eren Elçi on 8.10.2024.
//

import UIKit


class GameViewController: UIViewController {
    
    var selectedGame: String?
    @IBOutlet var labelText: UILabel!
    
    var cluesLabel: UILabel!
    var answerLabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var letterButtons = [UIButton]()
    
    
    var activitedButton = [UIButton]()
    var solutions = [String]()
    
    
    var score = 0 {
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    var level = 1
    
    //iew henüz bellekten oluşturulmadan önce
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemPurple
        
        scoreLabel = UILabel()
        //Bu, otomatik boyutlandırma maskelerini devre dışı bırakır ve manuel olarak yerleşim (Auto Layout)kullanacağımız anlamına gelir.
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        scoreLabel.textColor = .white
        view.addSubview(scoreLabel)
        
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.text = "CLUES"
        cluesLabel.numberOfLines = 0
        cluesLabel.textColor = .white
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(cluesLabel)
        
        
        answerLabel = UILabel()
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.font = UIFont.systemFont(ofSize: 24)
        answerLabel.text = "ANSWERS"
        answerLabel.textAlignment = .right
        answerLabel.numberOfLines = 0
        answerLabel.textColor = .white
        answerLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(answerLabel)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        submit.setTitleColor(UIColor(red: 1.0, green: 0.75, blue: 0.8, alpha: 1.0), for: .normal)
        submit.addTarget(self, action: #selector(submitTapped), for: UIControl.Event.touchUpInside)
        view.addSubview(submit)

        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        clear.setTitleColor(UIColor(red: 1.0, green: 0.75, blue: 0.8, alpha: 1.0), for: .normal)
        clear.addTarget(self, action: #selector(clearTapped), for: UIControl.Event.touchUpInside)
        view.addSubview(clear)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor ,constant: 100),
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor , multiplier:  0.6 ,constant: -100 ),
            
            answerLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            answerLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor,constant: -100),
            answerLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4 , constant: -100),
            answerLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 40),
            
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submit.heightAnchor.constraint(equalToConstant: 44),

            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            clear.heightAnchor.constraint(equalToConstant: 44),
            
            
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            
        ])
        
        let width = 150
        let height = 80
        for row in 0..<4 {
            for col in 0..<5 {
                // create a new button and give it a big font size
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButton.setTitleColor(UIColor(red: 1.0, green: 0.75, blue: 0.8, alpha: 1.0), for: .normal)

                // give the button some temporary text so we can see it on-screen
                letterButton.setTitle("WWW", for: .normal)
                letterButton.addTarget(self, action: #selector(letterTapped), for: UIControl.Event.touchUpInside)

                // calculate the frame of this button using its column and row
                let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                letterButton.frame = frame

                // add it to the buttons view
                buttonsView.addSubview(letterButton)

                // and also to our letterButtons array
                letterButtons.append(letterButton)
            }
        }
        
        
    }
    
    //view’ yüklenip bellekten oluşturulduktan sonra,
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLevel()
        
    }
    
    @objc func letterTapped(_ sender: UIButton){
        guard let buttonTitle = sender.titleLabel?.text else { return }
        
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        activitedButton.append(sender)
        sender.isHidden = true
    }
    
    @objc func submitTapped(_ sender: UIButton){
        guard let answerText = currentAnswer.text else { return }
        
        
        if let solitionsPosition = solutions.firstIndex(of: answerText) {
            activitedButton.removeAll()
            
            var splitAnswer = answerLabel.text?.components(separatedBy: "\n")
            splitAnswer?[solitionsPosition] = answerText
            answerLabel.text = splitAnswer?.joined(separator: "\n")
            currentAnswer.text = ""
            score += 1
            scoreLabel.text = "Score: \(score)"
            
            if score % 7 == 0 {
                let ac = UIAlertController(title: "Well Done!", message: "Are you ready for the next level", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Lets go ", style: .default, handler: levelUp))
                present(ac, animated: true)
            }
        }
    }
    
    func levelUp(action: UIAlertAction){
        level += 1
        solutions.removeAll(keepingCapacity: true)
        loadLevel()
        for button in letterButtons {
            button.isHidden = false
        }
    }
    
    
    @objc func  clearTapped(_ sender: UIButton){
        currentAnswer.text = ""
        
        for button in activitedButton {
            button.isHidden = false
        }
        activitedButton.removeAll()
    }
    
    func loadLevel() {
        var clueString = ""
        var solutionsString = ""
        var letterBits = [String]()
        
        if let levelFileURL  = Bundle.main.url(forResource: "\(selectedGame!)Level\(level)", withExtension: "txt") {
            if let levelContents = try? String(contentsOf: levelFileURL) {
                
                var lines = levelContents.components(separatedBy: "\n")
                
                lines.shuffle()
                
                
                for (index , line) in lines.enumerated() {
                    
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0]
                    let clu = parts[1]
                
                    
                    clueString += "\(index + 1). \(clu)\n"
                    
                    
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    
                    solutionsString += "\(solutionWord.count) letters\n"
                    solutions.append(solutionWord)
                    
                    
                    let bit = answer.components(separatedBy: "|")
                    letterBits += bit
                    print(letterBits)
                    
                    
                }
            }
        }
        
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answerLabel.text = solutionsString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        letterButtons.shuffle()
        
        if letterButtons.count == letterBits.count {
            for i in 0..<letterButtons.count {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
    }
    


}
