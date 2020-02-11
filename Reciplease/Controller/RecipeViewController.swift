//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Edouard PLANTEVIN on 23/01/2020.
//  Copyright © 2020 Edouard PLANTEVIN. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
    
    enum page {
        case search
        case favorite
    }
    
    var currentPage: page = .favorite
    var selectedRecipe: RecipeObject?
    
    // MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gradientViewCell: UIView!
    @IBOutlet weak var titleRecipeLabel: UILabel!
    @IBOutlet weak var detailRecipeLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    // MARK: - Func ViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detailRecipe") {
            let vc = segue.destination as! DetailRecipeViewController
            vc.recipe = selectedRecipe
        }
    }

}


// MARK: - TableView Recipe
extension RecipeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRecipe = RecipeService.shared.recipes![indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecipeService.shared.recipes!.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeTableViewCell else { return UITableViewCell() }
        
        //let recipe = Ingredient.all[indexPath.row]
        let recipe = RecipeService.shared.recipes?[indexPath.row]
        
        var detailString = ""
        for ingredient in recipe!.ingredient {
            detailString += ingredient.key + " "
        }
        
        let imageURL = recipe?.image ?? "12218_large"
        let url = URL(string: imageURL)
        let data = try? Data(contentsOf: url!)
        let image = UIImage(data: data!)!
        
        cell.configure(withImage: image, title: recipe!.name, detail: detailString, time: "\(recipe!.time / 60) h", likes: "2.5")
        return cell
    }
    
}
