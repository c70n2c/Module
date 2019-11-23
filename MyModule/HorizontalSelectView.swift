//
//  HorizontalSelectView.swift
//  HorizontalSelectView
//
//  Created by Chancc on 2019/9/5.
//  Copyright © 2019 Chancc. All rights reserved.
//
//@IBAction func didClick(_ sender: UIButton) {
//    
//    if sender.isSelected {
//        selectView.dataSource = ["9:00", "9:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00", "16:30",  "17:00", "17:30"]
//        selectView.type = .hour
//    } else {
//        selectView.dataSource = ["15:00", "16:00", "17:00", "18:00",  "19:00", "20:00", "15:00", "16:00", "17:00", "18:00",  "19:00", "20:00"]
//        selectView.type = .day
//    }
//    selectView.resetPanView()
//    selectView.setNeedsLayout()
//    sender.isSelected = !sender.isSelected
//}
//}


import UIKit

enum stytle {
    case hour
    case day
}

class DrawView: UIView {
    
    private var titleHeight: CGFloat = 30.0
    private var cellHeight: CGFloat = 44.0
    
    public var cellWidth: CGFloat = 44.0
    
    public var type: stytle = .hour
    
    public var dataSource: [String]? {
        willSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    private func initView() {
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawView()
    }
    
    private func drawView() {
        
        let context = UIGraphicsGetCurrentContext()
        // 垂直线（Vertical Line）
        for (index, _) in dataSource?.enumerated() ?? [].enumerated() {
            switch type {
            case .hour:
                (index % 2 == 0) ? (context?.move(to: CGPoint(x: CGFloat(index) * cellWidth, y: 0))) : (context?.move(to: CGPoint(x: CGFloat(index) * cellWidth, y: titleHeight)))
                context?.addLine(to: CGPoint(x:CGFloat(index) * cellWidth, y: bounds.size.height))
            case .day:
                context?.move(to: CGPoint(x: CGFloat(index) * cellWidth, y: 0))
                context?.addLine(to: CGPoint(x:CGFloat(index) * cellWidth, y: bounds.size.height))
            }
            
            if index % 2 == 0  {
                // 画占位灰色格子
                context?.move(to: CGPoint(x: cellWidth * CGFloat(index), y: titleHeight))
                context?.addLine(to: CGPoint(x: cellWidth * CGFloat(index + 1), y: titleHeight))
                context?.addLine(to: CGPoint(x: cellWidth * CGFloat(index + 1), y: bounds.size.height))
                context?.addLine(to: CGPoint(x: cellWidth * CGFloat(index), y: bounds.size.height))
            }
        }
        // 垂直线（Vertical Line）结尾最后
        context?.move(to: CGPoint(x: CGFloat(dataSource?.count ?? 0) * cellWidth, y: 0))
        context?.addLine(to: CGPoint(x:CGFloat(dataSource?.count ?? 0) * cellWidth, y: bounds.size.height))
        
        //水平线（Horizontal Line）Top
        context?.move(to: CGPoint(x: 0, y: titleHeight))
        context?.addLine(to: CGPoint(x: bounds.size.width, y: titleHeight))
        //水平线（Horizontal Line）Bottom
        context?.move(to: CGPoint(x: 0, y: bounds.size.height - 0.5))
        context?.addLine(to: CGPoint(x: bounds.size.width, y: bounds.size.height - 0.5))
        
        context?.closePath()
        UIColor(red: 190/255.0, green: 194/255.0, blue: 210/255.0, alpha: 1.0).setStroke()
        UIColor(red: 233/255.0, green: 233/255.0, blue: 239/255.0, alpha: 1.0).setFill()
        context?.setLineWidth(0.5)
        context?.drawPath(using: .fillStroke)
        
        
        // 画文字
        context?.textMatrix = CGAffineTransform.identity
        for (index, title) in dataSource?.enumerated() ?? [].enumerated() {
            if index == 0 {
                context?.translateBy(x: 8, y: bounds.size.height + 2)
                context?.scaleBy(x: 1.0, y: -1.0)
            } else {
                context?.translateBy(x: cellWidth, y: 0)
                context?.scaleBy(x: 1.0, y: 1.0)
            }
            
            // 创建绘制区域
            let path = CGMutablePath()
            path.addRect(bounds)
            // 需要绘制的文字与计算需要绘制的区域 字体颜色
            var resetTitle = title
            if index % 2 != 0, type == .hour  { resetTitle = "" }
            
            
            let attributedString = NSMutableAttributedString(string: resetTitle)
            attributedString.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0), NSAttributedString.Key.foregroundColor: UIColor.black], range: NSMakeRange(0, attributedString.length))
            // 根据AttributedString生成CTFramesetterRef
            let frameSetter = CTFramesetterCreateWithAttributedString(attributedString)
            let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, attributedString.length), path, nil)
            // 进行绘制
            CTFrameDraw(frame, context!)
        }
    }
}

class HorizontalSelectView: UIView {
    
    var titleHeight: CGFloat = 30.0
    var cellHeight: CGFloat = 44.0
    var cellWidth: CGFloat = 0
    
    var type: stytle = .day
    
    var dataSource: [String] = []
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
//        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = false
        scrollView.delegate = self
        scrollView.contentOffset = CGPoint()
        return scrollView
    }()
    
    // 底部绘画视图，显示数据
    public lazy var drawView: DrawView = {
        let drawView = DrawView()
        return drawView
    }()
    
    // 滑块视图
    private var sliderWidth: CGFloat = 0
    private lazy var sliderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 90/255.0, green: 119/255.0, blue: 251/255.0, alpha: 1.0)
        return view
    }()
    // 滑块右侧img
    private lazy var sliderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "conference_right")
        imageView.contentMode = .center
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    private func initView() {
        addSubview(scrollView)
        scrollView.addSubview(drawView)
        
        // 绘画视图添加点击手势
        let drawTap = UITapGestureRecognizer(target: self, action: #selector(drawTap(_:)))
        drawView.addGestureRecognizer(drawTap)
        // 滑块 视图整体拖动手势
        let sliderPanAll = UIPanGestureRecognizer(target: self, action: #selector(sliderPanAll(_:)))
        sliderView.addGestureRecognizer(sliderPanAll)
        // 滑块 视图img拖动手势
        let sliderPanImg = UIPanGestureRecognizer(target: self, action: #selector(sliderPanImg(_:)))
        sliderImageView.addGestureRecognizer(sliderPanImg)
        // 重置
        resetPanView()
        drawView.addSubview(sliderView)
        drawView.addSubview(sliderImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch type {
        case .hour:
            cellWidth = 44.0
        case .day:
            cellWidth = 70.0
        }
        drawView.dataSource = dataSource
        drawView.type = type
        drawView.cellWidth = cellWidth
        drawView.frame = CGRect(x: 0, y: 0, width: CGFloat(dataSource.count) * cellWidth, height: bounds.size.height)
        scrollView.contentSize = CGSize(width: CGFloat(dataSource.count) * cellWidth, height: bounds.size.height)
        scrollView.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
    }
}

// 手势处理
extension HorizontalSelectView {
    
    // 重置按钮
    func resetPanView() {
        sliderWidth = 0
        sliderView.frame = CGRect(x: 0, y: titleHeight, width: sliderWidth, height: cellHeight)
        sliderImageView.frame = CGRect.zero
    }
    
    // 绘画视图 点击手势 事件
    @objc func drawTap(_ tap: UITapGestureRecognizer) {
        let point = tap.location(in: scrollView)
        let index = Int(point.x / cellWidth)
        sliderWidth = cellWidth
        sliderView.bounds.size.width = sliderWidth
        sliderView.frame.origin.x = CGFloat(index) * cellWidth
        sliderImageView.frame = CGRect(x: sliderView.frame.origin.x + sliderWidth - 12.0, y: titleHeight, width: 24.0, height: cellHeight)
    }
    
    // 滑块 视图整体拖动手势
    @objc func sliderPanAll(_ pan: UIPanGestureRecognizer) {
        let point = pan.translation(in: sliderView)
        switch pan.state {
        case .began:
            break
        case .changed:
            pan.view?.center = CGPoint(x: (pan.view?.center.x)! + point.x, y: (pan.view?.center.y)!)
            pan.setTranslation(.zero, in: sliderView)
            sliderImageView.frame = CGRect(x: sliderView.frame.maxX - 12.0, y: titleHeight, width: 24.0, height: cellHeight)
        case .ended:
            print(sliderView.frame.maxX)
            break
        default: break
        }
        
    }
    // 滑块 视图img拖动手势
    @objc func sliderPanImg(_ pan: UIPanGestureRecognizer) {
        let sliderView_x = sliderView.frame.origin.x
        let point = pan.translation(in: sliderImageView)
        switch pan.state {
        case .began:
            break
        case .changed:
            pan.view?.center = CGPoint(x: (pan.view?.center.x)! + point.x, y: (pan.view?.center.y)!)
            pan.setTranslation(.zero, in: sliderImageView)
            sliderView.bounds.size.width += point.x
            sliderView.frame.origin.x = sliderView_x
        case .ended:
            sliderImageView.frame = CGRect(x: sliderView.frame.maxX - 12.0, y: titleHeight, width: 24.0, height: cellHeight)
            break
        default: break
        }
    }
}

// 代理处理
extension HorizontalSelectView: UIScrollViewDelegate {
    
}
