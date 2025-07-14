package pxlwolf_odin
import "core:log"
import "core:strings"
import "core:mem"
import "core:fmt"

_ :: mem
_ :: fmt

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

    log_level: log.Level = .Debug

    file_logger := create_file_logger(log_level)
    defer log.destroy_file_logger(file_logger)

    console_logger := log.create_console_logger()
    defer log.destroy_console_logger(console_logger)

    multi_logger := log.create_multi_logger(file_logger, console_logger)
    defer log.destroy_multi_logger(multi_logger)
    context.logger = multi_logger

    log.info("------------------------")
    log.info("Welcome to PxlWolf")
    log.info("------------------------")


    /// load config

    config := load_config("assets/config/pxlwolf.ini") or_else DEFAULT_CONFIG

    print_config(config)

    /// load and parse the map

    the_map: Map = parse_map("assets/levels/pxlwolf.ldtk")
    // debug_map(the_map)

    level_path := strings.concatenate({"assets/levels/", the_map.levels[0].path})
    defer delete(level_path)
    // the_level: LevelInstance = parse_level(level_path)
    // debug_level(the_level)


    /// PxlWolf exit

    log.info("PxlWolf shutdown")
}
