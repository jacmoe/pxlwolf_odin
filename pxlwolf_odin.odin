package pxlwolf_odin

import "core:log"
import "core:strings"

main :: proc() {

    context.logger = create_logger()
    defer log.destroy_multi_logger(context.logger)

    log.info("Welcome to PxlWolf")

    the_map: Map = parse_map("assets/levels/pxlwolf.ldtk")
    //debug_map(the_map)

    level_path := strings.concatenate({"assets/levels/", the_map.levels[0].path})
    defer delete(level_path)
    the_level: Level = parse_level(level_path)
    debug_level(the_level)

    log.info("PxlWolf shutdown")
}
