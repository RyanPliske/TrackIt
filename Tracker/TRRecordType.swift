enum TRRecordType {
    case TrackAction
    case TrackUrge
    
    var description: String {
        switch self {
        case .TrackAction:
            return "action"
        case .TrackUrge:
            return "urge"
        }
    }
}
