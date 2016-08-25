import UIKit


class FloatingActionMenuItem: UIView {

    var tap = UITapGestureRecognizer()
    let smallSize = 50
    let largeSize = 80
    
    enum ButtonSize:Int{
        case Small = 10
        case Large = 15
    }
    var timer = Timer()
    var _ButtonSize: ButtonSize
    var _ButtonColor = UIColor()
    var _ButtonIconLabel = String()
    var _ButtonFrame = CGRect()
    var _ButtonLayer = CAShapeLayer()
    var longPress = UILongPressGestureRecognizer()
    
    override init(frame: CGRect){
        self._ButtonSize = .Small
        self._ButtonColor = UIColor.blue
        self._ButtonFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
        self._ButtonIconLabel = ""
        super.init(frame: frame)
    }
    
    func changeButtonColor(color: UIColor) -> Void {
        self._ButtonColor = color
        self._ButtonLayer.removeFromSuperlayer()
        self.createButton(self._ButtonIconLabel,
                          buttonSize: self._ButtonSize,
                          buttonColor: color)
    }
    
    func showNotPressed() -> Void {
        self._ButtonLayer.removeFromSuperlayer()
        if self.longPress.state == .ended {
            self.createButton(self._ButtonIconLabel, buttonSize: self._ButtonSize, buttonColor: UIColor.blue)
            print("gesture ended")
        }
    }
    
    func showPressed() -> Void {
        self._ButtonLayer.removeFromSuperlayer()
        self.createButton(self._ButtonIconLabel, buttonSize: self._ButtonSize, buttonColor: UIColor.white)
    }
    
    init(icon: String, buttonSize:ButtonSize, buttonColor: UIColor) {
        self._ButtonSize = buttonSize
                switch buttonSize {
        case .Small:
            self._ButtonFrame = CGRect(x: 0, y: 0, width: smallSize , height: smallSize)
            break
        case .Large:
            self._ButtonFrame = CGRect(x: 0, y: 0, width: largeSize , height: largeSize)
            break
            
        }
        super.init(frame: _ButtonFrame)
        self.longPress = UILongPressGestureRecognizer(target: self, action: #selector(showPressed))
        self.createButton(icon, buttonSize: buttonSize, buttonColor: buttonColor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func createButton(_ icon: String, buttonSize: ButtonSize, buttonColor: UIColor) ->Void {
        
        let path = UIBezierPath(ovalIn: self._ButtonFrame)
        self._ButtonSize = buttonSize
        self._ButtonIconLabel = icon
        _ButtonLayer = CAShapeLayer()
        _ButtonLayer.fillColor = buttonColor.cgColor
        _ButtonLayer.path = path.cgPath
        
        let iconLabel = UILabel(frame: self._ButtonFrame)
        iconLabel.textAlignment = .center
        iconLabel.font = UIFont.systemFont(ofSize: CGFloat(Int(buttonSize.rawValue)))
        iconLabel.text = icon
        
        let iconImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        iconImage.image = UIImage(named: icon)
        iconImage.center = self.center
        self.layer.addSublayer(_ButtonLayer)

        if(iconImage.image != nil){
            self.addSubview(iconImage)
        }else{
            self.addSubview(iconLabel)
        }
    }
    
    
}
