import UIKit

class AppDetailsController: UITableViewController {
 
    var rating: Rating!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "DetailsCellSmall", bundle: nil), forHeaderFooterViewReuseIdentifier: "DetailsCellSmall")
        tableView.register(UINib(nibName: "DetailsHeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "DetailsHeaderCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        setHeader()
        setFooter()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch (indexPath.row) {
        case 0:
            return buildCell(from: "DetailsCellSmall", displays: "Version", and: rating.latestVersion, at: indexPath)
        case 1:
            return buildCell(from: "DetailsCellSmall", displays: "Rating", and: String(rating.overallAverageRating), at: indexPath)
        case 2:
            return buildCell(from: "DetailsCellSmall", displays: "Rating Count", and: String(rating.overallRatingCount), at: indexPath)
        case 3:
            return buildCell(from: "DetailsCellLarge", displays: "Release Notes", and: rating.releaseNotes, at: indexPath )
        default:
            return UITableViewCell()
        }
    }
    
    private func setHeader() {
        let header = Bundle.main.loadNibNamed("DetailsHeaderCell", owner: nil, options: nil)?.first! as! DetailsHeaderCell
        header.present(rating: rating)
        tableView.tableHeaderView = header
    }
    
    private func setFooter() {
        let footer = Bundle.main.loadNibNamed("DetailsFooterCell", owner: nil, options: nil)?.first! as! DetailsFooterCell
        tableView.tableFooterView = footer
    }
 
    private func buildCell(from identifier: String, displays key: String, and value: String, at indexPath: IndexPath) -> UITableViewCell {
        switch (identifier) {
        case "DetailsCellSmall":
            let cell = Bundle.main.loadNibNamed("DetailsCellSmall", owner: nil, options: nil)?.first! as! DetailsCellSmall
            cell.present(key: key, value: value)
            return cell
        case "DetailsCellLarge":
            let cell = Bundle.main.loadNibNamed("DetailsCellLarge", owner: nil, options: nil)?.first! as! DetailsCellLarge
            cell.present(key: key, value: value)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return 4}

    static func newController(for rating: Rating) -> AppDetailsController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "AppDetailsController") as! AppDetailsController
        vc.rating = rating
        return vc
    }
}
