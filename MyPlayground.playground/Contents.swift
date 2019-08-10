//import UIKit
import Alamofire

/*
 import PlaygroundSupport
 import UIKit
 let view = UIView(frame: CGRect(x: 0, y:0, width: 1024, height: 768))
 view.backgroundColor = .red
 PlaygroundPage.current.liveView = view
 */

print("Run")
TestApi.run(id:239)
print("done")
/*
class A{
    required init() {
        
    }
}
extension A{
    class func frommNib<T: A>() -> T {
        print("++ T.init()--------------------> ", T.init() )
        print("++ T.self ----------> ", T.self )
        print("++ self ------------> ", self )
        print("++ String(describing: type(of: T.self)) -----------> ",String(describing: type(of: T.self)))
        return T.init()
    }
    func fromNib() -> String! {
        print("self ------------> ", self )
        print("type(of: self) ------------> ", type(of: self))
        print("String(describing: type(of: self)) ------------> ",String(describing: type(of: self)))
        return "vsiew"
    }
}
class G<T>: A{
    func name(){
        print(self)
        print(type(of: self))
        //print(G.Type)
    }
}
class C: G<Date>{
    
}

let c = C()
c.name()
print("***********")
c.fromNib()
print("***********")
C.frommNib()
*/
