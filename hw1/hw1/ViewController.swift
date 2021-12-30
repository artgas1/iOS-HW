
import UIKit

class ViewController: UIViewController {
    @IBOutlet var views: [UIView]!

    @IBOutlet weak var animateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func onAnimate(_ sender: Any) {
        animateButton.isEnabled = false
        
        var set = Set<UIColor>()
        for _ in 0..<views.count {
            let color = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
            set.insert(color)
        }
        
        UIView.animate(withDuration: 1.0, animations: {
            for view in self.views {
                view.backgroundColor = set.popFirst()
                view.layer.cornerRadius = .random(in: 0...10)
            }
        }, completion: { _ in
            self.animateButton.isEnabled = true
        })
    }
}

