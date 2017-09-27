//
//  UIExtension.swift
//  Pigs have spread
//
//  Created by 周逸文 on 17/2/13.
//  Copyright © 2017年 Devil. All rights reserved.
//

import Foundation
import UIKit



/*
 1.创建便利构造函数
 2.使用面向协议编程
 3.UITextField 封装一个监听方法
 4.使用map函数代替for
 */


let YV_BC =  RGB(174, G: 153, B: 90)
extension UIButton{
    
    //MARK:  convenience 的初始化方法是不能被子类重写或者是从子类中以 super 的方式被调用的
    /// 创建 UIButton
    ///
    /// - parameter nt:      normal title
    /// - parameter ts:      fontSize，默认 14
    /// - parameter ntc:     normal color，默认 darkGray
    /// - parameter nn:      normal imageNamed
    ///
    /// - returns: UIButton
    convenience init(yv_nt nt: String? = nil,
                     ntc: UIColor? = RGBSingle(176),
                     nn: String? = nil,
                     st: String? = nil,
                     stc: UIColor? = RGBSingle(115),
                     sn: String? = nil,
                     ts: CGFloat? = nil,
                     bts: CGFloat? = nil,
                     rd: CGFloat = 0,
                     bc: UIColor? = nil,
                     bdc: CGColor? = nil,
                     bdw: CGFloat? = 0) {
        self.init()
        if nn != nil {self.setImage(UIImage(named: nn!), for: .normal)}
        self.setTitle(nt, for: .normal)
        self.setTitleColor(ntc, for: .normal)
        
        if sn != nil {self.setImage(UIImage(named: sn!), for: .selected)}
        self.setTitle(st, for: .selected)
        self.setTitleColor(stc, for: .selected)
        if ts != nil {
            self.titleLabel?.font = UIFont.systemFont(ofSize: ts!)
        }
        
        if bts != nil {
            self.titleLabel?.font = UIFont.boldSystemFont(ofSize: bts!)
        }
        
        self.backgroundColor = bc
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.layer.cornerRadius = rd
        self.layer.masksToBounds = true
        self.layer.borderColor = bdc
        if bdw != nil {
            self.layer.borderWidth = bdw!
        }
        // 自动调整大小
        sizeToFit()
    }
}
extension UILabel{
    /// 创建 UILabel
    ///
    /// - parameter lt:      text
    /// - parameter ts:  fontSize，默认 14
    /// - parameter ltc:     color，默认 darkGray
    /// - parameter alg: alignment，默认左对齐
    ///
    /// - returns: UILabel
    convenience init(yv_lt lt: String = "labeltitle",
                     ltc: UIColor = UIColor.darkGray,
                     ts: CGFloat? = nil,
                     bts: CGFloat? = nil,
                     alg: NSTextAlignment = .left, isToFit: Bool? = nil) {
        self.init()
        self.text = lt
        self.textColor = ltc
        self.textAlignment = alg
        if ts != nil {
           self.font = UIFont.systemFont(ofSize: ts!)
        }
        if bts != nil {
            self.font = UIFont.boldSystemFont(ofSize: bts!)
        }
        
        if isToFit != nil {
            self.numberOfLines = 0
            // 自动调整大小
            sizeToFit()
        }
    }
}

extension UIImageView{
    convenience init(yv_named named: String,
                     rd: CGFloat = 0,
                     bc: UIColor? = nil,
                     bdc: CGColor? = nil,
                     bdw: CGFloat? = nil) {
        self.init()
        self.image = UIImage(named: named)
        self.backgroundColor = bc
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.layer.cornerRadius = rd
        self.layer.masksToBounds = true
        self.layer.borderColor = bdc
        self.layer.borderWidth = bdw == nil ? 0 : bdw!
        self.clipsToBounds = true
        
    }

}


extension UITextField {
    convenience init(yv_pl pl: String = "Placeholder",
                     plc: UIColor = UIColor.red,
                     tc: UIColor = UIColor.darkGray,
                     kt:UIKeyboardType = .default  ,
                     ts: CGFloat = 14,
                     alg: NSTextAlignment = .left,
                     bc: UIColor = RGB(33, G: 176, B: 89),
                     rd: CGFloat = 0){
        self.init()
        
        self.attributedPlaceholder = NSAttributedString(string: pl, attributes: [
            NSForegroundColorAttributeName: plc as Any,
            NSFontAttributeName : UIFont.systemFont(ofSize: ts)
            ])
        self.keyboardType = kt
        self.textAlignment = alg
        self.textColor = tc
        self.backgroundColor = bc
        self.layer.cornerRadius = rd
        self.layer.masksToBounds = true
        
    }
}
extension UITextView {
    convenience init(yv_pl pl: String = "Placeholder",
                     plc: UIColor = UIColor.red,
                     tc: UIColor = UIColor.darkGray,
                     kt:UIKeyboardType = .default  ,
                     ts: CGFloat = 14,
                     alg: NSTextAlignment = .left,
                     bc: UIColor = RGB(33, G: 176, B: 89),
                     rd: CGFloat = 0){
        self.init()
        
        self.text = pl
        self.keyboardType = kt
        self.textAlignment = alg
        self.textColor = tc
        self.backgroundColor = bc
        self.layer.cornerRadius = rd
        self.layer.masksToBounds = true
    }
}

let HomeSubviewHeight = ScreenHeight - 64 - 49

extension UIScrollView {

    convenience init(yv_bc bc: UIColor =  RGB(33, G: 176, B: 89),
                     any: Any,
                     isP: Bool = false,cs: CGSize = CGSize(width: ScreenWidth * 3,height: HomeSubviewHeight)) {
        self.init()
        self.backgroundColor = bc
        self.delegate = any as? UIScrollViewDelegate
        self.isPagingEnabled = isP
        self.scrollsToTop = false
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.contentSize = cs
        
    }
}
extension UITableView{
    
    convenience init(yv_bc bc: UIColor = RGB(33, G: 176, B: 89),
                     any: Any,
                     rh: CGFloat = 50,tabstyle: UITableViewStyle = .plain,style: UITableViewCellSeparatorStyle = .singleLine) {
        self.init(frame: CGRect.zero, style: tabstyle)
        self.separatorStyle = style
        self.backgroundColor = bc
//        self.tableHeaderView = UIView(frame: CGRect.zero)
        self.rowHeight = rh
        self.delegate = any as? UITableViewDelegate
        self.dataSource = any as? UITableViewDataSource
        
    }
    
}
extension UICollectionView{
    
    convenience init(yv_bc bc: UIColor =  RGB(33, G: 176, B: 89),
                     any: Any,
                     isP: Bool = false,layout: UICollectionViewLayout) {
        
        self.init(frame: CGRect.zero, collectionViewLayout: layout)
        self.backgroundColor = bc
        self.dataSource = any as? UICollectionViewDataSource
        self.delegate = any as? UICollectionViewDelegate
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.isPagingEnabled = isP
        
    }
    
}

extension UICollectionViewFlowLayout{
    
    convenience init(yv_si si: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
                     sd: UICollectionViewScrollDirection? = nil,
                     mls: CGFloat = 0,
                     mis: CGFloat = 0,
                     ise: CGSize = CGSize(width: 50, height: 50) ) {
        self.init()
        self.sectionInset = si
        self.scrollDirection = sd == nil ? .horizontal : sd!
        self.minimumLineSpacing = mls
        self.minimumInteritemSpacing = mis
        self.itemSize = ise
    }
}
extension Date {
    func differenceDate(beforeD: Date)-> String {
        let diffeT: TimeInterval = self.timeIntervalSince(beforeD)
//        let timeStr = String(format: "%02d:%02d:%02d", (diffeT)/3600, ((diffeT)%3600)/60,  (diffeT)%60)
//        totalTimeLabel.text = timeStr
        let aa: Int = Int(diffeT)
        print("\(aa)")
        return "\((aa)/3600):\(((aa)%3600)/60):\((aa)%60)"
    }
    func differenceDateInt(beforeD: Date)-> Int {
        let diffeT: TimeInterval = self.timeIntervalSince(beforeD)
        //        let timeStr = String(format: "%02d:%02d:%02d", (diffeT)/3600, ((diffeT)%3600)/60,  (diffeT)%60)
        //        totalTimeLabel.text = timeStr
        let aa: Int = Int(diffeT)
    return aa
    }


}
//数组倒序
extension Array {
    func reverseOrder()-> Array {
        
        var newArray = Array<Element>()
        
        for item in self.reversed() {
            newArray.append(item)
        }
        
        
        return newArray 
    }

}
//extension Date {
//    /// "yyyy-MM-dd'T'HH:mm:ss"
//    static var UTCDate: String {
//        get {
//            let date = Date()
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//            return formatter.string(from: date)
//        }
//    }
//    static var UTCDateNo: String {
//        get {
//            let date = Date()
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy-MM-dd"
//            return formatter.string(from: date)
//        }
//    }
//    static var UTCDateZZ: String {
//        get {
//            let date = Date()
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
//            return formatter.string(from: date)
//        }
//    }
//    static var YearMonth: String {
//        get {
//            let date = Date()
//            let formatter = DateFormatter()
//            formatter.dateFormat = "YYYY/MM"
//            return formatter.string(from: date)
//        }
//    }
//    static var MonthDayr: String {
//        get {
//            let date = Date()
//            let formatter = DateFormatter()
//            formatter.dateFormat = "MM/dd"
//            return formatter.string(from: date)
//        }
//    }
//    static func dateFromUTCstring(_ utc: String) -> Date? {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//        let date = formatter.date(from: utc)
//        return date
//    }
//}
extension UINavigationController {
    //来回push防止底部工具栏出现
    func pushVCHT(_ vc: UIViewController) {
        vc.hidesBottomBarWhenPushed = true
        pushViewController(vc, animated: true)
    }
}
extension UIView {
    convenience init(yv_bc: UIColor? = nil) {
        self.init()
        self.backgroundColor = yv_bc
    }
    func addSubviews(_ views: Array<UIView>) {
        _ = views.map{addSubview($0)}
    }
    func isHiddenSubviews(_ views: Array<UIView>,ishidden: Bool) {
        _ = views.map{$0.isHidden = ishidden}
    }
    
    func yv_viewToImage() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result!
        
    }
}
extension UIImage {

    //裁剪图片
    func yv_cropImage(rect: CGRect) -> UIImage {
        
        let sourceImageRef = self.cgImage
        let newImageRef = sourceImageRef!.cropping(to: rect)
        
        let newImage = UIImage(cgImage: newImageRef!)
        return newImage
    }
    
    /// 异步绘制图像
    func yv_asyncDrawImage(rect: CGRect,
                           isCorner: Bool = false,
                           backColor: UIColor? = UIColor.white,
                           finished: @escaping (_ image: UIImage)->()) {
        
        // 异步绘制图像，可以在子线程进行，因为没有更新 UI
        
         DispatchQueue.global().async {
            
            // 如果指定了背景颜色，就不透明
            UIGraphicsBeginImageContextWithOptions(rect.size, backColor != nil, 1)
            
            let rect = rect
            
            if backColor != nil{
                // 设置填充颜色
                backColor?.setFill()
                UIRectFill(rect)
            }
            
            // 设置圆角 - 使用路径裁切，注意：写设置裁切路径，再绘制图像
            if isCorner {
                let path = UIBezierPath(ovalIn: rect)
                
                // 添加裁切路径 - 后续的绘制，都会被此路径裁切掉
                path.addClip()
            }
            
            // 绘制图像
            self.draw(in: rect)
            
            let result = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            // 主线程更新 UI，提示：有的时候异步也能更新 UI，但是会非常慢！
            
            DispatchQueue.main.async {
                finished(result!)
            }
        }
    }
}

extension UIView{
   
    func yvDrawStaticCircle() {
        ///绘制静态圆
        let  StaticCayer = CAShapeLayer()
        StaticCayer.lineWidth = 2
        
        StaticCayer.strokeColor = RGBA(58, G: 193, B: 126, A: 1).cgColor
        
        StaticCayer.fillColor =  UIColor.clear.cgColor
        
        let Staticcenter = CGPoint(x: self.frame.size.width/2, y:  self.frame.size.height/2)
        let Staticradius: CGFloat = 15
        let StaticstartA = CGFloat(0)
        let StaticendA = CGFloat(Double.pi/2 * 4)
        
        let Staticpath = UIBezierPath(arcCenter: Staticcenter, radius: Staticradius, startAngle: StaticstartA, endAngle: StaticendA, clockwise: true)
        
        StaticCayer.path = Staticpath.cgPath
        self.layer.addSublayer(StaticCayer)
        
        let DynamicCayer = CAShapeLayer()
        
        //        DynamicCayer.frame = CGRect(x: 0 , y: 0, width: ProgressWH, height: ProgressWH)
        DynamicCayer.lineWidth = 1.5
        
        DynamicCayer.strokeColor = RGBA(58, G: 193, B: 126, A: 1).cgColor
        
        DynamicCayer.fillColor = UIColor.clear.cgColor
        
        let center = CGPoint(x: self.frame.size.width/2, y:  self.frame.size.height/2)
        
        let radius: CGFloat = 15 - 1.5
        let startA = CGFloat(0)
        let endA = CGFloat(Double.pi/2 * 4)
        
        
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startA, endAngle: endA, clockwise: true)
        
        DynamicCayer.path = path.cgPath
        
        self.layer.addSublayer(DynamicCayer)
        DynamicCayer.strokeEnd = 0
        
    }
    func yvDrawDynamicCircle(progress: Float) {
        (self.layer.sublayers?.last as? CAShapeLayer)?.strokeEnd = CGFloat(progress)
    }
}


public extension NSObject{
    
    //获取类名
    public class var nameOfClass: String{
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    public var nameOfClass: String{
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
}
extension Float{
    //秒-> xx:xx
    func getMMSSFromSS() -> String {
        
        let fl_minute: Float =  self/60
        
        let fl_second: Float = self.truncatingRemainder(dividingBy: 60)
        
        let str_second =  String(format: "%02d", Int(fl_second))
        
        let format_time = "\(Int(fl_minute)):\(str_second)"
        
        return format_time
    }
}

//MARK: 关于 UITABLEVIEW====================
protocol NibLoadableView: class { }

extension NibLoadableView where Self: UIView {
    
    static var NibName: String {
        return String(describing: self)
    }
}

//MARK: 关键字class=此协议针对类
protocol ReusableView: class {}
//MARK: where = self 和 UIView 的联系，这里的self指具体的cell
extension ReusableView where Self: UIView {
    
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
extension UITableViewCell: ReusableView {}

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
        
    }
    //    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
    //
    //        let Nib = UINib(nibName: T.NibName, bundle: nil)
    //        register(Nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    //    }
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
}

extension UICollectionViewCell: ReusableView {}

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
        
        
    }
    //    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
    //
    //        let Nib = UINib(nibName: T.NibName, bundle: nil)
    //        register(Nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    //    }
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
}
extension String{
//
//    + (NSString *)getBinaryByDecimal:(NSInteger)decimal {
//    
//    NSString *binary = @"";
//    while (decimal) {
//    
//    binary = [[NSString stringWithFormat:@"%ld", decimal % 2] stringByAppendingString:binary];
//    if (decimal / 2 < 1) {
//    
//    break;
//    }
//    decimal = decimal / 2 ;
//    }
//    if (binary.length % 4 != 0) {
//    
//    NSMutableString *mStr = [[NSMutableString alloc]init];;
//    for (int i = 0; i < 4 - binary.length % 4; i++) {
//    
//    [mStr appendString:@"0"];
//    }
//    binary = [mStr stringByAppendingString:binary];
//    }
//    return binary;
//    }

    mutating func getBinaryByDecimal() -> String {
        var binary: String = ""
        var strInt = Int(self)!
        
        while true {
            binary = String.init(format: "%ld", strInt % 2).appending(binary)
            
            if (strInt / 2 < 1) {
                break
            }
            strInt = strInt / 2
        }
        if (binary.characters.count % 4 != 0) {
            var mStr = ""
            
            for _ in 0 ..<  (4 - binary.characters.count % 4) {
                mStr += "0"
            }
            binary = mStr.appending(binary)
        }
        
        return binary
    }
    func getDecimalByBinary()-> String {
        
        var ll = 0
         var temp = 0
    
        for i in 0 ..< self.characters.count {
            temp = Int((self as NSString).substring(with: NSMakeRange(i,1)))!
            temp = temp * Int(powf(2, Float(self.characters.count-i-1)))
            ll += temp
        }
        let result = String.init(format: "%d", ll)
        return  result
        
    }
//    
//    + (NSString *)toDecimalSystemWithBinarySystem:(NSString *)binary
//    {
//    int ll = 0 ;
//    int  temp = 0 ;
//    for (int i = 0; i < binary.length; i ++)
//    {
//    temp = [[binary substringWithRange:NSMakeRange(i, 1)] intValue];
//    temp = temp * powf(2, binary.length - i - 1);
//    ll += temp;
//    }
//    
//    NSString * result = [NSString stringWithFormat:@"%d",ll];
//    
//    return result;
//    }

}
