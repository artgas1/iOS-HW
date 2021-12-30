
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addRightBarButtonItem()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func addRightBarButtonItem() {
        let containerView = UIControl(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        containerView.addTarget(self, action: #selector(settingsPressed), for: .touchUpInside)
        let settingsImage = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        settingsImage.image = UIImage(named: Constants.settingsImageName)
        containerView.addSubview(settingsImage)
        let settingsImageItem = UIBarButtonItem(customView: containerView)
        settingsImageItem.width = 20
        navigationItem.rightBarButtonItem = settingsImageItem
    }
    
    @objc func settingsPressed() {
        let view = SettingsViewController()
        navigationController?.pushViewController(view, animated: true)
    }
}
