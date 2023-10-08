//
//  PostDetailTVC.swift
//  O1000Test
//
//  Created by Kuziboev Siddikjon on 08/10/23.
//

import UIKit

class PostDetailTVC: UITableViewCell {
    
    let nameLbl = UILabel()
    let usernameLbl = UILabel()
    let emailLbl = UILabel()
    let addressLbl = UILabel()
    let phoneLbl = UILabel()
    let websiteLbl = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        let v_sv = UIStackView(arrangedSubviews: [nameLbl, usernameLbl, emailLbl, addressLbl, phoneLbl, websiteLbl])
        v_sv.alignment = .fill
        v_sv.axis = .vertical
        v_sv.spacing = 15
        v_sv.distribution = .fill
        v_sv.translatesAutoresizingMaskIntoConstraints = false
        addSubview(v_sv)
        
        
        nameLbl.font = UIFont.boldSystemFont(ofSize: 16)
        nameLbl.textColor = UIColor.black
        
        usernameLbl.font = UIFont.systemFont(ofSize: 14)
        usernameLbl.textColor = UIColor.darkGray
        
        emailLbl.font = UIFont.systemFont(ofSize: 14)
        emailLbl.textColor = UIColor.black
        
       addressLbl.font = UIFont.systemFont(ofSize: 14)
       addressLbl.textColor = UIColor.darkGray
        
        
        addressLbl.font = UIFont.systemFont(ofSize: 14)
        addressLbl.textColor = UIColor.darkGray
        phoneLbl.font = UIFont.systemFont(ofSize: 14)
        phoneLbl.textColor = UIColor.darkGray
        websiteLbl.font = UIFont.systemFont(ofSize: 14)
        websiteLbl.textColor = UIColor.darkGray
         

        let constraints = [

            v_sv.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            v_sv.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            v_sv.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            v_sv.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func updateCell(user: PostDetailDM) {

            nameLbl.text = "Name: \(user.name)"
           usernameLbl.text = "Username: \(user.username)"
           emailLbl.text = "Email: \(user.email)"
           
           // Address
           let address = user.address
           addressLbl.text = "Address: \(address.street), \(address.suite), \(address.city), \(address.zipcode)"
           
           phoneLbl.text = "Phone: \(user.phone)"
           websiteLbl.text = "Website: \(user.website)"
           
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

