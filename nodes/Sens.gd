class_name Sens
enum Values {
    VERTICALE_H,
    HORIZONTALE_D,
    VERTICALE_B,
    HORIZONTALE_G
}

static func getNext(actual: int) -> Values :
    if actual < 4:
        return actual + 1
    return 0