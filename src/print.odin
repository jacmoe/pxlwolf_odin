package pxlwolf_odin

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
