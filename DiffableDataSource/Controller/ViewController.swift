//
//  ViewController.swift
//  DiffableDataSource
//
//
//

import UIKit

struct User: Hashable {
    var name: String
    var backgroundColor: UIColor
    var section: Section
}
                
enum Section: String, CaseIterable {
    case main = "Geral"
    case vip = "VIP"
    case work = "Trabalho"
}


class ViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tablewView = UITableView(frame: .zero, style: .insetGrouped)
        tablewView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tablewView.delegate = self
        return tablewView
    }()
    
    typealias UserDataSource = UITableViewDiffableDataSource<Section, User>
    typealias UserSnapShot = NSDiffableDataSourceSnapshot<Section, User>
    
    private lazy var dataSource: UserDataSource = createDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        let data = setupMockData()
        updadeSnapshot(with: data)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.handleAdd))
    }
    
    @objc func handleAdd() {
        guard let randowSection = Section.allCases.randomElement()
        else{ return }
        let user = User(name: UUID().uuidString, backgroundColor: .randow(), section: randowSection)
        addItemsSnapshot(with: [user], section: randowSection)
    }
    
    func createDataSource() -> UserDataSource {
        UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, user in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = user.name
            cell.backgroundColor = user.backgroundColor
            return cell
        }
    }
    func updadeSnapshot(with values: [User]) {
        var snapshot = UserSnapShot ()
        snapshot.appendSections(Section.allCases)
        Section.allCases.forEach { section in
            let filterUsers = values.filter { $0.section == section }
            snapshot.appendItems(filterUsers, toSection: section)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    func addItemsSnapshot(with user: [User], section: Section) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(user, toSection: section)
        dataSource.apply(snapshot)
    }
    func remove(_ user: User) {
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems([user])
        dataSource.apply(snapshot)
    }
    
}
extension ViewController: ViewCode {
    
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func addConstraints() {
        tableView.fillSuperview()
    }
}

extension ViewController {
    func setupMockData() -> [User] {
        [User(name: "Carol", backgroundColor: .systemCyan, section: .main),
         User(name: "Anne", backgroundColor: .systemPurple, section: .vip),
         User(name: "Pedro", backgroundColor: .systemIndigo, section: .work)
        ]
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = dataSource.itemIdentifier(for: indexPath)
        else { return }
        remove(user)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = Section.allCases[section]
        let label = UILabel()
        label.text = section.rawValue
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
}
