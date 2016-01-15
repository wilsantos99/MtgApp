//
//  EdicoesMtgTableViewController.swift
//  MtgApp
//
//  Created by Wilson Divino on 13/12/15.
//  Copyright © 2015 Wilson Divino. All rights reserved.
//

import UIKit
import Alamofire

class EdicoesMtgTableViewController: UITableViewController {
    
    var edicoesMTG : [EdicoesMtg] = []
    
    let segueEdicoesMtg = "EdicoesCartasSegue"

    @IBOutlet weak var tableViewEdicoes: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableViewEdicoes.delegate = self
        
        Alamofire.request(.GET, "http://api.mtgapi.com/v2/sets").responseJSON {
            
            response in
            
            if(response.result.isSuccess){
                
                let allSets = response.result.value as! NSDictionary;
                
                let sets = allSets["sets"] as! NSArray;
                
                for edicoes in sets {
                    
                    let nomeEdicaoMagic : String = edicoes["name"] as! String
                    let codeEdicaoMagic : String = edicoes["code"] as! String
                    
                    if( !nomeEdicaoMagic.isEmpty ) {
                        
                        let edicoesMtg = EdicoesMtg(nome: nomeEdicaoMagic, codigo: codeEdicaoMagic)
                        
                        self.edicoesMTG.append(edicoesMtg)
                        
                    }
                    
                }
                
                self.tableViewEdicoes.reloadData()
                
            }else{
                let alerta = UIAlertController(title: "Aviso", message: "Não foi possivel carregar as informações.", preferredStyle: UIAlertControllerStyle.Alert)
                
                let bttOk = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (bttOk) -> Void in
                    
                    print("Botão Ok Pressionado")
                    
                })
                
                alerta.addAction(bttOk)
                
                self.presentViewController(alerta, animated: true, completion: nil)
                
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.edicoesMTG.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("celulaEdicoesMtg", forIndexPath: indexPath) as UITableViewCell
        
        let edicoes = self.edicoesMTG[indexPath.row]
        
        cell.textLabel?.text = edicoes.getNome()

        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let edicoes = self.edicoesMTG[indexPath.row]
        
        let alertaClicou = UIAlertController(title: "Aviso", message: "Você clicou na edição \(edicoes.getNome()), e o código é \(edicoes.getCodigo())", preferredStyle: UIAlertControllerStyle.Alert)
        
        let bttOk = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        alertaClicou.addAction(bttOk)
        
        self.presentViewController(alertaClicou, animated: true, completion: nil)
        
    }

}
