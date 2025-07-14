package pxlwolf_odin

import ini "core:encoding/ini"
import "core:log"
import "core:strconv"


ConfigGraphics :: struct {
    window_width:  int,
    window_height: int,
    scale:         int,
    fullscreen:    bool,
}

ConfigGame :: struct {
    episode: int,
    level:   string,
    dist:    f32,
}

Config :: struct {
    game:     ConfigGame,
    graphics: ConfigGraphics,
}

DEFAULT_CONFIG :: Config {
    game     = {1, "Level1", 16},
    graphics = {320, 200, 4, false},
}

Load_Config_Error :: enum {
    None,
    File_Unreadable,
    Invalid_Format,
}

load_config :: proc(path: string) -> (Config, Load_Config_Error) {
    config := Config{}
    the_map, _, ok := ini.load_map_from_path(path, context.temp_allocator)
    if !ok {
        log.warnf("Config load error: file unreadable")
        return Config{}, .File_Unreadable
    }

    for key, value in the_map["graphics"] {
        conv_ok: bool
        switch key {
        case "width":
            config.graphics.window_width, conv_ok = strconv.parse_int(value)
            if !conv_ok {
                log.warn("Graphics width is not a valid integer")
                return config, .Invalid_Format
            }
        case "height":
            config.graphics.window_height, conv_ok = strconv.parse_int(value)
            if !conv_ok {
                log.warn("Graphics height is not a valid integer")
                return config, .Invalid_Format
            }
        case "fullscreen":
            config.graphics.fullscreen, conv_ok = strconv.parse_bool(value)
            if !conv_ok {
                log.warn("Graphics fullscreen is not a valid boolean")
                return config, .Invalid_Format
            }
        case "scale":
            config.graphics.scale, conv_ok = strconv.parse_int(value)
            if !conv_ok {
                log.warn("Graphics scale is not a valid integer")
                return config, .Invalid_Format
            }
        }
    }

    for key, value in the_map["game"] {
        conv_ok: bool
        switch key {
        case "episode":
            config.game.episode, conv_ok = strconv.parse_int(value)
            if !conv_ok {
                log.warn("Game episode is not a valid integer")
                return config, .Invalid_Format
            }
        case "level":
            config.game.level = value
        //TODO: check that the level is valid!
        //     if !conv_ok {
        //         log.warn("Graphics height is not a valid integer")
        //     }
        case "dist":
            config.game.dist, conv_ok = strconv.parse_f32(value)
            if !conv_ok {
                log.warn("Game dist is not a valid float")
                return config, .Invalid_Format
            }
        }
    }
    return config, .None
}

print_config :: proc(config: Config) {
    graphics := config.graphics
    game := config.game

    log.info("Config")
    log.info("------------------------")
    log.info("Graphics:")
    log.infof("Window resolution: {}x{}", graphics.window_width, graphics.window_height)
    log.infof("Scale: {}", graphics.scale)
    log.infof("Fullscreen: {}", graphics.fullscreen)
    log.info("------------------------")
    log.info("Game:")
    log.infof("Episode: {}", game.episode)
    log.infof("Level: {}", game.level)
    log.infof("Dist: {}", game.dist)
    log.info("------------------------")
}
