package pxlwolf_odin

import "core:encoding/json"
import "core:os"
import "core:fmt"
import "core:log"

parse_map :: proc(path: string, alloc := context.allocator) -> Map {
    m: Map
    jdata, ok := os.read_entire_file(path, alloc)
    defer delete(jdata)
    if !ok {
        fmt.print("Failed to read file: ", path, "\n")
        return m
    }

    err := json.unmarshal(jdata, &m, allocator = alloc)
    if err != nil {
        fmt.print("Failed to unmarshal JSON: ", err, "\n")
        return m
    }
    return m
}

debug_map :: proc(a_map: Map) {
    for level in a_map.levels {
        log.debugf("Level: '{}'", level.identifier)
        log.debugf("Level-path: '{}'", level.path)
    }
}

parse_level :: proc(path: string, alloc := context.allocator) -> Level {
    l: Level
    jdata, ok := os.read_entire_file(path, alloc)
    defer delete(jdata)
    if !ok {
        fmt.print("Failed to read file: ", path, "\n")
        return l
    }

    err := json.unmarshal(jdata, &l, allocator = alloc)
    if err != nil {
        fmt.print("Failed to unmarshal JSON: ", err, "\n")
        return l
    }
    return l
}

debug_level :: proc(a_level: Level) {
    log.debugf("Level: '{}'", a_level.identifier)
    for layer in a_level.layer_instances {
        log.debugf("layer_identifier: '{}'", layer.identifier)
        log.debugf("layer-type: '{}'", layer.type)
    }
}

// Structures

// Map

Map :: struct {
    levels:             []MapLevel          `json:"levels"`,
}

MapDefs :: struct {
    layers:             []MapLayer          `json:"layers"`,
    entities:           []MapEntity         `json:"entities"`,
}

MapLayer :: struct {
    layer_type:         string              `json:"type"`,
    int_grid_values:    []MapIntGridValue   `json:"intGridValues"`,
}

MapEntity :: struct {
    identifier:         string              `json:"identifier"`,
}

MapIntGridValue :: struct {
    value:              i32                 `json:"value"`,
}

MapLevel :: struct {
    identifier:         string              `json:"identifier"`,
    path:               string              `json:"externalRelPath"`,
}

// Level

Level :: struct {
    identifier:         string              `json:"identifier"`,
    layer_instances:    []LayerInstance     `json:"layerInstances"`,
}

LayerInstance :: struct {
    identifier:         string              `json:"__identifier"`,
    type:               string              `json:"__type"`,
}
