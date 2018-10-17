//
//  FirstViewController.swift
//  MyPlaces
//
//  Created by user145617 on 9/21/18.
//  Copyright © 2018 UOC. All rights reserved.
//

import UIKit

class FirstViewController: UITableViewController {
    
    let m_provider:ManagerPlaces = ManagerPlaces.shared()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view: UITableView = (self.view as? UITableView)!;
        view.delegate = self
        view.dataSource = self
        
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
        
        //Select corresponding Place from the array
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
        label.text = place?.Description
        
        label.sizeToFit()
        
        cell.contentView.addSubview(label)
            
        let imageIcon: UIImageView = UIImageView(image: UIImage(named:"sun.png"))
        imageIcon.frame = CGRect(x:10, y:50, width:50, height:50)
        cell.contentView.addSubview(imageIcon)
            
        return cell

    }
    
    
}

