protocol Animalable {
    var isLive: Bool
    var position: ( x: Int, y: Int)?
    func moveTo ( to: ( x: Int, y:Int), isPossible: Bool) {
        self.position = to
    }
}
