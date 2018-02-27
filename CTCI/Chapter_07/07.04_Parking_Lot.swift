// Parking Lot

import Foundation

enum VehicleSize {
    case motorcycle
    case compact
    case large
}

class Vehicle {
    var parkingSpots: [ParkingSpot]
    let licensePlate: String
    
    init(licensePlate: String) {
        self.parkingSpots = [ParkingSpot]()
        self.licensePlate = licensePlate
    }
    
    func parkInSpot(parkingSpot: ParkingSpot) {
        // Park vehicle in this spot (maybe among others)
    }
    
    func clearSpots() {
        // Clear the spots and notifies that these are now free
    }
    
    var spotsNeeded: Int {
        // Var to be overriden
        return 0
    }
    
    var size: VehicleSize {
        // Var to be overriden
        return .compact
    }
    
    func canFitInSpot(parkingSpot: ParkingSpot) -> Bool{
        // Function to be overriden
        // Checks if a spot is big enough for the vehicle (and is available).
        // This compares the size enum item only. It doesn't check if it has enough spots.
        return false
    }
}

class Bus: Vehicle {
    override var spotsNeeded: Int {
        return 5
    }
    
    override var size: VehicleSize {
        return .large
    }
    
    override func canFitInSpot(parkingSpot: ParkingSpot) -> Bool{
        // Checks if the spot is large
        return parkingSpot.size == self.size
    }
}

class Car: Vehicle {
    override var spotsNeeded: Int {
        return 1
    }
    
    override var size: VehicleSize {
        return .compact
    }
    
    override func canFitInSpot(parkingSpot: ParkingSpot) -> Bool{
        // Checks if the spot is large or compact
        return parkingSpot.size == .compact ||
            parkingSpot.size == .large
    }
}

class Motorcycle: Vehicle {
    override var spotsNeeded: Int {
        return 1
    }
    
    override var size: VehicleSize {
        return .motorcycle
    }
    
    override func canFitInSpot(parkingSpot: ParkingSpot) -> Bool{
        // Checks if the spot is large, compact or motorcycle
        return parkingSpot.size == .large ||
            parkingSpot.size == .compact ||
            parkingSpot.size == .motorcycle
    }
}

class ParkingLot {
    private var levels: [Level]
    let levelsNumber = 5
    
    init() {
        self.levels = [Level]()
        for i in 0..<self.levelsNumber {
            self.levels.append(Level(floor: i, numberOfSpots: 100))
        }
    }
    
    func park(vehicle: Vehicle) -> Bool {
        // Returns true if the vehicle can be parked, false otherwise
        return false
    }
    
}

class Level {
    let floor: Int
    private(set) var availableSpots: Int
    let spots: [ParkingSpot]
    let spotsPerRow = 10
    
    init(floor: Int, numberOfSpots: Int) {
        self.floor = floor
        self.availableSpots = numberOfSpots
        // The number of spots should be initialized according
        // to certain numbers of bus, car and motorcycle vehicles
        self.spots = [ParkingSpot]()
    }
    
    func park(vehicle: Vehicle) -> Bool {
        // Returns true if the vehicle can be parked, false otherwise
        return false
    }
    
    func park(startingAt: Int, vechicle: Vehicle) -> Bool {
        // Returns true if the vehicle can be parked, false otherwise
        // A vehicle can be parked if exist enough contiguous spaces
        // with the required size
        return false
    }
    
    func findAvailableSpots(forVehicle vehicle: Vehicle) -> Int? {
        // Finds spots to park this vehicle and returns the start index if it's found,
        // otherwise returns nil
        return nil
    }
    
    func freeSpot() {
        // When a car leaves a spot, increments the available spots
        self.availableSpots += 1
    }
    
}

class ParkingSpot {
    let size: VehicleSize
    let row: Int
    let spotNumber: Int
    unowned var level: Level
    weak var vehicle: Vehicle?
    
    init(level: Level, size: VehicleSize, row: Int, spotNumber: Int) {
        self.level = level
        self.size = size
        self.row = row
        self.spotNumber = spotNumber
    }
    
    var isAvailable: Bool {
        return self.vehicle == nil
    }
    
    func canFit(vehicle: Vehicle) -> Bool {
        // Check if the spot is big enough for the vehicle
        return false
    }
    
    func park(vehicle: Vehicle) -> Bool {
        // Park the vehicle in this spot
        return false
    }
    
    func removeVehicle() {
        // Remove the current vehicle and notify to the level that the spot is available
    }
}
