//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Tao Jie on 9/1/16.
//
//

import UIKit

class RatingControl: UIView {


    //Mark properties
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    var ratingButtons = [UIButton]()
    
    let starCount = 5
    var buttonSize = 44
    let spacing = 1

    
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
      
        let emptyStarImage = UIImage(named: "EmptyStar")
        let filledStarImage = UIImage(named: "FilledStar")
        
        for _ in 0..<starCount {
            
            let button = UIButton()
            
            button.setImage(emptyStarImage, for: UIControlState())
            button.setImage(filledStarImage, for: .selected)
            button.setImage(filledStarImage, for: [.highlighted, .selected])
            
            button.adjustsImageWhenHighlighted = false
            
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(_:)), for: .touchDown)
            
            self.ratingButtons += [button]
            
            self.addSubview(button)
            

        }
        
        
    }
    
    override var intrinsicContentSize : CGSize {
        let contentSize = buttonSize * starCount + spacing * (starCount - 1)
        
        return CGSize(width: contentSize, height: buttonSize)
    }
    
    override func layoutSubviews() {
        // Set the button's width and height to a square the size of the frame's height.
        var buttonFrame = CGRect(x:0, y:0, width:buttonSize, height:buttonSize)
        
        // Offset each button's origin by the length of the button plus some spacing.
        for (index, button) in ratingButtons.enumerated(){
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        
        updateButtonSelectionStates()
    }
    
    //Mark Actions
    func ratingButtonTapped(_ button: UIButton){
        
        rating = ratingButtons.index(of: button)! + 1
        
        updateButtonSelectionStates()
        
    }
    
    func updateButtonSelectionStates() {
        
        for (index, button) in ratingButtons.enumerated() {
            
            button.isSelected = index < rating
        }

    }

}
