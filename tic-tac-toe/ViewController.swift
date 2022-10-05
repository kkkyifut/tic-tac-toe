import UIKit

let tap: UIButton = UIButton()


class ViewController: UIViewController {
    @IBOutlet weak var fieldLabel_1: UIImageView!
    @IBOutlet weak var fieldLabel_2: UIImageView!
    @IBOutlet weak var fieldLabel_3: UIImageView!
    @IBOutlet weak var fieldLabel_4: UIImageView!
    @IBOutlet weak var fieldLabel_5: UIImageView!
    @IBOutlet weak var fieldLabel_6: UIImageView!
    @IBOutlet weak var fieldLabel_7: UIImageView!
    @IBOutlet weak var fieldLabel_8: UIImageView!
    @IBOutlet weak var fieldLabel_9: UIImageView!
    @IBOutlet weak var fieldButton_1: UIButton!
    @IBOutlet weak var fieldButton_2: UIButton!
    @IBOutlet weak var fieldButton_3: UIButton!
    @IBOutlet weak var fieldButton_4: UIButton!
    @IBOutlet weak var fieldButton_5: UIButton!
    @IBOutlet weak var fieldButton_6: UIButton!
    @IBOutlet weak var fieldButton_7: UIButton!
    @IBOutlet weak var fieldButton_8: UIButton!
    @IBOutlet weak var fieldButton_9: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet var gameMode: UILabel!
    
    var buttons: [UIButton?] { return [fieldButton_1, fieldButton_2, fieldButton_3, fieldButton_4, fieldButton_5, fieldButton_6, fieldButton_7, fieldButton_8, fieldButton_9] }
    var labels: [UIImageView?] { return [fieldLabel_1, fieldLabel_2, fieldLabel_3, fieldLabel_4, fieldLabel_5, fieldLabel_6, fieldLabel_7, fieldLabel_8, fieldLabel_9] }
    let emptyImage = UIImage(named: "empty")
    var iconLabel = UIImage(named: "cross")
    var trigger: Bool = false
    var triggerAI: Bool = false
    var gameEnded: Bool = false
    var indexDead = 0
    let modePVE = "PvE"
    let modeDemo = "Demo (beta)"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newGameButton(tap)
    }
    
    @IBAction func clickAnyButton(_ sender: UIButton) {
        let indexButton = buttons.firstIndex(of: sender)
        print("clickButton_\(indexButton!+1)")
        let label = labels[indexButton!]
        label!.image = iconLabel
        sender.isEnabled = false
        changeIcon()
        checkMode()
    }
        
    @IBAction func newGameButton(_ sender: UIButton) {
        print("newGameButton")
        gameMode.text = textModeOnMain
        for button in buttons {
            button?.isEnabled = true
        }
        for label in labels {
            label?.image = emptyImage
            label?.backgroundColor = .white
        }
        resultLabel.text = ""
        gameEnded = false
        if textModeOnMain == modeDemo {
            checkMode()
        }
     }

    func gameWithAI() {
        if gameEnded { view.isUserInteractionEnabled = true }
        while !view.isUserInteractionEnabled && triggerAI && !gameEnded {
            var randomFieldButton = buttons.randomElement()!
            while !randomFieldButton!.isEnabled {
                randomFieldButton = buttons.randomElement()!
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.clickAnyButton(randomFieldButton!)
                self.view.isUserInteractionEnabled = true
                self.triggerAI = false
            }
            if textModeOnMain == modeDemo {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.checkMode()
                }
            }
            return
        }
    }
    
    func checkMode() {
        if textModeOnMain == modePVE && view.isUserInteractionEnabled ||
           textModeOnMain == modeDemo && view.isUserInteractionEnabled {
            self.view.isUserInteractionEnabled = false
            triggerAI = true
            gameWithAI()
        }
    }
    
    func checkResult() {
        let case_1 = fieldLabel_1.image == fieldLabel_2.image && fieldLabel_3.image == fieldLabel_2.image && fieldLabel_2.image != emptyImage
        let case_2 = fieldLabel_4.image == fieldLabel_5.image && fieldLabel_6.image == fieldLabel_5.image && fieldLabel_5.image != emptyImage
        let case_3 = fieldLabel_7.image == fieldLabel_8.image && fieldLabel_9.image == fieldLabel_8.image && fieldLabel_8.image != emptyImage
        let case_4 = fieldLabel_1.image == fieldLabel_4.image && fieldLabel_7.image == fieldLabel_4.image && fieldLabel_4.image != emptyImage
        let case_5 = fieldLabel_2.image == fieldLabel_5.image && fieldLabel_8.image == fieldLabel_5.image && fieldLabel_5.image != emptyImage
        let case_6 = fieldLabel_3.image == fieldLabel_6.image && fieldLabel_9.image == fieldLabel_6.image && fieldLabel_6.image != emptyImage
        let case_7 = fieldLabel_1.image == fieldLabel_5.image && fieldLabel_9.image == fieldLabel_5.image && fieldLabel_5.image != emptyImage
        let case_8 = fieldLabel_3.image == fieldLabel_5.image && fieldLabel_7.image == fieldLabel_5.image && fieldLabel_5.image != emptyImage

        if case_1 {
            gameEnded = true
            fieldLabel_1.backgroundColor = .gray
            fieldLabel_2.backgroundColor = .gray
            fieldLabel_3.backgroundColor = .gray
        } else if case_2 {
            gameEnded = true
            fieldLabel_4.backgroundColor = .gray
            fieldLabel_5.backgroundColor = .gray
            fieldLabel_6.backgroundColor = .gray
        } else if case_3 {
            gameEnded = true
            fieldLabel_7.backgroundColor = .gray
            fieldLabel_8.backgroundColor = .gray
            fieldLabel_9.backgroundColor = .gray
        } else if case_4 {
            gameEnded = true
            fieldLabel_1.backgroundColor = .gray
            fieldLabel_4.backgroundColor = .gray
            fieldLabel_7.backgroundColor = .gray
        } else if case_5 {
            gameEnded = true
            fieldLabel_2.backgroundColor = .gray
            fieldLabel_5.backgroundColor = .gray
            fieldLabel_8.backgroundColor = .gray
        } else if case_6 {
            gameEnded = true
            fieldLabel_3.backgroundColor = .gray
            fieldLabel_6.backgroundColor = .gray
            fieldLabel_9.backgroundColor = .gray
        } else if case_7 {
            gameEnded = true
            fieldLabel_1.backgroundColor = .gray
            fieldLabel_5.backgroundColor = .gray
            fieldLabel_9.backgroundColor = .gray
        } else if case_8 {
            gameEnded = true
            fieldLabel_3.backgroundColor = .gray
            fieldLabel_5.backgroundColor = .gray
            fieldLabel_7.backgroundColor = .gray
        }
                
        if indexDead == 0 && !gameEnded {
            gameEnded = true
            resultLabel.text = "Dead heat"
            resultLabel.textColor = .systemGreen
            return
        }

        if gameEnded {
            for button in buttons {
                button?.isEnabled = false
            }
            if !trigger {
                resultLabel.text = "X win!"
                resultLabel.textColor = .systemMint
            } else {
                resultLabel.text = "O win!"
                resultLabel.textColor = .systemOrange
            }
        }
        
    }

    func changeIcon() {
        indexDead = 0
        for button in buttons {
            if button?.isEnabled == true { indexDead += 1 }
        }
        checkResult()
        if !gameEnded {
            iconLabel = trigger ? UIImage(named: "cross") : UIImage(named: "zero")
            trigger.toggle()
        }
    }

}
