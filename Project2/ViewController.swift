//
//  ViewController.swift
//  Project2
//
//  Created by Anna Shark on 26/7/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    

    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]

        
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased() + " (current score:  \(score))"
        questionNumber += 1
        print(questionNumber)
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        let answerCountry = countries[sender.tag].uppercased()
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        
        if 1..<10 ~= questionNumber  {
            if title == "Correct" {
                let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
                present(ac,animated: true)
            } else {
                let ac = UIAlertController(title: title, message: "It is a flag of \(answerCountry). Your score is \(score)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
                present(ac,animated: true)
            }

        } else {
            questionNumber = 0
            
            let ac = UIAlertController(title: title, message: "GAME END! Your final score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Start again", style: .default, handler: askQuestion))
            present(ac,animated: true)
            score = 0

        }

    }
    
    
    @objc func shareTapped() {
 
        let vc = UIActivityViewController(activityItems: ["I scored \(score) in Anya Shark's flag game! Top that!"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

    
}

