//
//  ViewController.swift
//  PullzEyeGame
//
//  Created by Youssef on 08/09/2021.
//

import UIKit
class PullzEyeVC: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var sliderOutlet: UISlider!
    
    //MARK: - Constants & Variables
    let midValue = 50
    var targetValue = 0
    var roundValue = 1
    var scoreValue = 0
    var sliderValue = 0
    var difference = 0
    var statuse = ""
    var roundInfo = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSliderDesign()
        defaultValues()
        resetStoredValues()
    }
    //MARK: - IBAction
    @IBAction func resetAction(_ sender: UIButton) {
        assignRandomValueToTheTarget()
        sliderOutlet.value = Float(midValue)
        roundValue = 1
        roundLabel.text = "\(roundValue)"
        scoreValue = 0
        scoreLabel.text = "\(scoreValue)"
        saveChanges()
    }
    @IBAction func hitMeAction(_ sender: Any) {
        newRound()
        popAlert()
    }
    @IBAction func sliderAction(_ sender: UISlider) {
        sliderValue = Int( sender.value.rounded() )
    }
    
    //MARK: - Helper Method
    func setupSliderDesign() {
        let thumpImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        sliderOutlet.setThumbImage(thumpImageNormal, for: .normal)
        let thumpImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        sliderOutlet.setThumbImage(thumpImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        sliderOutlet.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        sliderOutlet.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    func assignRandomValueToTheTarget() {
        targetValue = Int.random(in: 2 ... 99)
        targetLabel.text = "\(targetValue)"
    }
    
    func calcScore() {
        difference = targetValue<sliderValue ? sliderValue-targetValue :  targetValue-sliderValue
        switch difference {
        case 0:
            statuse = "perfect (A+)"
            scoreValue += 200
        case 1...10:
            statuse = "Excellent (A)"
            scoreValue += 100
        case 11...20:
            statuse = "Very Good (B+)"
            scoreValue += 50
        case 21...30:
            statuse = "Good (B)"
            scoreValue += 25
        case 31...40:
            statuse = "Not Bad (C)"
            scoreValue += 10
        default:
            statuse = "GoodLuck !"
        }
        scoreLabel.text = "\(scoreValue)"
    }
    
    func newRound()  {
        roundValue += 1
        roundLabel.text = "\(roundValue)"
        sliderOutlet.value = Float( midValue )
        calcScore()
        saveChanges()
    }
    
    func popAlert() {
        roundInfo = "Your target = \(targetValue)\n your current value = \(sliderValue)\n and difference between them = \(difference)"
        let alert = UIAlertController(title: statuse, message: roundInfo, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .cancel) { (action) in
            self.assignRandomValueToTheTarget()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveChanges() {
        UserDefaults.standard.set(roundValue, forKey: "roundValue")
        UserDefaults.standard.synchronize()
        UserDefaults.standard.set(scoreValue, forKey: "scoreValue")
        UserDefaults.standard.synchronize()
        print("saveChanges")
    }
    func resetStoredValues() {
        print("resetStoredValues")
        scoreValue = UserDefaults.standard.integer(forKey: "scoreValue")
        scoreLabel.text = "\(scoreValue)"
        roundValue = UserDefaults.standard.integer(forKey: "roundValue")
        roundLabel.text = "\(roundValue)"
    }
    func defaultValues() {
        print("defaultValues")
        assignRandomValueToTheTarget()
        scoreLabel.text = "0"
        roundLabel.text = "1"
        sliderOutlet.value = Float(midValue)
    }
}

