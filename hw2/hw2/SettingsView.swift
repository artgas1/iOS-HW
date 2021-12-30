import Foundation
import UIKit
import CoreLocation

class SettingsViewController: UIViewController {
    
    private let sliders = [UISlider(), UISlider(), UISlider()]
    private let locationManager = CLLocationManager()
    private let latlonLabel = UILabel()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        locationManager.requestWhenInUseAuthorization()
        navigationItem.titleView?.tintColor = .black
        addUI()
    }
    
    func addUI() {
        let toggleLabel = UILabel()
        toggleLabel.text = "Toggle"
        toggleLabel.textColor = .black
        let toggle = UISwitch()
        toggle.addTarget(self, action: #selector(didToggle), for: .valueChanged)
        
        let sliderLabels = [UILabel(), UILabel(), UILabel()]
        for (index, title) in ["Red", "Green", "Blue"].enumerated() {
            sliderLabels[index].text = title
            sliderLabels[index].textColor = .black
        }
        
        for slider in sliders {
            slider.maximumValue = 1.0
            slider.value = 1.0
            slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        }
        
        latlonLabel.text = " "
        latlonLabel.textColor = .black
        
        let stackView = UIStackView(arrangedSubviews: [
            toggleLabel,
            toggle,
            sliderLabels[0],
            sliders[0],
            sliderLabels[1],
            sliders[1],
            sliderLabels[2],
            sliders[2],
            latlonLabel,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        view.addSubview(stackView)
        
        stackView.spacing = 16.0
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0),
            stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 256),
            stackView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    @objc func sliderValueChanged() {
        let red = CGFloat(sliders[0].value)
        let green = CGFloat(sliders[1].value)
        let blue = CGFloat(sliders[2].value)
        view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    @objc func didToggle(_ sender: UISwitch) {
        if sender.isOn {
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
            } else {
                sender.setOn(false, animated: true)
            }
        } else {
            locationManager.stopUpdatingLocation()
            latlonLabel.text = " "
        }
    }
}

extension SettingsViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latlon = manager.location?.coordinate else {
            return
        }
        latlonLabel.text = "\(latlon.latitude); \(latlon.longitude)"
    }
}
