import UIKit

var textModeOnMain = "PvP"
var indexChangeMode = 0

class SettingsViewController: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textLabelSizeField: UILabel!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var segmentSizeField: UISegmentedControl!

    override func viewDidLoad() {
        print("ViewDidLoad")
        super.viewDidLoad()
        if indexChangeMode == 0 {
            segment.selectedSegmentIndex = 1
        } else if let value = UserDefaults.standard.value(forKey: "chosenOption") {
            let selectedIndex = value as! Int
            segment.selectedSegmentIndex = selectedIndex
        }
        textLabel.text = "Selected mode: " + (segment.titleForSegment(at: segment.selectedSegmentIndex) ?? "")
        textLabelSizeField.text = "Size field: " + (segmentSizeField.titleForSegment(at: segmentSizeField.selectedSegmentIndex) ?? "")
    }

    @IBAction func changeGameMode(_ sender: AnyObject) {
        indexChangeMode += 1
        textLabel.text = "Selected mode: " + (sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "")
        UserDefaults.standard.set(sender.selectedSegmentIndex, forKey: "chosenOption")
        print(segment.titleForSegment(at: segment.selectedSegmentIndex)!)
        textModeOnMain = sender.titleForSegment(at: sender.selectedSegmentIndex)!
    }

}
