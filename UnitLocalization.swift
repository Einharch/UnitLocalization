//
//  UnitLocalization.swift
//  EinFit
//
//  Created by 財弟夫悧努 on 2017/01/25.
//  Copyright © 2017 Einharch. All rights reserved.
//

import Foundation

// MARK: - Class Declaration

public class UnitLocalization : NSObject {

    /// Shared instance of UnitLocalization

    public static let manager: UnitLocalization = {

        let instance = UnitLocalization()

        instance.formatter.unitStyle    = .medium
        instance.formatter.unitOptions  = .naturalScale

        return instance
    }()

    private override init() {
        super.init()
    }

    // MARK: - Formatter Instance

    /// An instance of MeasurementFormatter set up with **short** _unit style_ and **natural scale** _unit option_.
    internal let formatter = MeasurementFormatter()


    // TODO: Decide or not if we want these

    public func override(style: MeasurementFormatter.UnitStyle?, option: MeasurementFormatter.UnitOptions?) -> Void {

        if style != nil {
            formatter.unitStyle = style!
        }

        if option != nil {
            formatter.unitOptions = option!
        }
    }

    public func override(locale identifier: String) {

        guard NSLocale.availableLocaleIdentifiers.contains(identifier), let locale = NSLocale.init(localeIdentifier: identifier) as Locale! else {

            print("Wrong Locale \(identifier)")
            formatter.locale = NSLocale.current
            return
        }

        formatter.locale = locale
    }

    internal func localized(unit: Measurement<Unit>.ReferenceType) -> String {
        return formatter.string(from: unit as Measurement<Unit>)
    }

    internal func localized(unit: Measurement<Unit>.ReferenceType, style: MeasurementFormatter.UnitStyle) -> String {

        let stylizedFormatter = formatter
        stylizedFormatter.unitStyle = style

        return stylizedFormatter.string(from: unit as Measurement<Unit>)
    }
}


// MARK: - Function Extension

// MARK: - Localized Display Strings from Values

extension UnitLocalization {

    // MARK: - Human Unit


    // MARK: - Weight

    /// Returns a localized weight string (human)
    ///
    /// - Parameter weight: Weight value in **Kilograms**
    /// - Returns: A Localized String of the weight
    public func localized(weight: Double) -> String {
        return localized(weight: weight, style: .medium)
    }

    /// Returns a localized weight string (human) in decided style
    ///
    /// - Parameters:
    ///   - weight: Weight value in **Kilograms**
    ///   - style: Parameter to decide length of the string
    /// - Returns: A Localized String of the weight
    public func localized(weight: Double, style: MeasurementFormatter.UnitStyle) -> String {
        return localized(unit: self.mass(value: weight, in: .kilograms) as Measurement.ReferenceType, style: style)
    }


    // MARK: - Height

    /// Returns a localized height string (human)
    ///
    /// - Parameter height: Height value in **Centimeters**
    /// - Returns: A Localized String of the height
    public func localized(height: Double) -> String {
        return localized(length: height, in: .centimeters, style: .medium)
    }

    /// Returns a localized height string (human) in decided style
    ///
    /// - Parameters:
    ///   - height: Height value in **Centimeters**
    ///   - style: Parameter to decide length of the string
    /// - Returns: A Localized String of the height
    public func localized(height: Double, style: MeasurementFormatter.UnitStyle) -> String {
        return localized(length: height, in: .centimeters, style: style)
    }



    // MARK: - Non-human Units

    // MARK: - Mass

    /// Returns a localized mass (weight) string from value in **Kilograms**
    ///
    /// - Parameter mass: Mass value in **Kilograms**
    /// - Returns: A Localized String of the mass (weight)
    public func localized(mass: Double) -> String {
        return localized(mass: mass, in: .kilograms, style: .medium)
    }

    /// Returns a localized mass (weight) string
    ///
    /// - Parameters:
    ///   - mass: Mass value
    ///   - unit: Unit of the mass value
    /// - Returns: A Localized String of the mass (weight)
    public func localized(mass: Double, in unit: UnitMass) -> String {
        return localized(mass: mass, in: unit, style: .medium)
    }

    /// Returns a localized mass (weight) string from value in **Kilograms** in decided style
    ///
    /// - Parameters:
    ///   - mass: Mass value in **Kilograms**
    ///   - style: Parameter to decide length of the string
    /// - Returns: A Localized String of the mass (weight)
    public func localized(mass: Double, style: MeasurementFormatter.UnitStyle) -> String {
        return localized(mass: mass, in: .kilograms, style: style)
    }

    /// Returns a localized mass (weight) string in decided style
    ///
    /// - Parameters:
    ///   - mass: Mass value
    ///   - unit: Unit of the mass value
    ///   - style: Parameter to decide length of the string
    /// - Returns: A Localized String of the mass (weight)
    public func localized(mass: Double, in unit: UnitMass, style: MeasurementFormatter.UnitStyle) -> String {
        return localized(unit: self.mass(value: mass, in: unit) as Measurement.ReferenceType, style: style)
    }

    // MARK: - Length


    /// Returns a localized length string from value in **Centimeters**
    ///
    /// - Parameter length: Length value in **Centimeters**
    /// - Returns: A Localized String of the length
    public func localized(length: Double) -> String {
        return localized(length: length, in: .centimeters, style: .medium)
    }

    /// Returns a localized length string in decided Style
    ///
    /// - Parameters:
    ///   - length: Length value
    ///   - unit: Unit of the length value
    /// - Returns: A Localized String of the length
    public func localized(length: Double, in unit: UnitLength) -> String {
        return localized(length: length, in: unit, style: .medium)
    }

    /// Returns a localized length string from value in **Centimeters**
    ///
    /// - Parameters:
    ///   - length: Length value in **Centimeters**
    ///   - style: Parameter to decide length of the string
    /// - Returns: A Localized String of the length
    public func localized(length: Double, style: MeasurementFormatter.UnitStyle) -> String {
        return localized(length: length, in: .centimeters, style: style)
    }

    /// Returns a localized length string in decided Style
    ///
    /// - Parameters:
    ///   - length: Length value
    ///   - unit: Unit of the length value
    ///   - style: Parameter to decide length of the string
    /// - Returns: A Localized String of the length
    public func localized(length: Double, in unit: UnitLength, style: MeasurementFormatter.UnitStyle) -> String {
        return localized(unit: self.length(value: length, in: unit) as Measurement.ReferenceType, style: style)
    }

    // MARK: - Distance

    /// Returns a localized distance string from value in **Meters**
    ///
    /// - Parameter distance: Distance value in **Meters**
    /// - Returns: A Localized String of the distance
    public func localized(distance: Double) -> String {
        return localized(length: distance, in: .meters, style: .medium)
    }

    /// Returns a localized distance string in decided Style
    ///
    /// - Parameters:
    ///   - distance: Distance value
    ///   - unit: Unit of the distance value
    /// - Returns: A Localized String of the distance
    public func localized(distance: Double, in unit: UnitLength) -> String {
        return localized(length: distance, in: unit, style: .medium)
    }

    /// Returns a localized distance string from value in **Meters** in decided Style
    ///
    /// - Parameters:
    ///   - distance: Distance value in **Meters**
    ///   - style: Parameter to decide length of the string
    /// - Returns: A Localized String of the distance
    public func localized(distance: Double, style: MeasurementFormatter.UnitStyle) -> String {
        return localized(length: distance, in: .meters, style: style)
    }

    /// Returns a localized distance string in decided Style
    ///
    /// - Parameters:
    ///   - distance: Distance value
    ///   - unit: Unit of the distance value
    ///   - style: Parameter to decide length of the string
    /// - Returns: A Localized String of the distance
    public func localized(distance: Double, in unit: UnitLength, style: MeasurementFormatter.UnitStyle) -> String {
        return localized(length: distance, in: unit, style: style)
    }



    // TODO: Add natural scale

    // MARK: - Energy

    /// Returns a localized energy string from value in **Kilocalories**
    ///
    /// - Parameter energy: Energy value in **Kilocalories**
    /// - Returns: A Localized String of the energy
    public func localized(energy: Double) -> String {
        return localized(energy: energy, in: .kilocalories)
    }

    /// Returns a localized energy string
    ///
    /// - Parameters:
    ///   - energy: Energy value
    ///   - unit: Unit of the energy value
    /// - Returns: A Localized String of the energy
    public func localized(energy: Double, in unit: UnitEnergy) -> String {
        return localized(energy: energy, in: unit, style: .medium)
    }

    /// Returns a localized energy string from value in **Kilocalories** in decided Style
    ///
    /// - Parameters:
    ///   - energy: Energy value in **Kilocalories**
    ///   - style: Parameter to decide length of the string
    /// - Returns: A Localized String of the energy
    public func localized(energy: Double, style: MeasurementFormatter.UnitStyle) -> String {
        return localized(energy: energy, in: .kilocalories, style: style)
    }

    /// Returns a localized energy string in decided Style
    ///
    /// - Parameters:
    ///   - energy: Energy value
    ///   - unit: Unit of the energy value
    ///   - style: Parameter to decide length of the string
    /// - Returns: A Localized String of the energy
    public func localized(energy: Double, in unit: UnitEnergy, style: MeasurementFormatter.UnitStyle) -> String {
        return localized(unit: self.energy(value: energy, in: unit) as Measurement.ReferenceType, style: style)
    }


    // MARK: - Speed

    /// Returns a localized speed string from value in **Meters per Seconds**
    ///
    /// - Parameter speed: Speed value in **Meters per Seconds**
    /// - Returns: A Localized String of the speed
    public func localized(speed: Double) -> String {
        return localized(speed: speed, in: .metersPerSecond, style: .medium)
    }

    /// Returns a localized speed string in decided Style
    ///
    /// - Parameters:
    ///   - speed: Speed value
    ///   - unit: Unit of the speed value
    /// - Returns: A Localized String of the speed
    public func localized(speed: Double, in unit: UnitSpeed) -> String {
        return localized(speed: speed, in: unit, style: .medium)
    }

    /// Returns a localized speed string from value in **Meters per Seconds** in decided Style
    ///
    /// - Parameters:
    ///   - speed: Speed value in **Meters per Seconds**
    ///   - style: Parameter to decide length of the string
    /// - Returns: A Localized String of the speed
    public func localized(speed: Double, style: MeasurementFormatter.UnitStyle) -> String {
        return localized(speed: speed, in: .metersPerSecond, style: style)
    }

    /// Returns a localized speed string in decided Style
    ///
    /// - Parameters:
    ///   - speed: Speed value
    ///   - unit: Unit of the speed value
    ///   - style: Parameter to decide length of the string
    /// - Returns: A Localized String of the speed
    public func localized(speed: Double, in unit: UnitSpeed, style: MeasurementFormatter.UnitStyle) -> String {
        return localized(unit: self.speed(from: speed, in: unit) as Measurement.ReferenceType, style: style)
    }



    // MARK: - Duration

    /// Returns a localized duration string from value in **Seconds**
    ///
    /// - Parameter duration: Duration value in **Seconds**
    /// - Returns: A Localized String of the duration
    public func localized(duration: TimeInterval) -> String {
        return localized(duration: duration, in: .seconds, style: .medium)
    }

    /// Returns a localized duration
    ///
    /// - Parameters:
    ///   - duration: Duration value
    ///   - unit: Unit of the duration value
    /// - Returns: A Localized String of the duration
    public func localized(duration: Double, in unit: UnitDuration) -> String {
        return localized(duration: duration, in: unit, style: .medium)
    }

    /// Returns a localized duration string from value in **Seconds** in decided Style
    ///
    /// - Parameters:
    ///   - duration: Duration value in **Seconds**
    ///   - style: Parameter to decide length of the string
    /// - Returns: A Localized String of the duration
    public func localized(duration: TimeInterval, style: MeasurementFormatter.UnitStyle) -> String {
        return localized(duration: duration, in: .seconds, style: style)
    }

    /// Returns a localized duration string in decided Style
    ///
    /// - Parameters:
    ///   - duration: Duration value
    ///   - unit:  Unit of the duration value
    ///   - style: Parameter to decide length of the string
    /// - Returns: A Localized String of the duration
    public func localized(duration: Double, in unit: UnitDuration, style: MeasurementFormatter.UnitStyle) -> String {
        return localized(unit: self.duration(value: duration, in: unit) as Measurement.ReferenceType, style: style)
    }

    // MARK: - Position

    /// Returns a localized ordinal (position) for the input number
    ///
    /// - Parameter ordinal: A number (position)
    /// - Returns: Localized string of the position
    public func localized(ordinal: NSNumber) -> String? {
        return localized(ordinal: ordinal, outOfBoundSymbol: "")
    }

    /// Returns a localized ordinal (position) for the input number, and sets 0, nil and wrong numbers to decided string
    ///
    /// - Parameters:
    ///   - ordinal: A number (position)
    ///   - symbol: A string to replace 0th, nil and wrong positions (for example " - ")
    /// - Returns: Localized string of the position
    public func localized(ordinal: NSNumber, outOfBoundSymbol symbol: String) -> String? {

        let nFormatter = NumberFormatter()

        nFormatter.numberStyle      = .ordinal
        nFormatter.nilSymbol        = symbol
        nFormatter.zeroSymbol       = symbol
        nFormatter.notANumberSymbol = symbol

        // TODO: Force an unwrapped string by returning an empty one? (` ?? "") or throw an error?
        return nFormatter.string(from: ordinal)
    }


}


// MARK: - Localized Display Strings from Measurement

extension UnitLocalization {

    // MARK: - Mass

    @objc(localizedMassMeasurement:)
    /// Returns a localized mass string from a mass measurement
    ///
    /// - Parameter mass: Mass measurement
    /// - Returns: A Localized String of the mass
    public func localized(mass: Measurement<UnitMass>) -> String {
        return formatter.string(from: mass)
    }

    @objc(localizedMassMeasurement:withStyle:)
    /// Returns a localized mass string from a mass measurement in decided Style
    ///
    /// - Parameters:
    ///   - mass: Mass measurement
    ///   - style: Parameter to decide length of the string
    /// - Returns: A Localized String of the mass
    public func localized(mass: Measurement<UnitMass>, style: MeasurementFormatter.UnitStyle) -> String {
        return localized(unit: mass as Measurement.ReferenceType, style: style)
    }

    // MARK: - Length

    @objc(localizedLengthMeasurement:)
    /// Returns a localized length string from a length measurement
    ///
    /// - Parameter length: Length measurement
    /// - Returns: A Localized String of the length
    public func localized(length: Measurement<UnitLength>) -> String {
        return formatter.string(from: length)
    }

    @objc(localizedLengthMeasurement:withStyle:)
    /// Returns a localized length string from a length measurement in decided Style
    ///
    /// - Parameters:
    ///   - length: Length measurement
    ///   - style: Parameter to decide length of the string
    /// - Returns: A Localized String of the length
    public func localized(length: Measurement<UnitLength>, style: MeasurementFormatter.UnitStyle) -> String {
        return localized(unit: length as Measurement.ReferenceType, style: style)
    }

    // MARK: - Distance

    @objc(localizedDistanceMeasurement:)
    /// Returns a localized length string from a length measurement
    ///
    /// - Parameter length: Length measurement
    /// - Returns: A Localized String of the length
    public func localized(distance: Measurement<UnitLength>) -> String {
        return localized(length: distance)
    }

    @objc(localizedDistanceMeasurement:withStyle:)
    /// Returns a localized distance string from a length measurement in decided Style
    ///
    /// - Parameters:
    ///   - distance: Length measurement
    ///   - style: Parameter to decide length of the string
    /// - Returns: A Localized String of the distance
    public func localized(distance: Measurement<UnitLength>, style: MeasurementFormatter.UnitStyle) -> String {
        return localized(length: distance, style: style)
    }

    // MARK: - Energy

    @objc(localizedEnergyMeasurement:)
    /// Returns a localized energy string from a energy measurement
    ///
    /// - Parameter energy: Energy measurement
    /// - Returns: A Localized String of the energy
    public func localized(energy: Measurement<UnitEnergy>) -> String {
        return formatter.string(from: energy)
    }

    @objc(localizedEnergyMeasurement:withStyle:)
    /// Returns a localized energy string from a energy measurement in decided Style
    ///
    /// - Parameters:
    ///   - energy: Energy measurement
    ///   - style: Parameter to decide length of the string
    /// - Returns: A Localized String of the energy
    public func localized(energy: Measurement<UnitEnergy>, style: MeasurementFormatter.UnitStyle) -> String {
        return localized(unit: energy as Measurement.ReferenceType, style: style)
    }

    // MARK: - Speed

    @objc(localizedSpeedMeasurement:)
    /// Returns a localized speed string from a speed measurement
    ///
    /// - Parameter speed: Speed measurement
    /// - Returns: A Localized String of the speed
    public func localized(speed: Measurement<UnitSpeed>) -> String {
        return formatter.string(from: speed)
    }

    @objc(localizedSpeedMeasurement:withStyle:)
    /// Returns a localized speed string from a speed measurement in decided Style
    ///
    /// - Parameters:
    ///   - speed: Speed measurement
    ///   - style: Parameter to decide length of the string
    /// - Returns: A Localized String of the speed
    public func localized(speed: Measurement<UnitSpeed>, style: MeasurementFormatter.UnitStyle) -> String {
        return localized(unit: speed as Measurement.ReferenceType, style: style)
    }

    // MARK: - Duration

    @objc(localizedDurationMeasurement:)
    /// Returns a localized duration string from a duration measurement
    ///
    /// - Parameter duration: Duration measurement
    /// - Returns: A Localized String of the duration
    public func localized(duration: Measurement<UnitDuration>) -> String {
        return formatter.string(from: duration)
    }

    @objc(localizedDurationMeasurement:withStyle:)
    /// Returns a localized duration string from a duration measurement in decided Style
    ///
    /// - Parameters:
    ///   - duration: Duration measurement
    ///   - style: Parameter to decide length of the string
    /// - Returns: A Localized String of the duration
    public func localized(duration: Measurement<UnitDuration>, style: MeasurementFormatter.UnitStyle) -> String {
        return localized(unit: duration as Measurement.ReferenceType, style: style)
    }


}

// MARK: - Measurement Units and Values from Localized Numbers

extension UnitLocalization {

    // MARK: - Mass

    /// Returns a Mass Measurement unit from mass in **Kilograms**
    ///
    /// - Parameter kilograms: Mass value in **Kilograms**
    /// - Returns: A Mass Measurement unit
    public func mass(value kilograms: Double) -> Measurement<UnitMass> {
        return mass(value: kilograms, in: .kilograms)
    }

    /// Returns a Mass Measurement unit from mass in given unit
    ///
    /// - Parameters:
    ///   - value: Mass value
    ///   - unit: Unit of the mass value
    /// - Returns: A Mass Measurement unit
    public func mass(value: Double, in unit: UnitMass) -> Measurement<UnitMass> {
        return Measurement(value: value, unit: unit)
    }

    // MARK: - Length

    /// Returns a Length Measurement unit from length in **Meters**
    ///
    /// - Parameter meters: Length value in **Meters**
    /// - Returns: A Length Measurement unit
    public func length(value meters: Double) -> Measurement<UnitLength> {
        return length(value: meters, in: .meters)
    }

    /// Returns a Length Measurement unit
    ///
    /// - Parameters:
    ///   - value: Length value
    ///   - unit: Unit of the length value
    /// - Returns: A Length Measurement unit
    public func length(value: Double, in unit: UnitLength) -> Measurement<UnitLength> {
        return Measurement(value: value, unit: unit)
    }

    // MARK: - Distance

    /// Returns a Length Measurement unit from distance in **Meters**
    ///
    /// - Parameter meters: Distance value in **Meters**
    /// - Returns: A Length Measurement unit
    public func distance(value meters: Double) -> Measurement<UnitLength> {
        return length(value: meters, in: .meters)
    }

    /// Returns a Length Measurement unit
    ///
    /// - Parameters:
    ///   - value: Distance value
    ///   - unit: Unit of the distance value
    /// - Returns: A Length Measurement unit
    public func distance(value: Double, in unit: UnitLength) -> Measurement<UnitLength> {
        return length(value: value, in: unit)
    }

    // MARK: - Energy

    /// Returns an Energy Measurement unit from value in **Kilocalories**
    ///
    /// - Parameter value: Energy value in **Kilocalories**
    /// - Returns: An Energy Measurement unit
    public func energy(value: Double) -> Measurement<UnitEnergy> {
        return energy(value: value, in: .kilocalories)
    }

    /// Returns an Energy Measurement unit
    ///
    /// - Parameters:
    ///   - value: Energy value
    ///   - unit: Unit of the energy value value
    /// - Returns: An Energy Measurement unit
    public func energy(value: Double, in unit: UnitEnergy) -> Measurement<UnitEnergy> {
        return Measurement(value: value, unit: unit)
    }

    // MARK: - Speed

    /// Returns a Speed Measurement unit
    ///
    /// - Parameters:
    ///   - value: Speed value
    ///   - unit: Unit of the speed value
    /// - Returns: A Speed Measurement unit
    public func speed(from value: Double, in unit: UnitSpeed) -> Measurement<UnitSpeed> {
        return Measurement(value: value, unit: unit)
    }

    /// Returns a Speed Measurement unit
    ///
    /// - Parameters:
    ///   - distance: A distance value in **Meters**
    ///   - time: A time interval in **Seconds**
    /// - Returns: A Speed Measurement unit
    public func speed(from distance: Double, per time: TimeInterval) -> Measurement<UnitSpeed> {

        guard time > 0 else {
            return Measurement(value: .infinity, unit: UnitSpeed.metersPerSecond)
        }

        let length      = self.distance(value: distance)
        let duration    = self.duration(value: time)

        return speed(from: length, per: duration)
    }

    @objc(speedFromDistance:perDuration:)
    /// Returns a Speed Measurement unit
    ///
    /// - Parameters:
    ///   - distance: A length (distance) measurement unit
    ///   - time: A duration measurement unit
    /// - Returns: A Speed Measurement unit
    public func speed(from distance: Measurement<UnitLength>, per time: Measurement<UnitDuration>)  -> Measurement<UnitSpeed> {

        guard time.converted(to: UnitDuration.seconds).value > 0 else {
            return Measurement(value: .infinity, unit: .metersPerSecond)
        }

        let distanceInMeter     = distance.converted(to: .meters)
        let durationInSeconds   = time.converted(to: .seconds)

        let speedInMPS          = distanceInMeter.value / durationInSeconds.value

        return speed(from: speedInMPS, in: .metersPerSecond)
    }

    // MARK: - Duration

    /// Returns a Duration Measurement unit
    ///
    /// - Parameters:
    ///   - start: Start date
    ///   - end: End date
    /// - Returns: A Duration Measurement unit
    public func duration(from start: Date, to end: Date) -> Measurement<UnitDuration> {

        let interval = end.timeIntervalSince(start)
        return duration(value: interval)
    }

    /// Returns a Duration Measurement unit from Time Interval in **Seconds**
    ///
    /// - Parameter interval: Time interval in **Seconds**
    /// - Returns: A Duration Measurement unit
    public func duration(value interval: TimeInterval) -> Measurement<UnitDuration> {
        return duration(value: interval, in: .seconds)
    }

    /// Returns a Duration Measurement unit
    ///
    /// - Parameters:
    ///   - value: Time interval value
    ///   - unit: Unit of the time interval value
    /// - Returns: A Duration Measurement unit
    public func duration(value: Double, in unit: UnitDuration) -> Measurement<UnitDuration> {
        return Measurement(value: value, unit: unit)
    }
}

// TODO: Extend Recipe Units

/// Unit display style, decides how the unit is displayed and localized next to the value. Default is medium.
///
/// - short: For short sentences and unit in limited display, example: **91.7kg**
/// - medium: Same as short but respects spacing rules, example: **91.7 kg**
/// - long: For long descriptions, example: **91.7 kilograms**
public enum LocalizationStyle {
    case short
    case medium
    case long
}
