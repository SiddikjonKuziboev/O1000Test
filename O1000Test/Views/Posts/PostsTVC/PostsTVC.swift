//
//  PostsTVC.swift
//  O1000Test
//
//  Created by Kuziboev Siddikjon on 08/10/23.
//

import UIKit
protocol PostsTVCDelegate {
    func setStar(index: IndexPath)
}
class PostsTVC: UITableViewCell {
    
    let titleLbl = UILabel()
    let bodyLbl = UILabel()
    let saveBtn = UIButton(type: .system)

    var delegate: PostsTVCDelegate?
    var indexPath: IndexPath!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        let h_sv = UIStackView(arrangedSubviews: [titleLbl, saveBtn])
        h_sv.alignment = .center
        h_sv.axis = .horizontal
        h_sv.spacing = 8
        h_sv.distribution = .equalSpacing
        
        saveBtn.setTitle("Save", for: .normal)
        saveBtn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        saveBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let v_sv = UIStackView(arrangedSubviews: [h_sv, bodyLbl])
        v_sv.alignment = .fill
        v_sv.axis = .vertical
        v_sv.spacing = 15
        v_sv.distribution = .fill
        v_sv.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(v_sv)
        
        
        titleLbl.font = UIFont.boldSystemFont(ofSize: 16)
        titleLbl.numberOfLines = 0
        titleLbl.textColor = UIColor.black
       
        bodyLbl.font = UIFont.systemFont(ofSize: 14)
        bodyLbl.numberOfLines = 0
        bodyLbl.textColor = UIColor.black

        let constraints = [

            v_sv.topAnchor.constraint(equalTo:  contentView.topAnchor, constant: 10),
            v_sv.bottomAnchor.constraint(equalTo:  contentView.bottomAnchor, constant: -10),
            v_sv.leftAnchor.constraint(equalTo:  contentView.leftAnchor, constant: 10),
            v_sv.rightAnchor.constraint(equalTo:  contentView.rightAnchor, constant: -10),
            
            saveBtn.heightAnchor.constraint(equalToConstant: 45),
            saveBtn.widthAnchor.constraint(equalToConstant: 45)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func updateCell(post: PostsDM, indexPath: IndexPath) {
        titleLbl.text = "Title: \(post.title)"
       bodyLbl.text = "body: \(post.body)"
        self.indexPath = indexPath

    }
    
    func updateCellForSaved(post: SavePostDM, indexPath: IndexPath) {
        titleLbl.text = "Title: \(post.title ?? "")"
       bodyLbl.text = "body: \(post.body ?? "")"
        self.indexPath = indexPath
        saveBtn.isHidden = true
    }
    
    
    @objc func buttonTapped() {
        delegate?.setStar(index: indexPath)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
