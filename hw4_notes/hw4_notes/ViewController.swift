import UIKit

class ViewController: UIViewController {
    
    var notes: [Note] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(barButtonSystemItem: .add,
                        target: self,
                        action: #selector(createNote(sender:)))
    }
    
    @objc func createNote(sender: UIBarButtonItem) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "NoteViewController") as? NoteViewController else {
            return
        }
        vc.outputVC = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteCell", for: indexPath) as! NoteCell
        let note = notes[indexPath.row]
        cell.title.text = note.title
        cell.body.text = note.body
        return cell
    }
}
