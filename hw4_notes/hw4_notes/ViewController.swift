import UIKit
import CoreData

class ViewController: UIViewController {
    
    let context: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "CoreDataNotes")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Container loading failed")
            }
        }
        return container.viewContext
    }()
    
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
        self.loadData()
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(barButtonSystemItem: .add,
                        target: self,
                        action: #selector(createNote(sender:)))
    }
    
    func saveChanges() {
        if context.hasChanges {
            try? context.save()
        }
        
        if let notes = try? context.fetch(Note.fetchRequest()) {
            self.notes = notes
        } else {
            self.notes = []
        }
    }
    
    func loadData() {
        if let notes = try? context.fetch(Note.fetchRequest()) {
            self.notes = notes.sorted(by: { $0.creationDate.compare($1.creationDate) == .orderedDescending })
        } else {
            self.notes = []
        }
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
    
    func collectionView(_ collectionView: UICollectionView,
        contextMenuConfigurationForItemAt indexPath: IndexPath, point:
        CGPoint) -> UIContextMenuConfiguration? {
            let identifier = "\(indexPath.row)" as NSString
                return UIContextMenuConfiguration(identifier: identifier, previewProvider: .none) { _ in
                let deleteAction = UIAction(title: "Delete", image:
                UIImage(systemName: "trash"), attributes:
                UIMenuElement.Attributes.destructive) { value in
                    self.context.delete(self.notes[indexPath.row])
                    self.saveChanges()
                }
            return UIMenu(title: "", image: nil, children: [deleteAction])
        }
    }
}
