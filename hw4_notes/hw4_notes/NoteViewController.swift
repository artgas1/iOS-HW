import Foundation
import UIKit

struct Note {
    let title: String
    let body: String
}

class NoteViewController: UIViewController {
    
    @IBOutlet weak var bodyTF: UITextView!
    @IBOutlet weak var titleTF: UITextField!
    
    var outputVC: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                        target: self,
                        action: #selector(didTapSaveNote(button:)))
    }
    
    @objc
    func didTapSaveNote(button: UIBarButtonItem) {
        let title = titleTF.text ?? ""
        let body = bodyTF.text ?? ""
        
        if title.isEmpty {
            return
        }
        
        let note = Note(title: title, body: body)
        outputVC!.notes.append(note)
        self.navigationController?.popViewController(animated: true)
    }
}
