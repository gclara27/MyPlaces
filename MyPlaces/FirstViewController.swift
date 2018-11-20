//
//  FirstViewController.swift
//  MyPlaces
//
//  Created by user145617 on 9/21/18.
//  Copyright © 2018 UOC. All rights reserved.
//

import UIKit

class FirstViewController: UITableViewController, ManagerPlacesObserver {
    
    let m_provider:ManagerPlaces = ManagerPlaces.shared()
    let m_locationManager :ManagerLocation = ManagerLocation.shared()
    
    @IBOutlet var table: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view: UITableView = (self.view as? UITableView)!;
        view.delegate = self
        view.dataSource = self
        view.separatorColor = UIColor(white: 0.95, alpha: 1)
        
        // Add the view to the observer in order the list to be updated each time a place is moified
        let manager = ManagerPlaces.shared()
        manager.addObserver(object: self)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Number of elements from the manager
        return m_provider.GetCount()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Indicates sub-sections from the list
        // We always return 1 sa we do not use sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Detectar pulsación en un elemento
        
        // Select corresponding Place from the array
        let place = m_provider.GetItemAt(position: indexPath.row)
        //print("Elemnto seleccionado \(place?.Description ?? "" )")
        
        let dc:DetailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailController") as! DetailController
        dc.place = place   // Cargamos en el Place del DC el place seleccionado
        present(dc, animated: true, completion: nil)    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Devlver la altura de la fila situada en una posición determinada
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableCell else { return UITableViewCell() }
        
        
        // Get the item from the places array
        let place = m_provider.GetItemAt(position: indexPath.row)
        
        cell.nameLabel.text = place?.name
        if place?.type.rawValue == 0 {
            cell.typeLabel.text = "Generic"
        }
        else
        {
            cell.typeLabel.text = "Touristic"
        }
        
        if (place?.image != nil){
            
        }
        
        //Load the stored image from the file system
        if (place != nil){
            let manager = ManagerPlaces.shared()
            
            cell.cellImage.image = UIImage(contentsOfFile: manager.getPathImage(p: place!))
        }

        return cell
        
    }
/*    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Devolver una instancia de la clase UITableViewCell que pinte la fila seleccionada

        let cell = UITableViewCell()
            
        let wt: CGFloat = tableView.bounds.size.width
        
        // Add subviews to cell
        // UILabel and UIImageView
    
        let label = UILabel(frame: CGRect(x:0,y:0,width:wt,height:40))
        let font: UIFont = UIFont(name: "Arial", size: 20)!
        
        label.font = font
        label.numberOfLines = 4
        
        // Get the item from the places array
        let place = m_provider.GetItemAt(position: indexPath.row)
        label.text = place?.name
        
        label.sizeToFit()
        
        cell.contentView.addSubview(label)
            
        let imageIcon: UIImageView = UIImageView(image: UIImage(named:"sun.png"))
        imageIcon.frame = CGRect(x:10, y:50, width:50, height:50)
        cell.contentView.addSubview(imageIcon)
            
        return cell

    }
  */
    // Methods from the protocol ManagerPlacesObserver
    func onPlacesChange() {
        // each time a place is changed the list is update
        let view: UITableView = (self.view as? UITableView)!;
        view.reloadData()
    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let place = m_provider.GetItemAt(position: indexPath.row)

            let manager = ManagerPlaces.shared()
            manager.Remove(place!)
            manager.updateObservers()
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    
 
/*    override func viewWillAppear(_ animated: Bool) {
        // With the following lines we reaload the table with the new values from Places after we dismissed the DetailView
        let view: UITableView = (self.view as? UITableView)!;
        view.reloadData()
*/
}
    



