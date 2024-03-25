import UIKit
import Foundation

func address( o : UnsafeRawPointer){
    print("address: \(Int(bitPattern: o))")
}
struct Identifier{
    var id = 1
}
class Ref<T>{ //Class that keep link
    var value : T
    init(value: T){
        self.value = value
    }
}
struct IOSCollection<T>{
    var ref : Ref<T> // create link
    init(value: T){
        self.ref = Ref(value: value)
    }
    var value :T{
        get{
            ref.value
        }
        set{
            guard (isKnownUniquelyReferenced(&ref)) else{
                ref = Ref(value: newValue)
                return
            }
            ref.value = newValue
        }
    }
}
var id = Identifier()
var container1 = IOSCollection(value: id)
var container2 = container1
//as we can see struct is value type but when we used CoW container1 and container2 point on 1 memory area
address(o:&container1.ref)
address(o:&container2.ref)
container2.value.id = 12
address(o:&container1.ref)
address(o:&container2.ref)

protocol Hotel {
    var roomCount : Int { get }
    init(id: Int)
}
class HotelAlfa : Hotel{
    var rooms : Int
    var roomCount: Int {
        return rooms
    }
    var name :String
    init(rooms:Int,name: String) {
        self.rooms = rooms
        self.name = name
    }
    required init(id: Int) {
        name  = "Alfa"
        rooms = 13
    }
}

protocol GameDice{
    var numberDice : Int {get }

}
extension Int: GameDice{
    var numberDice : Int{
        print("you got \(self) on coub")
        return self
    }

}
let diceCoub : Int = 4
diceCoub.numberDice
protocol prot{
    var numb :Int? {get}
    var str : String{get set}
    func outp()
}

class SomeClass :prot{
    var word: String
    var str: String{
        return word
    }
    init(word: String){
        self.word = word
    }
}

protocol Time{
    var time : Int{get}
    var amountOfCode: Int{get}
    
}
enum Platform{
    case ios
    case android
    case web
}
protocol Methods{
    
    func writeCode(platform: Platform, numberOfSpecialist: Int)
    func stopCoding()
}
class Company: Methods,Time{
    
    var timing :Int
    var time: Int{
        return timing
    }
    var work : Int
    var amountOfCode: Int{
        return work
    }
    var numberOfSpecialist: Int
    init(timing:Int,work: Int){
        self.timing = timing
        self.work = work
        
    }
    enum Platform{
        case ios
        case android
        case web
    }
    func writeCode(platform: Platform, numberOfSpecialist: Int) {
        print("writing code")
    }
    func stopCoding() {
        print("work is done. send to the testing")
    }
    
}

