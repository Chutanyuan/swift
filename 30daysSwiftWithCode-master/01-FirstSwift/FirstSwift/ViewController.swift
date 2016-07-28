//
//  ViewController.swift
//  FirstSwift
//
//  Created by 冯志浩 on 16/6/15.
//  Copyright © 2016年 FZH. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let SCREENWIDTH = UIScreen.mainScreen().bounds.size.width
    let SCREENHEIGHT = UIScreen.mainScreen().bounds.size.height
    
    //定义属性
    var Counter = 0.0
    var Timer = NSTimer()
    var IsPlaying = false
    
    let timeLabel = UILabel(frame:CGRectZero)
    let pauseBtn:UIButton = UIButton(type: .Custom)
    let resetBtn:UIButton = UIButton(type: .Custom)
    let playBtn:UIButton = UIButton(type: .Custom)
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //0.创建label
        self.setupLabel()
        //1.创建按钮
        self.setupBtn()
        let button = UIButton.init(type: .Custom)
        button.frame = CGRectMake(100, 100, 100, 100)
        button.backgroundColor = UIColor.redColor()
        button.titleLabel?.text = "zheshigeSha"
        self.view .addSubview(button)
        
        let tableview = UITableView.init(frame: CGRectMake(0, 200, SCREENWIDTH, SCREENHEIGHT-200), style: .Grouped)
        tableview.delegate = self
        tableview.dataSource = self
        
        self.view .addSubview(tableview)
        
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let testcell = UITableViewCell.init(style: .Default, reuseIdentifier: "testCell");
        testcell.textLabel?.text = "haque"
        return testcell
    }
    func setupLabel () {
        timeLabel.frame = CGRectMake(20, 80, SCREENWIDTH - 40, SCREENHEIGHT * 0.1)
        timeLabel.text = String(Counter)
        self.view.addSubview(timeLabel)
    }
    
    func setupBtn() {
        //1.暂停按钮
        pauseBtn.frame = CGRectMake((SCREENWIDTH - 200)/3 * 2 + 100, SCREENHEIGHT * 0.3, 100, 100)
        pauseBtn.addTarget(self, action: #selector(ViewController.pause(_:)), forControlEvents: .TouchUpInside)
        pauseBtn.setImage(UIImage(named: "pause"), forState: .Normal)

        self.view.addSubview(pauseBtn)
        
        //2开始按钮
        playBtn.frame = CGRectMake((SCREENWIDTH - 200)/3, SCREENHEIGHT * 0.3, 100, 100)
        playBtn.setImage(UIImage(named: "play"), forState: .Normal)
        playBtn.addTarget(self, action: #selector(ViewController.play(_:)), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(playBtn)
        //3.重置按钮
        resetBtn.frame = CGRectMake(SCREENWIDTH * 0.8, 20, 50, 40)
        resetBtn.setTitle("reset", forState: .Normal)
        resetBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        resetBtn.layer.cornerRadius = 5.0
        resetBtn.backgroundColor = UIColor.blackColor()
        resetBtn.addTarget(self, action: #selector(ViewController.reset(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(resetBtn)
    }
    
    func pause(btn:UIButton) {
        
        playBtn.enabled = true
        pauseBtn.enabled = false
        Timer.invalidate()
        IsPlaying = false
    }
    
    func play(btn:UIButton) {
        
        if IsPlaying {
            return
        }
        playBtn.enabled = false
        pauseBtn.enabled = true
        Timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ViewController.UpdateTimer), userInfo: nil, repeats: true)
        IsPlaying = true
    }
    
    func reset(btn:UIButton) {
        
        Timer.invalidate()
        IsPlaying = false
        Counter = 0
        timeLabel.text = String(Counter)
        playBtn.enabled = true
        pauseBtn.enabled = true
    }
    
    func UpdateTimer() {
        Counter = Counter + 0.1
        timeLabel.text = String(format: "%.1f",Counter)
    }
    
}

