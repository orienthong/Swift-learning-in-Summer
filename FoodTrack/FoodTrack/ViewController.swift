//
//  ViewController.swift
//  FoodTrack
//
//  Created by 洪浩东 on 8/6/16.
//  Copyright © 2016 scauos.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let burgerBtn = UIButton()
    let pozzaBtn = UIButton()
    let sandwitchBtn = UIButton()
    let tacoBtn = UIButton()
    let orderNowBtn = UIButton()
    let selectedItemThumbImg = UIImageView(image: UIImage(named: "burger"))
    let topViewHolder = UIView()
    let mainThumbViewHolder = UIView()
    let buttonViewHolder = UIView()
    let bottomViewHolder = UIView()
    let topThumbBtn = UIButton()
    let topTitleLbl = UILabel()
    
    let helpView = UIView()
    let anotherHelpView = UIView()
    
    var views = Dictionary<String, AnyObject>()
    var constraints = [NSLayoutConstraint]()
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = UIColor.purpleColor()
        self.topViewHolder.backgroundColor = UIColor.whiteColor()
        self.mainThumbViewHolder.backgroundColor = UIColor(red: 220.0/255.0, green: 224.0/255.0, blue: 210.0/255.0, alpha: 1.0)
        self.buttonViewHolder.backgroundColor = UIColor(red: 242.0/255.0, green: 241.0/255.0, blue: 239.0/255.0, alpha: 1.0)
        self.bottomViewHolder.backgroundColor = UIColor(red: 39.0/255.0, green: 61.0 / 255.0, blue: 72.0 / 255.0 , alpha: 1.0)
        
        
        self.topThumbBtn.setImage(UIImage(named: "burger"), forState: .Normal)
        self.topTitleLbl.text = "FOOD SHACK"
        self.topTitleLbl.textColor = UIColor(red: 39.0/255.0, green: 61.0 / 255.0, blue: 72.0 / 255.0 , alpha: 1.0)
        self.burgerBtn.setImage(UIImage(named: "burger"), forState: .Normal)
        self.pozzaBtn.setImage(UIImage(named: "pizza"), forState: .Normal)
        self.sandwitchBtn.setImage(UIImage(named: "sandwich"), forState: .Normal)
        self.tacoBtn.setImage(UIImage(named: "taco"), forState: .Normal)
        self.orderNowBtn.backgroundColor = UIColor.blueColor()
        self.orderNowBtn.setTitle("ORDER NOW", forState: .Normal)
        self.orderNowBtn.setTitleColor(UIColor.yellowColor(), forState: .Normal)
        self.orderNowBtn.layer.cornerRadius = 5.0
        
        self.topViewHolder.translatesAutoresizingMaskIntoConstraints = false
        self.mainThumbViewHolder.translatesAutoresizingMaskIntoConstraints = false
        self.buttonViewHolder.translatesAutoresizingMaskIntoConstraints = false
        self.bottomViewHolder.translatesAutoresizingMaskIntoConstraints = false
        self.topThumbBtn.translatesAutoresizingMaskIntoConstraints = false
        self.topTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        self.selectedItemThumbImg.translatesAutoresizingMaskIntoConstraints = false
        self.helpView.translatesAutoresizingMaskIntoConstraints = false
        self.anotherHelpView.translatesAutoresizingMaskIntoConstraints = false
        self.burgerBtn.translatesAutoresizingMaskIntoConstraints = false
        self.pozzaBtn.translatesAutoresizingMaskIntoConstraints = false
        self.sandwitchBtn.translatesAutoresizingMaskIntoConstraints = false
        self.tacoBtn.translatesAutoresizingMaskIntoConstraints = false
        self.orderNowBtn.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(topViewHolder)
        self.view.addSubview(mainThumbViewHolder)
        self.view.addSubview(buttonViewHolder)
        self.view.addSubview(bottomViewHolder)
        
        self.topViewHolder.addSubview(self.topThumbBtn)
        self.topViewHolder.addSubview(self.topTitleLbl)
        
        self.mainThumbViewHolder.addSubview(self.selectedItemThumbImg)
        self.mainThumbViewHolder.addSubview(self.helpView)
        self.mainThumbViewHolder.addSubview(self.anotherHelpView)
        
        self.buttonViewHolder.addSubview(burgerBtn)
        self.buttonViewHolder.addSubview(pozzaBtn)
        self.buttonViewHolder.addSubview(sandwitchBtn)
        self.buttonViewHolder.addSubview(tacoBtn)
        
        self.bottomViewHolder.addSubview(orderNowBtn)
        
        self.views["topViewHolder"] = topViewHolder
        self.views["mainThumbViewHolder"] = mainThumbViewHolder
        self.views["buttonViewHolder"] = buttonViewHolder
        self.views["bottomViewHolder"] = bottomViewHolder
        self.views["topThumbBtn"] = topThumbBtn
        self.views["topTitleLbl"] = topTitleLbl
        self.views["selectedItemThumbImg"] = selectedItemThumbImg
        self.views["helpView"] = helpView
        self.views["anotherHelpView"] = anotherHelpView
        self.views["burgerBtn"] = burgerBtn
        self.views["pozzaBtn"] = pozzaBtn
        self.views["sandwitchBtn"] = sandwitchBtn
        self.views["tacoBtn"] = tacoBtn
        self.views["orderNowBtn"] = orderNowBtn
        
        
        setConstraints()
    }

    func setConstraints() {
        
        /** TOP VIEW HOLDER **/
        addConstraint("V:|-20-[topViewHolder(50)]-0-[mainThumbViewHolder]")
        addConstraint("H:|-0-[topViewHolder]-0-|")
        
        /** MAIN VIEW HOLDER **/
        addConstraint("V:[mainThumbViewHolder(<=200@250)]-0-[buttonViewHolder]")
        addConstraint("V:[mainThumbViewHolder(>=150@250)]")
        addConstraint("H:|-0-[mainThumbViewHolder(==topViewHolder)]-0-|")
        
        /** BUTTON VIEW HOLDER **/
        addConstraint("V:[buttonViewHolder(<=300)]-0-[bottomViewHolder]")
        addConstraint("V:[buttonViewHolder(>=100)]")
        addConstraint("H:|-0-[buttonViewHolder(mainThumbViewHolder)]-0-|")
        
        //** BOTTOM VIEW HOLDER **/
        addConstraint("V:[bottomViewHolder(50@1000)]-|")
        addConstraint("H:|-0-[bottomViewHolder(buttonViewHolder)]-0-|")
        
        //** TOP THUMB BUTTON **/
        addConstraint("V:|-5-[topThumbBtn(40)]")
        addConstraint("H:|-5-[topThumbBtn(40)]-10-[topTitleLbl]")
        
        //** TOP TITLE LABEL **/
        addConstraint("V:|-5-[topTitleLbl(40)]")
        addConstraint("H:[topTitleLbl(>=50)]")
        
        //** selectedItemThumbImg **/
        addConstraint("V:|-[helpView]")
        addConstraint("H:|-[helpView]-|")
        
        let selectedItemThumbImgHorizotalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[helpView]-0-[selectedItemThumbImg(200)]", options: .AlignAllCenterX, metrics: nil, views: self.views)
        self.constraints += selectedItemThumbImgHorizotalConstraints
        
        addConstraint("V:|-[anotherHelpView]-|")
        addConstraint("H:|-[anotherHelpView]")
        
        let selectedItemThumbImgVeticolConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[anotherHelpView]-(>=0)-[selectedItemThumbImg(200)]", options: .AlignAllCenterY, metrics: nil, views: self.views)
        self.constraints += selectedItemThumbImgVeticolConstraints
        
        
        //** BOTTON VIEW HOLDER */
        addConstraint("H:|-20-[burgerBtn(120)]")
        addConstraint("V:|-5-[burgerBtn(120)]")
        
        addConstraint("H:|-20-[pozzaBtn(120)]")
        addConstraint("V:[pozzaBtn(120)]-5-|")
        
        addConstraint("H:[sandwitchBtn(120)]-20-|")
        addConstraint("V:|-5-[sandwitchBtn(120)]")
        
        addConstraint("H:[tacoBtn(sandwitchBtn)]-20-|")
        addConstraint("V:[tacoBtn(sandwitchBtn)]-5-|")
        
        //** BOTTOM HOLDER VIEW **/
        
        addConstraint("H:[orderNowBtn(200)]-5-|")
        addConstraint("V:|-5-[orderNowBtn]-5-|")
        
        
        NSLayoutConstraint.activateConstraints(self.constraints)
    }
    
    func addConstraint(format: String) {
        let newConstraints = NSLayoutConstraint.constraintsWithVisualFormat(format, options: [], metrics: nil, views: self.views)
        self.constraints += newConstraints
    }


}

