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
        if UIDevice.current().orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current().orientation == UIDeviceOrientation.landscapeRight {
            
            self.frame = CGRect(x: 0, y: 0, width: UIScreen.main().bounds.size.width, height: UIScreen.main().bounds.size.height)
            let middleView = self.controller!.middleView!
            middleView.frame = CGRect(x: 0, y: 0, width: middleView.bounds.size.width, height: middleView.bounds.size.height)
            let showingTileNumbersButton = self.controller!.showingTitleNumbersButton!
            showingTileNumbersButton.frame = CGRect(x: landscapeControlsCenter - showingTileNumbersButton.bounds.size.width / 2.0, y: 100, width: showingTileNumbersButton.bounds.size.width, height: showingTileNumbersButton.bounds.size.height)
            let newGameButton = self.controller!.newGameButton!
            newGameButton.frame = CGRect(x: landscapeControlsCenter - newGameButton.bounds.size.width / 2.0, y: 100 + 20, width: newGameButton.bounds.size.width, height: newGameButton.bounds.size.height)
            let difficultySlider = self.controller!.difficultySlider!
            difficultySlider.frame = CGRect(x: landscapeControlsCenter - difficultySlider.bounds.size.width / 2.0, y: 100 + 40, width: difficultySlider.bounds.size.width, height: difficultySlider.bounds.size.height)
            let easyLabel = self.controller!.easyLabel!
            easyLabel.frame = CGRect(x: landscapeControlsCenter - difficultySlider.bounds.size.width / 2.0 - easyLabel.bounds.size.width, y: 100 + 44, width: easyLabel.bounds.size.width, height: easyLabel.bounds.size.height)
            let hardLabel = self.controller!.hardLabel!
            hardLabel.frame = CGRect(x: landscapeControlsCenter + difficultySlider.bounds.size.width / 2.0 + 4, y: 100 + 44, width: hardLabel.bounds.size.width, height: hardLabel.bounds.size.height)
            
            let prizeLabel = self.controller!.prizeLabel!
            prizeLabel.bounds = CGRect(x: 0, y: 0, width: 200, height: 100)
            prizeLabel.numberOfLines = 3
            prizeLabel.frame = CGRect(x: landscapeControlsCenter - prizeLabel.bounds.size.width / 2.0, y: 100 + 72, width: 200, height: 100)
            
        } else {
            self.frame = CGRect(x: 0, y: 0, width: UIScreen.main().bounds.size.width, height: UIScreen.main().bounds.size.height)
            self.controller!.middleView!.frame = CGRect(x: 0, y: topMargin, width: self.controller!.middleView!.bounds.size.width, height: self.controller!.middleView!.bounds.size.height)
            
            let showingTileNumbersButton = self.controller!.showingTitleNumbersButton!
            showingTileNumbersButton.frame = CGRect(x: self.bounds.size.width / 2.0 - showingTileNumbersButton.titleLabel!.bounds.size.width / 2.0, y: topMargin + self.bounds.size.width + distanceToControls, width: showingTileNumbersButton.titleLabel!.bounds.size.width, height: showingTileNumbersButton.titleLabel!.bounds.size.height)
            let newGameButton = self.controller!.newGameButton!
            newGameButton.frame = CGRect(x: self.bounds.size.width / 2.0 - newGameButton.titleLabel!.bounds.size.width / 2.0, y: topMargin + self.bounds.size.width + distanceToControls + distanceToGameControls, width: newGameButton.titleLabel!.bounds.size.width, height: newGameButton.titleLabel!.bounds.size.height)
            let difficultySlider = self.controller!.difficultySlider!
            difficultySlider.frame = CGRect(x: self.bounds.size.width / 2.0 - difficultySlider.bounds.size.width / 2.0, y: topMargin + self.bounds.size.width + distanceToControls + distanceToGameControls + 24, width: difficultySlider.bounds.size.width, height: difficultySlider.bounds.size.height)
            let easyLabel = self.controller!.easyLabel!
            easyLabel.frame = CGRect(x: self.bounds.size.width / 2.0 - difficultySlider.bounds.size.width / 2.0 - easyLabel.bounds.size.width - 2, y: topMargin + self.bounds.size.width + distanceToControls + distanceToGameControls + 28, width: easyLabel.bounds.size.width, height: easyLabel.bounds.size.height)
            let hardLabel = self.controller!.hardLabel!
            hardLabel.frame = CGRect(x: self.bounds.size.width / 2.0 + difficultySlider.bounds.size.width / 2.0 + 8, y: topMargin + self.bounds.size.width + distanceToControls + distanceToGameControls + 28, width: easyLabel.bounds.size.width, height: easyLabel.bounds.size.height)
            let prizeLabel = self.controller!.prizeLabel!
            prizeLabel.bounds = CGRect(x: 0, y: 0, width: self.bounds.size.width - 14, height: 40)
            prizeLabel.frame = CGRect(x: self.bounds.size.width / 2.0 - prizeLabel.bounds.size.width / 2.0, y: self.bounds.height - 66, width: prizeLabel.bounds.size.width - 14, height: 40)
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
                self.backgroundColor = UIColor.clear()
            }
        }
    }
    
    override init(image: UIImage?) {
        self.label = UILabel()
        super.init(image: image)
        self.empty = false
        self.layer.borderColor = UIColor.black().cgColor
        self.layer.borderWidth = 1.0
        self.addSubview(self.label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.label = UILabel()
        super.init(coder: aDecoder)
        self.empty = false
    }
    
    func setValue(_ value:Int) {
        self.value = value
        self.label.text = "\(value)"
        self.label.sizeToFit()
        self.label.frame = CGRect(x: self.bounds.size.width / 2.0 - self.label.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0 - self.label.bounds.size.height / 2.0, width: self.label.bounds.size.width, height: self.label.bounds.size.height)
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
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        let gameView = GameView()
        gameView.controller = self
        self.view = gameView
        self.view.backgroundColor = UIColor.white()
        
        startNewGame(self)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GameViewController.singleTap(_:)))
        gestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(gestureRecognizer)
        
        let button = UIButton()
        button.setTitle("Show Tile Numbers", for: UIControlState())
        button.setTitleColor(UIColor.blue(), for: UIControlState())
        button.titleLabel!.font = UIFont.systemFont(ofSize: 14.0)
        button.titleLabel!.sizeToFit()
        button.frame = CGRect(x: self.view.bounds.size.width / 2.0 - button.titleLabel!.bounds.size.width / 2.0, y: topMargin + self.view.bounds.size.width + distanceToControls, width: button.titleLabel!.bounds.size.width, height: button.titleLabel!.bounds.size.height)
        button.addTarget(self, action: #selector(GameViewController.toggleTitleNumbers(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
        self.showingTitleNumbersButton = button
        
        self.newGameButton = UIButton()
        self.newGameButton!.setTitle("New Game", for: UIControlState())
        self.newGameButton!.setTitleColor(UIColor.blue(), for: UIControlState())
        self.newGameButton!.titleLabel!.font = UIFont.systemFont(ofSize: 14.0)
        self.newGameButton!.sizeToFit()
        self.newGameButton!.frame = CGRect(x: self.view.bounds.size.width / 2.0 - newGameButton!.titleLabel!.bounds.size.width / 2.0, y: topMargin + self.view.bounds.size.width + distanceToControls + distanceToGameControls, width: newGameButton!.titleLabel!.bounds.size.width, height: newGameButton!.titleLabel!.bounds.size.height)
        self.newGameButton!.addTarget(self, action: #selector(GameViewController.startNewGame(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(self.newGameButton!)
        
        self.difficultySlider = UISlider()
        self.difficultySlider!.frame = CGRect(x: self.view.bounds.size.width / 2.0 - self.difficultySlider!.bounds.size.width / 2.0, y: topMargin + self.view.bounds.size.width + distanceToControls + distanceToGameControls + 24, width: self.difficultySlider!.bounds.size.width, height: self.difficultySlider!.bounds.size.height)
        self.view.addSubview(self.difficultySlider!)
        self.difficultySlider!.addTarget(self, action: #selector(GameViewController.sliderChanged(_:)), for: [UIControlEvents.touchCancel, UIControlEvents.touchUpInside, UIControlEvents.touchUpOutside])
        self.difficultySlider!.isContinuous = true
        
        self.easyLabel = UILabel()
        self.easyLabel!.text = "Easy"
        self.easyLabel!.sizeToFit()
        self.easyLabel!.font = UIFont.systemFont(ofSize: 14.0)
        self.easyLabel!.frame = CGRect(x: self.view.bounds.size.width / 2.0 - self.difficultySlider!.bounds.size.width / 2.0 - self.easyLabel!.bounds.size.width - 2, y: topMargin + self.view.bounds.size.width + distanceToControls + distanceToGameControls + 28, width: self.easyLabel!.bounds.size.width, height: self.easyLabel!.bounds.size.height)
        self.view.addSubview(self.easyLabel!)
        
        self.hardLabel = UILabel()
        self.hardLabel!.text = "Hard"
        self.hardLabel!.sizeToFit()
        self.hardLabel!.font = UIFont.systemFont(ofSize: 14.0)
        self.hardLabel!.frame = CGRect(x: self.view.bounds.size.width / 2.0 + self.difficultySlider!.bounds.size.width / 2.0 + 8, y: topMargin + self.view.bounds.size.width + distanceToControls + distanceToGameControls + 28, width: self.easyLabel!.bounds.size.width, height: self.easyLabel!.bounds.size.height)
        self.view.addSubview(self.hardLabel!)
    }
    
    func sliderChanged(_ sender:AnyObject!) {
        startNewGame(self)
    }
    
    func startNewGame(_ sender:AnyObject!) {
        
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
            self.prizeLabel!.textAlignment = NSTextAlignment.center
            self.prizeLabel!.textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
            self.prizeLabel!.font = UIFont.systemFont(ofSize: 14.0)
            self.prizeLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
            self.prizeLabel!.numberOfLines = 2
            self.prizeLabel!.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.size.width - 14, height: 40)
            self.prizeLabel!.frame = CGRect(x: self.view.bounds.size.width / 2.0 - self.prizeLabel!.bounds.size.width / 2.0, y: self.view.bounds.height - 66, width: self.prizeLabel!.bounds.size.width - 14, height: 40)
            self.view.addSubview(self.prizeLabel!)
        }
        if UserDefaults.standard.value(forKey: "com.sliding-puzzle.1.hard-win") != nil {
            if let prizeLabel = self.prizeLabel {
                prizeLabel.removeFromSuperview()
            }
            self.prizeLabel = UILabel()
            self.prizeLabel!.text = "Your iTunes Gift code is: XQYGHRLV4Q2ZVRGK"
            self.prizeLabel!.textAlignment = NSTextAlignment.center
            self.prizeLabel!.textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
            self.prizeLabel!.font = UIFont.systemFont(ofSize: 14.0)
            self.prizeLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
            self.prizeLabel!.numberOfLines = 2
            self.prizeLabel!.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.size.width - 14, height: 40)
            self.prizeLabel!.frame = CGRect(x: self.view.bounds.size.width / 2.0 - self.prizeLabel!.bounds.size.width / 2.0, y: self.view.bounds.height - 66, width: self.prizeLabel!.bounds.size.width - 14, height: 40)
            self.view.addSubview(self.prizeLabel!)
        }
        
        for x in 0 ..< matrix.count {
            for y in 0 ..< matrix[x].count {
                matrix[x][y].removeFromSuperview()
            }
        }
        
        matrix = Array<Array<GameSquareView>>()
        
        let random = arc4random() % 3 + 1
        let path = Bundle.main.pathForResource("image-\(random)", ofType: "png")
        let image = UIImage(contentsOfFile: path!)
        let imageView = UIImageView(image: image)
        let landscape = UIDevice.current().orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current().orientation == UIDeviceOrientation.landscapeRight
        if landscape {
            imageView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.size.height, height: self.view.bounds.size.height)
            imageView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.height, height: self.view.bounds.size.height)
        } else {
            imageView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.width)
            imageView.frame = CGRect(x: 0, y: 0 + topMargin, width: self.view.bounds.size.width, height: self.view.bounds.size.width)
        }
        
        self.view.addSubview(imageView)
        
        if middleView != nil {
            middleView!.removeFromSuperview()
        }
        self.middleView = UIView()
        self.middleView!.layer.borderColor = UIColor.black().cgColor
        self.middleView!.layer.borderWidth = 1.0
        if  landscape {
            self.middleView!.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.height, height: self.view.bounds.size.height)
        } else {
            self.middleView!.frame = CGRect(x: 0, y: topMargin, width: self.view.bounds.size.width, height: self.view.bounds.size.width)
        }
        
        self.view.addSubview(middleView!)
        
        let side = landscape ? self.view.bounds.size.height : self.view.bounds.size.width
        let width = side / CGFloat(numberOfColumns)
        let height = side / CGFloat(numberOfRows)
        
        for i in 0 ..< numberOfRows {
            
            var row = Array<GameSquareView>()
            
            for j in 0 ..< numberOfColumns {
                
                let w = image!.size.width / CGFloat(numberOfColumns)
                let h = image!.size.height / CGFloat(numberOfRows)
                let cgImage = image!.cgImage?.cropping(to: CGRect(x: CGFloat(j) * w, y: CGFloat(i) * h, width: w, height: h))
                let image = UIImage(cgImage: cgImage!)
                let isEmpty = i == j && i == numberOfRows - 1
                let gameSquareView = GameSquareView(image: isEmpty ? nil : image)
                gameSquareView.frame = CGRect(x: CGFloat(j) * width + width / 2.0, y: CGFloat(i) * height + height / 2.0, width: 0, height: 0)
                UIView.animate(withDuration: 0.2, animations: {
                    gameSquareView.frame = CGRect(x: CGFloat(j) * width, y: CGFloat(i) * height, width: width, height: height)
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
        
        for i in 0 ..< numberOfRows {
            for j in 0 ..< numberOfColumns {
                UIView.animate(withDuration: 0.2, animations: {
                    self.matrix[i][j].alpha = 1
                })
            }
        }
        
        emptySpot = (numberOfRows - 1, numberOfColumns - 1)
        
        while isFinished() == true {
            var position = randomAdjacentPosition(self.emptySpot.0, j: self.emptySpot.1)
            for _ in 0 ..< numberOfShuffles {
                swapEmptyWithI(position.0, j:position.1)
                position = randomAdjacentPosition(position.0, j: position.1)
            }
        }
    }
    
    func toggleTitleNumbers(_ sender:AnyObject!) {
        
        var alpha = 1.0
        let button = self.showingTitleNumbersButton!
        
        if self.showingTitleNumbers {
            button.setTitle("Show Title Numbers", for: UIControlState())
            button.titleLabel!.sizeToFit()
            button.frame = CGRect(x: self.view.bounds.size.width / 2.0 - button.titleLabel!.bounds.size.width / 2.0, y: topMargin + self.view.bounds.size.width + distanceToControls, width: button.titleLabel!.bounds.size.width, height: button.titleLabel!.bounds.size.height)
            self.showingTitleNumbers = false
            alpha = 0.0
        } else {
            button.setTitle("Hide Title Numbers", for: UIControlState())
            button.titleLabel!.sizeToFit()
            button.frame = CGRect(x: self.view.bounds.size.width / 2.0 - button.titleLabel!.bounds.size.width / 2.0, y: topMargin + self.view.bounds.size.width + distanceToControls, width: button.titleLabel!.bounds.size.width, height: button.titleLabel!.bounds.size.height)
            self.showingTitleNumbers = true
        }
        
        for i in 0 ..< numberOfRows {
            for j in 0 ..< numberOfColumns {
                matrix[i][j].label.alpha = CGFloat(alpha)
            }
        }
        self.view.setNeedsDisplay()
    }
    
    func randomAdjacentPosition(_ i:Int, j:Int) -> (Int, Int) {
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
    
    func swapEmptyWithI(_ i:Int, j:Int) {
        
        let landscape = UIDevice.current().orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current().orientation == UIDeviceOrientation.landscapeRight
        let side = landscape ? self.view.bounds.size.height : self.view.bounds.size.width
        let width = side / CGFloat(numberOfColumns)
        let height = side / CGFloat(numberOfRows)
        let gameSquareView = self.matrix[i][j]
        let newJ = self.emptySpot.1
        let newI = self.emptySpot.0
        
        UIView.animate(withDuration: 0.2, animations: {
            gameSquareView.frame = CGRect(x: CGFloat(newJ) * width, y: CGFloat(newI) * height, width: width, height: height)
        })
        
        let emptySpotView = matrix[newI][newJ]
        
        emptySpotView.alpha = 0.0
        
        UIView.animate(withDuration: 0.2, delay: 0.12, options: UIViewAnimationOptions(rawValue: 0), animations: {
            emptySpotView.alpha = 1.0
            }, completion: nil)
        
        emptySpotView.frame = CGRect(x: CGFloat(j) * width, y: CGFloat(i) * height, width: width, height: height)
        matrix[newI][newJ] = gameSquareView
        matrix[i][j] = emptySpotView
        self.emptySpot = (i, j)
    }
    
    func isFinished() -> Bool {
        for i in 0 ..< numberOfRows {
            for j in 0 ..< numberOfColumns {
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
    
    func singleTap(_ sender:AnyObject!) {
        let recognizer = sender as! UIGestureRecognizer
        let location = recognizer.location(in: self.view)
        let landscape = UIDevice.current().orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current().orientation == UIDeviceOrientation.landscapeRight
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
                        UserDefaults.standard.setValue("true", forKey: "com.sliding-puzzle.1.hard-win")
                        let alert = UIAlertController(title: "Nice!", message: "Your iTunes Gift code is: XQYGHRLV4Q2ZVRGK", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                            self.startNewGame(self)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        let alert = UIAlertController(title: "Nice", message: "You won :).  Now try Hard!", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                            self.startNewGame(self)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
        }
    }
}

