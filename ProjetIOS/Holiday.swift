// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation


class Vacancy: Codable {
    var meta: Meta?
    var response: Response?

    init(meta: Meta?, response: Response?) {
        self.meta = meta
        self.response = response
    }
}

// MARK: - Meta
class Meta: Codable {
    var code: Int?

    init(code: Int?) {
        self.code = code
    }
}
//
//// MARK: - Response
class Response: Codable {
    var holidays: [Holiday]?

    init(holidays: [Holiday]?) {
        self.holidays = holidays
    }
}

// MARK: - Holiday
class Holiday: Codable {
    var name: String?
    var date: DateClass?

    init(name: String?, holidayDescription: String?, date: DateClass?, type: [String]?, locations: String?, states: String?) {
        self.name = name
        self.date = date
    }
}

// MARK: - DateClass
class DateClass: Codable {
    var iso: String?
    var datetime: Datetime?
    var timezone: Timezone?

    init(iso: String?, datetime: Datetime?, timezone: Timezone?) {
        self.iso = iso
        self.datetime = datetime
        self.timezone = timezone
    }
}

// MARK: - Datetime
class Datetime: Codable {
    var year, month, day, hour: Int?
    var minute, second: Int?

    init(year: Int?, month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        self.year = year
        self.month = month
        self.day = day
        self.hour = hour
        self.minute = minute
        self.second = second
    }
}

// MARK: - Timezone
class Timezone: Codable {
    var offset, zoneabb: String?
    var zoneoffset, zonedst, zonetotaloffset: Int?

    init(offset: String?, zoneabb: String?, zoneoffset: Int?, zonedst: Int?, zonetotaloffset: Int?) {
        self.offset = offset
        self.zoneabb = zoneabb
        self.zoneoffset = zoneoffset
        self.zonedst = zonedst
        self.zonetotaloffset = zonetotaloffset
    }
}
