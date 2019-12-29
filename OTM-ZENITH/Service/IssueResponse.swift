//
//  IssueResponse.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 21/12/19.
//  Copyright © 2019 Freddy Mendez. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let searchIssueResponse = try? newJSONDecoder().decode(SearchIssueResponse.self, from: jsonData)

import Foundation

// MARK: - SearchIssueResponse
struct SearchIssueResponse: Codable {
    let expand: String?
    let startAt: Int?
    let maxResults: Int?
    let total: Int?
    let issues: [Issue]?

    enum CodingKeys: String, CodingKey {
        case expand = "expand"
        case startAt = "startAt"
        case maxResults = "maxResults"
        case total = "total"
        case issues = "issues"
    }
}

// MARK: - Issue
struct Issue: Codable {
    let expand: String?
    let id: String?
    let issueSelf: String?
    let key: String?
    let fields: IssueFields?

    enum CodingKeys: String, CodingKey {
        case expand = "expand"
        case id = "id"
        case issueSelf = "self"
        case key = "key"
        case fields = "fields"
    }
}

// MARK: - IssueFields
struct IssueFields: Codable {
    let statuscategorychangedate: String?
    let customfield10070: JSONNull?
    let customfield10071: JSONNull?
    let customfield10074: JSONNull?
    let customfield10075: JSONNull?
    let customfield10076: JSONNull?
    let fixVersions: [JSONAny]?
    let resolution: Priority?
    let customfield10079: String?
    let customfield10104: JSONNull?
    let customfield10105: JSONNull?
    let customfield10106: JSONNull?
    let customfield10107: String?
    let lastViewed: String?
    let customfield10060: JSONNull?
    let customfield10061: String?
    let customfield10062: String?
    let customfield10063: String?
    let customfield10064: String?
    let customfield10065: String?
    let customfield10100: [Customfield10]?
    let priority: Priority?
    let customfield10101: String?
    let customfield10068: JSONNull?
    let customfield10102: JSONNull?
    let customfield10069: JSONNull?
    let customfield10103: JSONNull?
    let labels: [JSONAny]?
    let timeestimate: JSONNull?
    let aggregatetimeoriginalestimate: JSONNull?
    let versions: [JSONAny]?
    let issuelinks: [Issuelink]?
    let assignee: Creator?
    let status: Status?
    let components: [JSONAny]?
    let customfield10055: JSONNull?
    let customfield10056: String?
    let customfield10057: JSONNull?
    let customfield10058: String?
    let customfield10059: String?
    let aggregatetimeestimate: JSONNull?
    let creator: Creator?
    let subtasks: [JSONAny]?
    let customfield10160: [Customfield10]?
    let customfield10040: JSONNull?
    let customfield10161: [Customfield10]?
    let customfield10162: [Customfield10]?
    let customfield10041: JSONNull?
    let customfield10163: [Customfield10]?
    let customfield10042: JSONNull?
    let reporter: Creator?
    let customfield10043: JSONNull?
    let aggregateprogress: Progress?
    let customfield10044: JSONNull?
    let customfield10045: JSONNull?
    let customfield10159: [Customfield10]?
    let customfield10038: JSONNull?
    let customfield10039: JSONNull?
    let progress: Progress?
    let votes: Votes?
    let worklog: WorklogClass?
    let issuetype: Issuetype?
    let timespent: JSONNull?
    let customfield10030: JSONNull?
    let customfield10031: JSONNull?
    let project: Project?
    let customfield10032: JSONNull?
    let customfield10033: JSONNull?
    let customfield10034: JSONNull?
    let aggregatetimespent: JSONNull?
    let customfield10035: JSONNull?
    let customfield10036: JSONNull?
    let customfield10158: [Customfield10]?
    let customfield10037: JSONNull?
    let customfield10027: JSONNull?
    let customfield10028: JSONNull?
    let customfield10029: JSONNull?
    let resolutiondate: String?
    let workratio: Int?
    let watches: Watches?
    let created: String?
    let customfield10020: String?
    let customfield10021: JSONNull?
    let customfield10022: String?
    let customfield10023: [JSONAny]?
    let customfield10016: JSONNull?
    let customfield10017: JSONNull?
    let customfield10018: Customfield10018?
    let customfield10019: String?
    let updated: String?
    let customfield10090: JSONNull?
    let customfield10091: JSONNull?
    let customfield10092: JSONNull?
    let customfield10093: JSONNull?
    let customfield10094: JSONNull?
    let timeoriginalestimate: JSONNull?
    let customfield10095: JSONNull?
    let customfield10096: JSONNull?
    let customfield10097: JSONNull?
    let fieldsDescription: DescriptionClass?
    let customfield10010: JSONNull?
    let customfield10098: JSONNull?
    let customfield10099: JSONNull?
    let customfield10014: JSONNull?
    let timetracking: Timetracking?
    let customfield10015: JSONNull?
    let customfield10005: JSONNull?
    let customfield10006: JSONNull?
    let customfield10007: JSONNull?
    let security: JSONNull?
    let customfield10008: JSONNull?
    let customfield10009: JSONNull?
    let attachment: [Attachment]?
    let summary: String?
    let customfield10080: [Customfield10]?
    let customfield10081: JSONNull?
    let customfield10082: Double?
    let customfield10083: JSONNull?
    let customfield10088: JSONNull?
    let customfield10000: Customfield10000?
    let customfield10001: JSONNull?
    let customfield10089: JSONNull?
    let customfield10002: JSONNull?
    let customfield10003: JSONNull?
    let customfield10004: JSONNull?
    let customfield10116: JSONNull?
    let environment: JSONNull?
    let customfield10117: JSONNull?
    let customfield10118: JSONNull?
    let duedate: String?
    let comment: WorklogClass?

    enum CodingKeys: String, CodingKey {
        case statuscategorychangedate = "statuscategorychangedate"
        case customfield10070 = "customfield_10070"
        case customfield10071 = "customfield_10071"
        case customfield10074 = "customfield_10074"
        case customfield10075 = "customfield_10075"
        case customfield10076 = "customfield_10076"
        case fixVersions = "fixVersions"
        case resolution = "resolution"
        case customfield10079 = "customfield_10079"
        case customfield10104 = "customfield_10104"
        case customfield10105 = "customfield_10105"
        case customfield10106 = "customfield_10106"
        case customfield10107 = "customfield_10107"
        case lastViewed = "lastViewed"
        case customfield10060 = "customfield_10060"
        case customfield10061 = "customfield_10061"
        case customfield10062 = "customfield_10062"
        case customfield10063 = "customfield_10063"
        case customfield10064 = "customfield_10064"
        case customfield10065 = "customfield_10065"
        case customfield10100 = "customfield_10100"
        case priority = "priority"
        case customfield10101 = "customfield_10101"
        case customfield10068 = "customfield_10068"
        case customfield10102 = "customfield_10102"
        case customfield10069 = "customfield_10069"
        case customfield10103 = "customfield_10103"
        case labels = "labels"
        case timeestimate = "timeestimate"
        case aggregatetimeoriginalestimate = "aggregatetimeoriginalestimate"
        case versions = "versions"
        case issuelinks = "issuelinks"
        case assignee = "assignee"
        case status = "status"
        case components = "components"
        case customfield10055 = "customfield_10055"
        case customfield10056 = "customfield_10056"
        case customfield10057 = "customfield_10057"
        case customfield10058 = "customfield_10058"
        case customfield10059 = "customfield_10059"
        case aggregatetimeestimate = "aggregatetimeestimate"
        case creator = "creator"
        case subtasks = "subtasks"
        case customfield10160 = "customfield_10160"
        case customfield10040 = "customfield_10040"
        case customfield10161 = "customfield_10161"
        case customfield10162 = "customfield_10162"
        case customfield10041 = "customfield_10041"
        case customfield10163 = "customfield_10163"
        case customfield10042 = "customfield_10042"
        case reporter = "reporter"
        case customfield10043 = "customfield_10043"
        case aggregateprogress = "aggregateprogress"
        case customfield10044 = "customfield_10044"
        case customfield10045 = "customfield_10045"
        case customfield10159 = "customfield_10159"
        case customfield10038 = "customfield_10038"
        case customfield10039 = "customfield_10039"
        case progress = "progress"
        case votes = "votes"
        case worklog = "worklog"
        case issuetype = "issuetype"
        case timespent = "timespent"
        case customfield10030 = "customfield_10030"
        case customfield10031 = "customfield_10031"
        case project = "project"
        case customfield10032 = "customfield_10032"
        case customfield10033 = "customfield_10033"
        case customfield10034 = "customfield_10034"
        case aggregatetimespent = "aggregatetimespent"
        case customfield10035 = "customfield_10035"
        case customfield10036 = "customfield_10036"
        case customfield10158 = "customfield_10158"
        case customfield10037 = "customfield_10037"
        case customfield10027 = "customfield_10027"
        case customfield10028 = "customfield_10028"
        case customfield10029 = "customfield_10029"
        case resolutiondate = "resolutiondate"
        case workratio = "workratio"
        case watches = "watches"
        case created = "created"
        case customfield10020 = "customfield_10020"
        case customfield10021 = "customfield_10021"
        case customfield10022 = "customfield_10022"
        case customfield10023 = "customfield_10023"
        case customfield10016 = "customfield_10016"
        case customfield10017 = "customfield_10017"
        case customfield10018 = "customfield_10018"
        case customfield10019 = "customfield_10019"
        case updated = "updated"
        case customfield10090 = "customfield_10090"
        case customfield10091 = "customfield_10091"
        case customfield10092 = "customfield_10092"
        case customfield10093 = "customfield_10093"
        case customfield10094 = "customfield_10094"
        case timeoriginalestimate = "timeoriginalestimate"
        case customfield10095 = "customfield_10095"
        case customfield10096 = "customfield_10096"
        case customfield10097 = "customfield_10097"
        case fieldsDescription = "description"
        case customfield10010 = "customfield_10010"
        case customfield10098 = "customfield_10098"
        case customfield10099 = "customfield_10099"
        case customfield10014 = "customfield_10014"
        case timetracking = "timetracking"
        case customfield10015 = "customfield_10015"
        case customfield10005 = "customfield_10005"
        case customfield10006 = "customfield_10006"
        case customfield10007 = "customfield_10007"
        case security = "security"
        case customfield10008 = "customfield_10008"
        case customfield10009 = "customfield_10009"
        case attachment = "attachment"
        case summary = "summary"
        case customfield10080 = "customfield_10080"
        case customfield10081 = "customfield_10081"
        case customfield10082 = "customfield_10082"
        case customfield10083 = "customfield_10083"
        case customfield10088 = "customfield_10088"
        case customfield10000 = "customfield_10000"
        case customfield10001 = "customfield_10001"
        case customfield10089 = "customfield_10089"
        case customfield10002 = "customfield_10002"
        case customfield10003 = "customfield_10003"
        case customfield10004 = "customfield_10004"
        case customfield10116 = "customfield_10116"
        case environment = "environment"
        case customfield10117 = "customfield_10117"
        case customfield10118 = "customfield_10118"
        case duedate = "duedate"
        case comment = "comment"
    }
}

// MARK: - Progress
struct Progress: Codable {
    let progress: Int?
    let total: Int?

    enum CodingKeys: String, CodingKey {
        case progress = "progress"
        case total = "total"
    }
}

// MARK: - Creator
struct Creator: Codable {
    let creatorSelf: String?
    let name: NameEnum?
    let key: NameEnum?
    let accountID: AccountID?
    let emailAddress: String?
    let avatarUrls: AvatarUrls?
    let displayName: DisplayName?
    let active: Bool?
    let timeZone: TimeZone?
    let accountType: AccountType?

    enum CodingKeys: String, CodingKey {
        case creatorSelf = "self"
        case name = "name"
        case key = "key"
        case accountID = "accountId"
        case emailAddress = "emailAddress"
        case avatarUrls = "avatarUrls"
        case displayName = "displayName"
        case active = "active"
        case timeZone = "timeZone"
        case accountType = "accountType"
    }
}

enum AccountID: String, Codable {
    case the5Af9D8715F0D5B06C28Aa781 = "5af9d8715f0d5b06c28aa781"
    case the5C3F67A4Cfa94F5E973Af1E4 = "5c3f67a4cfa94f5e973af1e4"
    case the5C4Acf75825530450D75Addd = "5c4acf75825530450d75addd"
    case the5C78F0D4F3A7Ed3624D2197B = "5c78f0d4f3a7ed3624d2197b"
    case the5C78F0D5B1D0332Fe18704E0 = "5c78f0d5b1d0332fe18704e0"
    case the5C78F0D62A4C4463B68C9Ec7 = "5c78f0d62a4c4463b68c9ec7"
    case the5C78F0D7Cf74864794A39266 = "5c78f0d7cf74864794a39266"
    case the5C78F103Efc9686293Ac1B43 = "5c78f103efc9686293ac1b43"
    case the5C78F1050983052Ff787335E = "5c78f1050983052ff787335e"
    case the5Dad7928Ed37210C34Fc4701 = "5dad7928ed37210c34fc4701"
}

enum AccountType: String, Codable {
    case atlassian = "atlassian"
}

// MARK: - AvatarUrls
struct AvatarUrls: Codable {
    let the48X48: String?
    let the24X24: String?
    let the16X16: String?
    let the32X32: String?

    enum CodingKeys: String, CodingKey {
        case the48X48 = "48x48"
        case the24X24 = "24x24"
        case the16X16 = "16x16"
        case the32X32 = "32x32"
    }
}

enum DisplayName: String, Codable {
    case anthonyVerveckenOtmgrouBe = "anthony.vervecken@otmgrou.be"
    case arnaudPetillon = "arnaud.petillon"
    case davidMandelier = "david.mandelier"
    case eddyVandevivere = "eddy.vandevivere"
    case fm = "FM"
    case frankVanDamme = "Frank Van Damme"
    case lanceKhattar = "lance.khattar"
    case lucasTenhoorn = "lucas.tenhoorn"
    case robinVanacoleyen = "robin.vanacoleyen"
    case tassoKypirtidis = "tasso.kypirtidis"
}

enum NameEnum: String, Codable {
    case admin = "admin"
    case anthonyVervecken = "anthony.vervecken"
    case arnaudPetillon = "arnaud.petillon"
    case davidMandelier = "david.mandelier"
    case deltap0204 = "deltap0204"
    case eddyVandevivere = "eddy.vandevivere"
    case lanceKhattar = "lance.khattar"
    case lucasTenhoorn = "lucas.tenhoorn"
    case robinVanacoleyen = "robin.vanacoleyen"
    case tassoKypirtidis = "tasso.kypirtidis"
}

enum TimeZone: String, Codable {
    case europeBerlin = "Europe/Berlin"
    case europeBrussels = "Europe/Brussels"
}

// MARK: - Attachment
struct Attachment: Codable {
    let attachmentSelf: String?
    let id: String?
    let filename: String?
    let author: Creator?
    let created: String?
    let size: Int?
    let mimeType: MIMEType?
    let content: String?
    let thumbnail: String?

    enum CodingKeys: String, CodingKey {
        case attachmentSelf = "self"
        case id = "id"
        case filename = "filename"
        case author = "author"
        case created = "created"
        case size = "size"
        case mimeType = "mimeType"
        case content = "content"
        case thumbnail = "thumbnail"
    }
}

enum MIMEType: String, Codable {
    case applicationPDF = "application/pdf"
    case binaryOctetStream = "binary/octet-stream"
    case imageJPEG = "image/jpeg"
    case videoMp4 = "video/mp4"
}

// MARK: - WorklogClass
struct WorklogClass: Codable {
    let comments: [CommentElement]?
    let maxResults: Int?
    let total: Int?
    let startAt: Int?
    let worklogs: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case comments = "comments"
        case maxResults = "maxResults"
        case total = "total"
        case startAt = "startAt"
        case worklogs = "worklogs"
    }
}

// MARK: - CommentElement
struct CommentElement: Codable {
    let commentSelf: String?
    let id: String?
    let author: Creator?
    let body: Body?
    let updateAuthor: Creator?
    let created: String?
    let updated: String?
    let jsdPublic: Bool?

    enum CodingKeys: String, CodingKey {
        case commentSelf = "self"
        case id = "id"
        case author = "author"
        case body = "body"
        case updateAuthor = "updateAuthor"
        case created = "created"
        case updated = "updated"
        case jsdPublic = "jsdPublic"
    }
}

// MARK: - Body
struct Body: Codable {
    let content: [BodyContent]?
    let type: BodyType?
    let version: Int?

    enum CodingKeys: String, CodingKey {
        case content = "content"
        case type = "type"
        case version = "version"
    }
}

// MARK: - BodyContent
struct BodyContent: Codable {
    let content: [PurpleContent]?
    let type: FluffyType?

    enum CodingKeys: String, CodingKey {
        case content = "content"
        case type = "type"
    }
}

// MARK: - PurpleContent
struct PurpleContent: Codable {
    let text: String?
    let type: PurpleType?
    let attrs: PurpleAttrs?

    enum CodingKeys: String, CodingKey {
        case text = "text"
        case type = "type"
        case attrs = "attrs"
    }
}

// MARK: - PurpleAttrs
struct PurpleAttrs: Codable {
    let text: String?

    enum CodingKeys: String, CodingKey {
        case text = "text"
    }
}

enum PurpleType: String, Codable {
    case hardBreak = "hardBreak"
    case listItem = "listItem"
    case media = "media"
    case tableRow = "tableRow"
    case text = "text"
}

enum FluffyType: String, Codable {
    case bulletList = "bulletList"
    case mediaGroup = "mediaGroup"
    case paragraph = "paragraph"
    case table = "table"
}

enum BodyType: String, Codable {
    case doc = "doc"
}

enum Customfield10000: String, Codable {
    case empty = "{}"
}

// MARK: - Customfield10018
struct Customfield10018: Codable {
    let hasEpicLinkFieldDependency: Bool?
    let showField: Bool?
    let nonEditableReason: NonEditableReason?

    enum CodingKeys: String, CodingKey {
        case hasEpicLinkFieldDependency = "hasEpicLinkFieldDependency"
        case showField = "showField"
        case nonEditableReason = "nonEditableReason"
    }
}

// MARK: - NonEditableReason
struct NonEditableReason: Codable {
    let reason: Reason?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case reason = "reason"
        case message = "message"
    }
}

enum Reason: String, Codable {
    case pluginLicenseError = "PLUGIN_LICENSE_ERROR"
}

// MARK: - Customfield10
struct Customfield10: Codable {
    let customfield10_Self: String?
    let value: String?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case customfield10_Self = "self"
        case value = "value"
        case id = "id"
    }
}

// MARK: - DescriptionClass
struct DescriptionClass: Codable {
    let version: Int?
    let type: BodyType?
    let content: [DescriptionContent]?

    enum CodingKeys: String, CodingKey {
        case version = "version"
        case type = "type"
        case content = "content"
    }
}

// MARK: - DescriptionContent
struct DescriptionContent: Codable {
    let type: FluffyType?
    let content: [FluffyContent]?
    let attrs: FluffyAttrs?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case content = "content"
        case attrs = "attrs"
    }
}

// MARK: - FluffyAttrs
struct FluffyAttrs: Codable {
    let isNumberColumnEnabled: Bool?
    let layout: String?

    enum CodingKeys: String, CodingKey {
        case isNumberColumnEnabled = "isNumberColumnEnabled"
        case layout = "layout"
    }
}

// MARK: - FluffyContent
struct FluffyContent: Codable {
    let type: PurpleType?
    let text: String?
    let content: [TentacledContent]?
    let attrs: TentacledAttrs?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case text = "text"
        case content = "content"
        case attrs = "attrs"
    }
}

// MARK: - TentacledAttrs
struct TentacledAttrs: Codable {
    let id: String?
    let type: String?
    let collection: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case collection = "collection"
    }
}

// MARK: - TentacledContent
struct TentacledContent: Codable {
    let type: String?
    let content: [StickyContent]?
    let attrs: Timetracking?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case content = "content"
        case attrs = "attrs"
    }
}

// MARK: - Timetracking
struct Timetracking: Codable {
}

// MARK: - StickyContent
struct StickyContent: Codable {
    let type: String?
    let text: String?
    let content: [IndigoContent]?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case text = "text"
        case content = "content"
    }
}

// MARK: - IndigoContent
struct IndigoContent: Codable {
    let type: PurpleType?
    let text: String?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case text = "text"
    }
}

// MARK: - Issuelink
struct Issuelink: Codable {
    let id: String?
    let issuelinkSelf: String?
    let type: TypeClass?
    let outwardIssue: WardIssue?
    let inwardIssue: WardIssue?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case issuelinkSelf = "self"
        case type = "type"
        case outwardIssue = "outwardIssue"
        case inwardIssue = "inwardIssue"
    }
}

// MARK: - WardIssue
struct WardIssue: Codable {
    let id: String?
    let key: String?
    let wardIssueSelf: String?
    let fields: InwardIssueFields?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case key = "key"
        case wardIssueSelf = "self"
        case fields = "fields"
    }
}

// MARK: - InwardIssueFields
struct InwardIssueFields: Codable {
    let summary: String?
    let status: Status?
    let priority: Priority?
    let issuetype: Issuetype?

    enum CodingKeys: String, CodingKey {
        case summary = "summary"
        case status = "status"
        case priority = "priority"
        case issuetype = "issuetype"
    }
}

// MARK: - Issuetype
struct Issuetype: Codable {
    let issuetypeSelf: String?
    let id: String?
    let issuetypeDescription: IssuetypeDescription?
    let iconURL: String?
    let name: IssuetypeName?
    let subtask: Bool?
    let avatarID: Int?
    let entityID: String?

    enum CodingKeys: String, CodingKey {
        case issuetypeSelf = "self"
        case id = "id"
        case issuetypeDescription = "description"
        case iconURL = "iconUrl"
        case name = "name"
        case subtask = "subtask"
        case avatarID = "avatarId"
        case entityID = "entityId"
    }
}

enum IssuetypeDescription: String, Codable {
    case suivezLesTâches = "Suivez les tâches."
    case tasksTrackSmallDistinctPiecesOfWork = "Tasks track small, distinct pieces of work."
}

enum IssuetypeName: String, Codable {
    case fluviusVehicle = "Fluvius Vehicle"
    case werkfiche = "Werkfiche"
}

// MARK: - Priority
struct Priority: Codable {
    let prioritySelf: String?
    let iconURL: String?
    let name: PriorityName?
    let id: String?
    let priorityDescription: PriorityDescription?

    enum CodingKeys: String, CodingKey {
        case prioritySelf = "self"
        case iconURL = "iconUrl"
        case name = "name"
        case id = "id"
        case priorityDescription = "description"
    }
}

enum PriorityName: String, Codable {
    case done = "Done"
    case medium = "Medium"
}

enum PriorityDescription: String, Codable {
    case workHasBeenCompletedOnThisIssue = "Work has been completed on this issue."
}

// MARK: - Status
struct Status: Codable {
    let statusSelf: String?
    let statusDescription: String?
    let iconURL: String?
    let name: StatusName?
    let id: String?
    let statusCategory: StatusCategory?

    enum CodingKeys: String, CodingKey {
        case statusSelf = "self"
        case statusDescription = "description"
        case iconURL = "iconUrl"
        case name = "name"
        case id = "id"
        case statusCategory = "statusCategory"
    }
}

enum StatusName: String, Codable {
    case done = "Done"
    case inProgress = "In Progress"
    case toDo = "To Do"
}

// MARK: - StatusCategory
struct StatusCategory: Codable {
    let statusCategorySelf: String?
    let id: Int?
    let key: StatusCategoryKey?
    let colorName: ColorName?
    let name: StatusName?

    enum CodingKeys: String, CodingKey {
        case statusCategorySelf = "self"
        case id = "id"
        case key = "key"
        case colorName = "colorName"
        case name = "name"
    }
}

enum ColorName: String, Codable {
    case blueGray = "blue-gray"
    case green = "green"
    case yellow = "yellow"
}

enum StatusCategoryKey: String, Codable {
    case done = "done"
    case indeterminate = "indeterminate"
    case new = "new"
}

// MARK: - TypeClass
struct TypeClass: Codable {
    let id: String?
    let name: String?
    let inward: String?
    let outward: String?
    let typeSelf: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case inward = "inward"
        case outward = "outward"
        case typeSelf = "self"
    }
}

// MARK: - Project
struct Project: Codable {
    let projectSelf: String?
    let id: String?
    let key: ProjectKey?
    let name: ProjectName?
    let projectTypeKey: ProjectTypeKey?
    let simplified: Bool?
    let avatarUrls: AvatarUrls?

    enum CodingKeys: String, CodingKey {
        case projectSelf = "self"
        case id = "id"
        case key = "key"
        case name = "name"
        case projectTypeKey = "projectTypeKey"
        case simplified = "simplified"
        case avatarUrls = "avatarUrls"
    }
}

enum ProjectKey: String, Codable {
    case wt = "WT"
}

enum ProjectName: String, Codable {
    case wrapTeam = "Wrap Team"
}

enum ProjectTypeKey: String, Codable {
    case software = "software"
}

// MARK: - Votes
struct Votes: Codable {
    let votesSelf: String?
    let votes: Int?
    let hasVoted: Bool?

    enum CodingKeys: String, CodingKey {
        case votesSelf = "self"
        case votes = "votes"
        case hasVoted = "hasVoted"
    }
}

// MARK: - Watches
struct Watches: Codable {
    let watchesSelf: String?
    let watchCount: Int?
    let isWatching: Bool?

    enum CodingKeys: String, CodingKey {
        case watchesSelf = "self"
        case watchCount = "watchCount"
        case isWatching = "isWatching"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
