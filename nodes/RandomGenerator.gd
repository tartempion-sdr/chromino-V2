class_name RandomGenerator

func _init():
    RANDOM_NUMBER_GENERATOR.randomize()

func newInt() -> int:
    return RANDOM_NUMBER_GENERATOR.randi_range(MIN_RANDOM, MAX_RANDOM)

const RANDOM_NUMBER_GENERATOR: RandomNumberGenerator = RandomNumberGenerator.new()
const MIN_RANDOM: int                                = 0
const MAX_RANDOM: int                                = 79
