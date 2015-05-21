//
//  ViewController.swift
//  sliding-puzzle
//
//  Created by Justin Garcia on 3/12/15.
//  Copyright (c) 2015 jg. All rights reserved.
//

import UIKit

var numberOfRows = 3
var numberOfColumns = 3

let topMargin : CGFloat = 60.0
let distanceToControls : CGFloat = 40.0
let distanceToGameControls : CGFloat = 20.0

let landscapeControlsCenter : CGFloat = 516.0

class GameView : UIView {
    
    var containerView : UIView?
    var controller : GameViewController?
    
    override func layoutSubviews() {
        if UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft || UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight {
            
            self.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
            let middleView = self.controller!.middleView!
            middleView.frame = CGRectMake(0, 0, middleView.bounds.size.width, middleView.bounds.size.height)
            let showingTileNumbersButton = self.controller!.showingTitleNumbersButton!
            showingTileNumbersButton.frame = CGRectMake(landscapeControlsCenter - showingTileNumbersButton.bounds.size.width / 2.0, 100, showingTileNumbersButton.bounds.size.width, showingTileNumbersButton.bounds.size.height)
            let newGameButton = self.controller!.newGameButton!
            newGameButton.frame = CGRectMake(landscapeControlsCenter - newGameButton.bounds.size.width / 2.0, 100 + 20, newGameButton.bounds.size.width, newGameButton.bounds.size.height)
            let difficultySlider = self.controller!.difficultySlider!
            difficultySlider.frame = CGRectMake(landscapeControlsCenter - difficultySlider.bounds.size.width / 2.0, 100 + 40, difficultySlider.bounds.size.width, difficultySlider.bounds.size.height)
            let easyLabel = self.controller!.easyLabel!
            easyLabel.frame = CGRectMake(landscapeControlsCenter - difficultySlider.bounds.size.width / 2.0 - easyLabel.bounds.size.width, 100 + 44, easyLabel.bounds.size.width, easyLabel.bounds.size.height)
            let hardLabel = self.controller!.hardLabel!
            hardLabel.frame = CGRectMake(landscapeControlsCenter + difficultySlider.bounds.size.width / 2.0 + 4, 100 + 44, hardLabel.bounds.size.width, hardLabel.bounds.size.height)
            
            let prizeLabel = self.controller!.prizeLabel!
            prizeLabel.bounds = CGRectMake(0, 0, 200, 100)
            prizeLabel.numberOfLines = 3
            prizeLabel.frame = CGRectMake(landscapeControlsCenter - prizeLabel.bounds.size.width / 2.0, 100 + 72, 200, 100)
            
        } else {
            self.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
            self.controller!.middleView!.frame = CGRectMake(0, topMargin, self.controller!.middleView!.bounds.size.width, self.controller!.middleView!.bounds.size.height)
            
            let showingTileNumbersButton = self.controller!.showingTitleNumbersButton!
            showingTileNumbersButton.frame = CGRectMake(self.bounds.size.width / 2.0 - showingTileNumbersButton.titleLabel!.bounds.size.width / 2.0, topMargin + self.bounds.size.width + distanceToControls, showingTileNumbersButton.titleLabel!.bounds.size.width, showingTileNumbersButton.titleLabel!.bounds.size.height)
            let newGameButton = self.controller!.newGameButton!
            newGameButton.frame = CGRectMake(self.bounds.size.width / 2.0 - newGameButton.titleLabel!.bounds.size.width / 2.0, topMargin + self.bounds.size.width + distanceToControls + distanceToGameControls, newGameButton.titleLabel!.bounds.size.width, newGameButton.titleLabel!.bounds.size.height)
            let difficultySlider = self.controller!.difficultySlider!
            difficultySlider.frame = CGRectMake(self.bounds.size.width / 2.0 - difficultySlider.bounds.size.width / 2.0, topMargin + self.bounds.size.width + distanceToControls + distanceToGameControls + 24, difficultySlider.bounds.size.width, difficultySlider.bounds.size.height)
            let easyLabel = self.controller!.easyLabel!
            easyLabel.frame = CGRectMake(self.bounds.size.width / 2.0 - difficultySlider.bounds.size.width / 2.0 - easyLabel.bounds.size.width - 2, topMargin + self.bounds.size.width + distanceToControls + distanceToGameControls + 28, easyLabel.bounds.size.width, easyLabel.bounds.size.height)
            let hardLabel = self.controller!.hardLabel!
            hardLabel.frame = CGRectMake(self.bounds.size.width / 2.0 + difficultySlider.bounds.size.width / 2.0 + 8, topMargin + self.bounds.size.width + distanceToControls + distanceToGameControls + 28, easyLabel.bounds.size.width, easyLabel.bounds.size.height)
            let prizeLabel = self.controller!.prizeLabel!
            prizeLabel.bounds = CGRectMake(0, 0, self.bounds.size.width - 14, 40)
            prizeLabel.frame = CGRectMake(self.bounds.size.width / 2.0 - prizeLabel.bounds.size.width / 2.0, self.bounds.height - 66, prizeLabel.bounds.size.width - 14, 40)
        }
    }
}

class GameSquareView : UIImageView {
    var label: UILabel
    var value: Int?
    var empty: Bool {
        get {
            return self.empty
        }
        
        set(newEmpty) {
            if (newEmpty == true) {
                self.layer.borderWidth = 0.0
            } else {
                self.backgroundColor = UIColor.clearColor()
            }
        }
    }
    
    override init(image: UIImage!) {
        self.label = UILabel()
        super.init(image: image)
        self.empty = false
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 1.0
        self.addSubview(self.label)
    }
    
    required init(coder aDecoder: NSCoder) {
        self.label = UILabel()
        super.init(coder: aDecoder)
        self.empty = false
    }
    
    func setValue(value:Int) {
        self.value = value
        self.label.text = "\(value)"
        self.label.sizeToFit()
        self.label.frame = CGRectMake(self.bounds.size.width / 2.0 - self.label.bounds.size.width / 2.0, self.bounds.size.height / 2.0 - self.label.bounds.size.height / 2.0, self.label.bounds.size.width, self.label.bounds.size.height)
    }
}

class GameViewController: UIViewController {
    
    var matrix = Array<Array<GameSquareView>>()
    var emptySpot = (numberOfRows - 1, numberOfColumns - 1)
    var middleView : UIView?
    var showingTitleNumbers = false
    var showingTitleNumbersButton : UIButton?
    var newGameButton : UIButton?
    var difficultySlider : UISlider?
    var easyLabel : UILabel?
    var hardLabel : UILabel?
    var prizeLabel : UILabel?
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        let gameView = GameView()
        gameView.controller = self
        self.view = gameView
        self.view.backgroundColor = UIColor.whiteColor()
        
        startNewGame(self)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: "singleTap:")
        gestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(gestureRecognizer)
        
        var button = UIButton()
        button.setTitle("Show Tile Numbers", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        button.titleLabel!.font = UIFont.systemFontOfSize(14.0)
        button.titleLabel!.sizeToFit()
        button.frame = CGRectMake(self.view.bounds.size.width / 2.0 - button.titleLabel!.bounds.size.width / 2.0, topMargin + self.view.bounds.size.width + distanceToControls, button.titleLabel!.bounds.size.width, button.titleLabel!.bounds.size.height)
        button.addTarget(self, action: "toggleTitleNumbers:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        self.showingTitleNumbersButton = button
        
        self.newGameButton = UIButton()
        self.newGameButton!.setTitle("New Game", forState: UIControlState.Normal)
        self.newGameButton!.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.newGameButton!.titleLabel!.font = UIFont.systemFontOfSize(14.0)
        self.newGameButton!.sizeToFit()
        self.newGameButton!.frame = CGRectMake(self.view.bounds.size.width / 2.0 - newGameButton!.titleLabel!.bounds.size.width / 2.0, topMargin + self.view.bounds.size.width + distanceToControls + distanceToGameControls, newGameButton!.titleLabel!.bounds.size.width, newGameButton!.titleLabel!.bounds.size.height)
        self.newGameButton!.addTarget(self, action: "startNewGame:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.newGameButton!)
        
        self.difficultySlider = UISlider()
        self.difficultySlider!.frame = CGRectMake(self.view.bounds.size.width / 2.0 - self.difficultySlider!.bounds.size.width / 2.0, topMargin + self.view.bounds.size.width + distanceToControls + distanceToGameControls + 24, self.difficultySlider!.bounds.size.width, self.difficultySlider!.bounds.size.height)
        self.view.addSubview(self.difficultySlider!)
        self.difficultySlider!.addTarget(self, action: "sliderChanged:", forControlEvents: UIControlEvents.TouchCancel | UIControlEvents.TouchUpInside | UIControlEvents.TouchUpOutside)
        self.difficultySlider!.continuous = true
        
        self.easyLabel = UILabel()
        self.easyLabel!.text = "Easy"
        self.easyLabel!.sizeToFit()
        self.easyLabel!.font = UIFont.systemFontOfSize(14.0)
        self.easyLabel!.frame = CGRectMake(self.view.bounds.size.width / 2.0 - self.difficultySlider!.bounds.size.width / 2.0 - self.easyLabel!.bounds.size.width - 2, topMargin + self.view.bounds.size.width + distanceToControls + distanceToGameControls + 28, self.easyLabel!.bounds.size.width, self.easyLabel!.bounds.size.height)
        self.view.addSubview(self.easyLabel!)
        
        self.hardLabel = UILabel()
        self.hardLabel!.text = "Hard"
        self.hardLabel!.sizeToFit()
        self.hardLabel!.font = UIFont.systemFontOfSize(14.0)
        self.hardLabel!.frame = CGRectMake(self.view.bounds.size.width / 2.0 + self.difficultySlider!.bounds.size.width / 2.0 + 8, topMargin + self.view.bounds.size.width + distanceToControls + distanceToGameControls + 28, self.easyLabel!.bounds.size.width, self.easyLabel!.bounds.size.height)
        self.view.addSubview(self.hardLabel!)
    }
    
    func sliderChanged(sender:AnyObject!) {
        startNewGame(self)
    }
    
    func startNewGame(sender:AnyObject!) {
        
        let difficultyValue = self.difficultySlider == nil ? 0 : self.difficultySlider!.value
        var numberOfShuffles = 2
        
        if (difficultyValue > 0.4 && difficultyValue < 0.80) {
            numberOfRows = 4
            numberOfColumns = 4
            numberOfShuffles = 10 + Int((difficultyValue - 0.4) * 40 / 0.40)
        } else if difficultyValue >= 0.80 {
            numberOfRows = 5
            numberOfColumns = 5
            numberOfShuffles = 12 + Int((difficultyValue - 0.8) * 100 / 0.2)
        } else {
            numberOfRows = 3
            numberOfColumns = 3
            numberOfShuffles = 2 + Int(50 * difficultyValue / 0.4)
        }
        
        if (self.prizeLabel == nil) {
            self.prizeLabel = UILabel()
            self.prizeLabel!.text = "You win a $50 iTunes gift card if you beat the game on the hardest difficulty"
            self.prizeLabel!.textAlignment = NSTextAlignment.Center
            self.prizeLabel!.textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
            self.prizeLabel!.font = UIFont.systemFontOfSize(14.0)
            let size = self.prizeLabel!.sizeThatFits(CGSizeMake(self.view.bounds.size.width, 1000))
            self.prizeLabel!.lineBreakMode = NSLineBreakMode.ByWordWrapping
            self.prizeLabel!.numberOfLines = 2
            self.prizeLabel!.bounds = CGRectMake(0, 0, self.view.bounds.size.width - 14, 40)
            self.prizeLabel!.frame = CGRectMake(self.view.bounds.size.width / 2.0 - self.prizeLabel!.bounds.size.width / 2.0, self.view.bounds.height - 66, self.prizeLabel!.bounds.size.width - 14, 40)
            self.view.addSubview(self.prizeLabel!)
        }
        if NSUserDefaults.standardUserDefaults().valueForKey("com.sliding-puzzle.1.hard-win") != nil {
            if let prizeLabel = self.prizeLabel {
                prizeLabel.removeFromSuperview()
            }
            self.prizeLabel = UILabel()
            self.prizeLabel!.text = "Your iTunes Gift code is: XQYGHRLV4Q2ZVRGK"
            self.prizeLabel!.textAlignment = NSTextAlignment.Center
            self.prizeLabel!.textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
            self.prizeLabel!.font = UIFont.systemFontOfSize(14.0)
            let size = self.prizeLabel!.sizeThatFits(CGSizeMake(self.view.bounds.size.width, 1000))
            self.prizeLabel!.lineBreakMode = NSLineBreakMode.ByWordWrapping
            self.prizeLabel!.numberOfLines = 2
            self.prizeLabel!.bounds = CGRectMake(0, 0, self.view.bounds.size.width - 14, 40)
            self.prizeLabel!.frame = CGRectMake(self.view.bounds.size.width / 2.0 - self.prizeLabel!.bounds.size.width / 2.0, self.view.bounds.height - 66, self.prizeLabel!.bounds.size.width - 14, 40)
            self.view.addSubview(self.prizeLabel!)
        }
        
        for var x = 0; x < count(matrix); x++ {
            for var y = 0; y < count(matrix[x]); y++ {
                matrix[x][y].removeFromSuperview()
            }
        }
        
        matrix = Array<Array<GameSquareView>>()
        
        let random = arc4random() % 3 + 1
        let path = NSBundle.mainBundle().pathForResource("image-\(random)", ofType: "png")
        let image = UIImage(contentsOfFile: path!)
        let imageView = UIImageView(image: image)
        let landscape = UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft || UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight
        if landscape {
            imageView.bounds = CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.height)
            imageView.frame = CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.height)
        } else {
            imageView.bounds = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)
            imageView.frame = CGRectMake(0, 0 + topMargin, self.view.bounds.size.width, self.view.bounds.size.width)
        }
        
        self.view.addSubview(imageView)
        
        if middleView != nil {
            middleView!.removeFromSuperview()
        }
        self.middleView = UIView()
        self.middleView!.layer.borderColor = UIColor.blackColor().CGColor
        self.middleView!.layer.borderWidth = 1.0
        if  landscape {
            self.middleView!.frame = CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.height)
        } else {
            self.middleView!.frame = CGRectMake(0, topMargin, self.view.bounds.size.width, self.view.bounds.size.width)
        }
        
        self.view.addSubview(middleView!)
        
        let side = landscape ? self.view.bounds.size.height : self.view.bounds.size.width
        let width = side / CGFloat(numberOfColumns)
        let height = side / CGFloat(numberOfRows)
        
        for var i = 0; i < numberOfRows; i++ {
            
            var row = Array<GameSquareView>()
            
            for var j = 0; j < numberOfColumns; j++ {
                
                let w = image!.size.width / CGFloat(numberOfColumns)
                let h = image!.size.height / CGFloat(numberOfRows)
                let cgImage = CGImageCreateWithImageInRect(image!.CGImage, CGRectMake(CGFloat(j) * w, CGFloat(i) * h, w, h))
                let image = UIImage(CGImage: cgImage)
                let isEmpty = i == j && i == numberOfRows - 1
                let gameSquareView = GameSquareView(image: isEmpty ? nil : image)
                gameSquareView.frame = CGRectMake(CGFloat(j) * width + width / 2.0, CGFloat(i) * height + height / 2.0, 0, 0)
                UIView.animateWithDuration(0.2, animations: {
                    gameSquareView.frame = CGRectMake(CGFloat(j) * width, CGFloat(i) * height, width, height)
                })
                self.middleView!.addSubview(gameSquareView)
                gameSquareView.alpha = 0
                
                if isEmpty {
                    gameSquareView.empty = true
                } else {
                    gameSquareView.setValue(i * numberOfColumns + j)
                    gameSquareView.label.alpha = self.showingTitleNumbers ? 1 : 0
                }
                
                row.append(gameSquareView)
            }
            
            matrix.append(row)
        }
        
        imageView.removeFromSuperview()
        
        for var i = 0; i < numberOfRows; i++ {
            for var j = 0; j < numberOfColumns; j++ {
                UIView.animateWithDuration(0.2, animations: {
                    self.matrix[i][j].alpha = 1
                })
            }
        }
        
        emptySpot = (numberOfRows - 1, numberOfColumns - 1)
        
        while isFinished() == true {
            var position = randomAdjacentPosition(self.emptySpot.0, j: self.emptySpot.1)
            for var i = 0; i < numberOfShuffles; i++ {
                swapEmptyWithI(position.0, j:position.1)
                position = randomAdjacentPosition(position.0, j: position.1)
            }
        }
    }
    
    func toggleTitleNumbers(sender:AnyObject!) {
        
        var alpha = 1.0
        let button = self.showingTitleNumbersButton!
        
        if self.showingTitleNumbers {
            button.setTitle("Show Title Numbers", forState: UIControlState.Normal)
            button.titleLabel!.sizeToFit()
            button.frame = CGRectMake(self.view.bounds.size.width / 2.0 - button.titleLabel!.bounds.size.width / 2.0, topMargin + self.view.bounds.size.width + distanceToControls, button.titleLabel!.bounds.size.width, button.titleLabel!.bounds.size.height)
            self.showingTitleNumbers = false
            alpha = 0.0
        } else {
            button.setTitle("Hide Title Numbers", forState: UIControlState.Normal)
            button.titleLabel!.sizeToFit()
            button.frame = CGRectMake(self.view.bounds.size.width / 2.0 - button.titleLabel!.bounds.size.width / 2.0, topMargin + self.view.bounds.size.width + distanceToControls, button.titleLabel!.bounds.size.width, button.titleLabel!.bounds.size.height)
            self.showingTitleNumbers = true
        }
        
        for var i = 0; i < numberOfRows; i++ {
            for var j = 0; j < numberOfColumns; j++ {
                matrix[i][j].label.alpha = CGFloat(alpha)
            }
        }
        self.view.setNeedsDisplay()
    }
    
    func randomAdjacentPosition(i:Int, j:Int) -> (Int, Int) {
        let horizontal = arc4random() % 2
        if horizontal == 1 {
            let left = arc4random() % 2
            if left == 1 && i != 0 ||
                left == 0 && i == numberOfColumns - 1 {
                    return (i - 1, j)
            } else {
                return (i + 1, j)
            }
        } else {
            let up = arc4random() % 2
            if up == 1 && j != 0 ||
                up == 0 && j == numberOfRows - 1 {
                    return (i, j - 1)
            } else {
                return (i, j + 1)
            }
        }
    }
    
    func swapEmptyWithI(i:Int, j:Int) {
        
        let landscape = UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft || UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight
        let side = landscape ? self.view.bounds.size.height : self.view.bounds.size.width
        let width = side / CGFloat(numberOfColumns)
        let height = side / CGFloat(numberOfRows)
        let gameSquareView = self.matrix[i][j]
        let newJ = self.emptySpot.1
        let newI = self.emptySpot.0
        
        UIView.animateWithDuration(0.2, animations: {
            gameSquareView.frame = CGRectMake(CGFloat(newJ) * width, CGFloat(newI) * height, width, height)
        })
        
        let emptySpotView = matrix[newI][newJ]
        
        emptySpotView.alpha = 0.0
        
        UIView.animateWithDuration(0.2, delay: 0.12, options: UIViewAnimationOptions(0), animations: {
            emptySpotView.alpha = 1.0
            }, completion: nil)
        
        emptySpotView.frame = CGRectMake(CGFloat(j) * width, CGFloat(i) * height, width, height)
        matrix[newI][newJ] = gameSquareView
        matrix[i][j] = emptySpotView
        self.emptySpot = (i, j)
    }
    
    func isFinished() -> Bool {
        for var i = 0; i < numberOfRows; i++ {
            for var j = 0; j < numberOfColumns; j++ {
                if i == j && i == numberOfRows - 1 {
                    return true // empty square
                }
                let gameSquare = matrix[i][j]
                if gameSquare.value != i * numberOfColumns + j {
                    return false
                }
            }
        }
        return true
    }
    
    func singleTap(sender:AnyObject!) {
        let recognizer = sender as! UIGestureRecognizer
        let location = recognizer.locationInView(self.view)
        let landscape = UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft || UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight
        let side = landscape ? self.view.bounds.size.height : self.view.bounds.size.width
        let width = side / CGFloat(numberOfColumns)
        let height = side / CGFloat(numberOfRows)
        let top = landscape ? 0 : topMargin
        let j = Int(location.x / width)
        let i = Int((location.y - top) / height)
        
        if i >= numberOfRows || j >= numberOfColumns {
            return
        }
        if j == self.emptySpot.1 && (i == self.emptySpot.0 + 1 || i == self.emptySpot.0 - 1) ||
            i == self.emptySpot.0 && (j == self.emptySpot.1 + 1 || j == self.emptySpot.1 - 1) {
                swapEmptyWithI(i, j:j)
                if (isFinished()) {
                    let difficultyValue = self.difficultySlider == nil ? 0 : self.difficultySlider!.value
                    if difficultyValue == 1.0 {
                        NSUserDefaults.standardUserDefaults().setValue("true", forKey: "com.sliding-puzzle.1.hard-win")
                        let alert = UIAlertView(title: "Nice!", message: "Your iTunes Gift code is: XQYGHRLV4Q2ZVRGK", delegate: self, cancelButtonTitle: "OK")
                        alert.show()
                    } else {
                        let alert = UIAlertView(title: "Nice", message: "You won :).  Now try Hard!", delegate: self, cancelButtonTitle: "OK")
                        alert.show()
                    }
                }
        }
    }
    
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        startNewGame(self)
    }
}

