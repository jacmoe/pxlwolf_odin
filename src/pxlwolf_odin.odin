package pxlwolf_odin
import "core:fmt"
import "core:log"
import "core:mem"

_ :: mem
_ :: fmt

// globals
level_map: map[string]string

the_map :: Map
config :: Config


main :: proc() {

    when ODIN_DEBUG {
        track: mem.Tracking_Allocator
        mem.tracking_allocator_init(&track, context.allocator)
        context.allocator = mem.tracking_allocator(&track)

        defer {
            if len(track.allocation_map) > 0 {
                fmt.eprintf("=== %v allocations not freed: ===\n", len(track.allocation_map))
                for _, entry in track.allocation_map {
                    fmt.eprintf("- %v bytes @ %v\n", entry.size, entry.location)
                }
            }
            if len(track.bad_free_array) > 0 {
                fmt.eprintf("=== %v incorrect frees: ===\n", len(track.bad_free_array))
                for entry in track.bad_free_array {
                    fmt.eprintf("- %p @ %v\n", entry.memory, entry.location)
                }
            }
            mem.tracking_allocator_destroy(&track)
        }
    }

    /// set up logging

    log_level: log.Level
    if ODIN_DEBUG {
        log_level = .Debug
    } else {
        log_level = .Info
    }

    file_logger := create_file_logger(log_level)
    defer log.destroy_file_logger(file_logger)

    console_logger := log.create_console_logger()
    defer log.destroy_console_logger(console_logger)

    multi_logger := log.create_multi_logger(file_logger, console_logger)
    defer log.destroy_multi_logger(multi_logger)
    context.logger = multi_logger

    print_welcom()


    /// load and parse the map

    the_map := load_map("pxlwolf")
    // debug_print_map(the_map)

    for level in the_map.levels {
        level_map[level.name] = level.path
    }
    defer delete(level_map)


    /// load config

    config := load_config("assets/config/pxlwolf.ini") or_else DEFAULT_CONFIG

    print_config(config)


    // load the level
    the_level: LevelInstance = load_level(config.game.level)
    _ = the_level
    // debug_print_level(the_level)

    /// PxlWolf exit

    print_goodby()
}
