#!/usr/bin/swift

import Foundation

class genstringsStep2 {
    func perform() {
        let argus = Array(Process.arguments[1..<Process.arguments.count])
        if argus.count < 2 {
            print("Usage: ./genstringsStep2.swift PATH FOLDER FILE TO1 ... TOn")
            print("Example: ./genstringsStep2.swift ./ Base Localizable zh-Hans zh-Hant")
            return
        }
        let path = argus[0]
        let from = argus[1] + ".lproj"
        let fileName = "\(argus[2]).strings"
        var to = [String]()
        for i in 3 ..< argus.count {
            to.append("\(argus[i]).lproj")
        }
        
        let baseFileName = "\(path)\(from)/\(fileName)"
        print(baseFileName)
        
        if let dicBase = NSDictionary(contentsOfFile: baseFileName) {
            for str in to {
                let toFileName = "\(path)\(str)/\(fileName)"
                if let dictt = NSDictionary(contentsOfFile: toFileName){
                    let dicTo = NSMutableDictionary(dictionary: dictt)
                    for (k,_) in dicTo{
                        if dicBase.objectForKey(k) == nil {
                            dicTo.removeObjectForKey(k)
                        }
                    }
                    for (k,v) in dicBase{
                        if dicTo.objectForKey(k) == nil {
                            if let key = k as? String{
                                dicTo.setObject(v, forKey: key)
                            }
                        }
                    }
                    
                    var keys = dicTo.allKeys as? [String]
                    keys?.sortInPlace({ (s1, s2) -> Bool in
                        return s1 < s2
                    })
                    let result = NSMutableString()
                    for key in keys!{
                        result.appendFormat("\"%@\"=\"%@\";\n", key,dicTo.objectForKey(key) as! String)
                        result.appendString("\n")
                        print(key)
                    }
                    print(result)
                    do {
                        try result.writeToFile(toFileName, atomically: true, encoding:NSUTF8StringEncoding )
                    } catch _ {
                    }
                }
            }
        }
    }
}

let gs = genstringsStep2()
gs.perform()
