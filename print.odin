package pxlwolf_odin

import "core:fmt"
import "core:log"


print_welcom :: proc() {
    log.info(" *******************************")
    log.info(" **---------------------------**")
    log.info("** Welcome to PxlWolf        **")
    log.info("**---------------------------**")
    log.info("*******************************")
}

print_goodby :: proc() {
    log.info("**---------------------------**")
    log.info("** PxlWolf shutdown          **")
    log.info("**---------------------------**")
}

print_config :: proc(config: Config) {
    graphics := config.graphics
    game := config.game

    log.info()
    log.info("Config")
    log.info("-------------------------------")
    log.info("Graphics:")
    log.infof("Window resolution: {}x{}", graphics.window_width, graphics.window_height)
    log.infof("Scale: {}", graphics.scale)
    log.infof("Fullscreen: {}", graphics.fullscreen)
    log.info("-------------------------------")
    log.info("Game:")
    log.infof("Episode: {}", game.episode)
    log.infof("Level: {}", game.level)
    log.infof("Dist: {}", game.dist)
    log.info("-------------------------------")
    log.info()
}

debug_print_map :: proc(a_map: Map) {
    for level in a_map.levels {
        log.debugf("Level: '{}' ({})", level.name, level.path)
    }
}

debug_print_level :: proc(a_level: LevelInstance) {
    log.debugf("Level: '{}'", a_level.name)
    for layer_instance in a_level.layer_instances {
        log.debugf("Layer: '{}' of type '{}'", layer_instance.name, layer_instance.type)
        if layer_instance.type == .IntGrid {
            //log.debugf("Int Grid: {}", layer_instance)
        }
        for entity_instance in layer_instance.entities {
            #partial switch entity_instance.type {
            case .PlayerStart:
                log.debugf("PlayerStart at [{},{}]", entity_instance.position.x, entity_instance.position.y)
            case .LevelEnd:
                log.debugf("LevelEnd at [{},{}]", entity_instance.position.x, entity_instance.position.y)
            case .Static:
                log.debugf("Static at [{},{}]", entity_instance.position.x, entity_instance.position.y)
            case .Pickup:
                log.debugf("Pickup at [{},{}]", entity_instance.position.x, entity_instance.position.y)
            case .Key:
                log.debugf("Key at [{},{}]", entity_instance.position.x, entity_instance.position.y)
            case .Enemy:
                log.debugf("Enemy at [{},{}]", entity_instance.position.x, entity_instance.position.y)
            }
            for field_instance in entity_instance.field_instances {
                log.debugf(
                    "Field value: {} of type: '{}' in group: {}",
                    field_instance.value,
                    fmt.tprintf("{}", field_instance.type),
                    field_instance.group,
                )
            }
        }
    }
}
