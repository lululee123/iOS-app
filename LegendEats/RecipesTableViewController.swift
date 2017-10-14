//
//  ViewControllerTableViewCell.swift
//  appproject
//
//  Created by 李文慈 on 2017/4/27.
//  Copyright © 2017年 lulu. All rights reserved.
//

import UIKit
import Firebase

struct Recipe {
    var name: String
    let thumbnails: String
    let prepTime: String
}


class RecipesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    var recipes = [Recipe]()
    var filteredRecipes = [Recipe]()
    let identifier: String = "tableCell"
    var searchActive : Bool = false
    var restaurantNameData:[String] = []
    var filtered:[String] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewResult: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
        navigationItem.title = "餐廳"
        
        /* Setup delegates */
        tableViewResult.delegate = self
        tableViewResult.dataSource = self
        searchBar.delegate = self
        
        initializeTheRecipes()
    }
    
    func initializeTheRecipes() {
        self.recipes = [Recipe(name: "李媽媽", thumbnails: "egg_benedict.jpg", prepTime: "1 hour"),
                        Recipe(name: "品客自助餐", thumbnails: "ham_and_egg_sandwich.jpg", prepTime: "30 min"),
                        Recipe(name: "豪享來", thumbnails: "full_breakfast.jpg", prepTime: "25 min"),
                        Recipe(name: "古早味", thumbnails: "hamburger.jpg", prepTime: "15 min"),
                        Recipe(name: "李爸爸", thumbnails: "green_tea.jpg", prepTime: "2 hour"),
                        Recipe(name: "品嗑自助餐", thumbnails: "creme_brelee.jpg", prepTime: "50 min"),
                        Recipe(name: "豪享吃", thumbnails: "instant_noodle_with_egg.jpg", prepTime: "55 min"),
                        Recipe(name: "古早味分店", thumbnails: "vegetable_curry.jpg", prepTime: "25 min"),
                       ]
        
        self.tableViewResult.reloadData()
        
        for index in 0..<recipes.endIndex {
            restaurantNameData.insert(recipes[index].name, at: index)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if(filtered.count == 0){
            searchActive = false
        } else {
            searchActive = true
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = restaurantNameData.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false
        } else {
            searchActive = true
        }
        self.tableViewResult.reloadData()
        self.filteredRecipes.removeAll()
    }
    
    
    // MARK: UITableView DataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? TableCell
        
        if(searchActive) {
            let filteredIndex: Int = restaurantNameData.index(of: filtered[indexPath.row])!
            self.filteredRecipes.append(Recipe(name: filtered[indexPath.row],
                                               thumbnails: recipes[filteredIndex].thumbnails,
                                               prepTime: recipes[filteredIndex].prepTime) )
            cell.configurateTheCell(filteredRecipes[indexPath.row])
        } else {
            cell.configurateTheCell(recipes[indexPath.row])
        }
        
        cell.contentView.backgroundColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0)
        
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.view.frame.size.width - 20, height: 275))
        
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 7.0
        //whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 3)
        //whiteRoundedView.layer.shadowOpacity = 0.02
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return recipes.count
    }
    
    /*func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            recipes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }*/
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableViewResult.indexPathForSelectedRow{
            self.tableViewResult.deselectRow(at: index, animated: true)
        }
    }
    
    // MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeDetail" {
            let indexPath = self.tableViewResult!.indexPathForSelectedRow
            let destinationViewController: DetailViewController = segue.destination as! DetailViewController
            if(!filteredRecipes.isEmpty) {
                destinationViewController.recipe = filteredRecipes[indexPath!.row]
            } else {
                destinationViewController.recipe = recipes[indexPath!.row]
            }
            //destinationViewController.recipe = recipes[indexPath!.row]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


