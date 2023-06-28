//
//  ViewController.swift
//  MyTableViewAdvance
//
//  Created by MicroBanker Nepal Pvt. Ltd. on 27/06/2023.
//

import UIKit

class ViewController: UIViewController {
    
    private let table: UITableView = {
        let table  = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell")
        table.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        return table
    }()
    
    private var models = [CellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpModels()
        
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        
    }
    
    private func setUpModels() {
        models.append(.collectionView(models: [
            CollectionTableCellModel(title: "Car 1", imageName: "car1"),
            CollectionTableCellModel(title: "Car 2", imageName: "car2"),
            CollectionTableCellModel(title: "Car 3", imageName: "car3"),
            CollectionTableCellModel(title: "Car 4", imageName: "car4"),
            CollectionTableCellModel(title: "Car 5", imageName: "car5"),
            CollectionTableCellModel(title: "Car 6", imageName: "car6"),
            CollectionTableCellModel(title: "Car 7", imageName: "car7")
        ], rows: 2))
        
        models.append(.list(models: [
            ListCellModel(title: "First Thing"),
            ListCellModel(title: "Second Thing"),
            ListCellModel(title: "Third Thing"),
            ListCellModel(title: "Four Thing"),
            ListCellModel(title: "Demo Thing")
            
        ]))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch models[section] {
        case .list(let models): return models.count
        case .collectionView(_, _): return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch models[indexPath.section] {
        case .list(let models):
            let model = models[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = model.title
            return cell
            
        case .collectionView(let models, _):
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
            cell.configure(with: models)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("hello \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch models[indexPath.section] {
        case .list(_): return 50
        case .collectionView(_, let rows): return 170 * CGFloat(rows)
        }

    }
}

