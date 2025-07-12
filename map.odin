package pxlwolf_odin

import "core:encoding/json"
import "core:fmt"
import "core:log"
import linalg "core:math/linalg"
import "core:os"

parse_map :: proc(path: string, alloc := context.temp_allocator) -> Map {
    m: Map
    jdata, ok := os.read_entire_file(path, alloc)
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
        log.debugf("Level: '{}' ({})", level.identifier, level.path)
    }
}

parse_level :: proc(path: string, alloc := context.temp_allocator) -> LevelInstance {
    l: LevelInstance
    jdata, ok := os.read_entire_file(path, alloc)
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

debug_level :: proc(a_level: LevelInstance) {
    log.debugf("Level: '{}'", a_level.identifier)
    for layer_instance in a_level.layer_instances {
        log.debugf("Layer: '{}' of type '{}'", layer_instance.identifier, layer_instance.type)
        if layer_instance.type == .IntGrid {
            //log.debugf("Int Grid: {}", layer_instance)
        }
        for entity_instance in layer_instance.entity_instances {
            #partial switch entity_instance.identifier {
            case .PlayerStart:
                log.debugf("PlayerStart at [{},{}]", entity_instance.grid.([]i32)[0], entity_instance.grid.([]i32)[1])
            case .LevelEnd:
                log.debugf("LevelEnd at [{},{}]", entity_instance.grid.([]i32)[0], entity_instance.grid.([]i32)[1])
            case .Static:
                log.debugf("Static at [{},{}]", entity_instance.grid.([]i32)[0], entity_instance.grid.([]i32)[1])
            case .Pickup:
                log.debugf("Pickup at [{},{}]", entity_instance.grid.([]i32)[0], entity_instance.grid.([]i32)[1])
            case .Key:
                log.debugf("Key at [{},{}]", entity_instance.grid.([]i32)[0], entity_instance.grid.([]i32)[1])
            case .Enemy:
                log.debugf("Enemy at [{},{}]", entity_instance.grid.([]i32)[0], entity_instance.grid.([]i32)[1])
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

// Structures

// Map

Map :: struct {
    levels: []Level `json:"levels"`,
}

Level :: struct {
    identifier: string `json:"identifier"`,
    path:       string `json:"externalRelPath"`,
}

// Level Instance

LevelInstance :: struct {
    identifier:      string `json:"identifier"`,
    layer_instances: []LayerInstance `json:"layerInstances"`,
}

LevelInstance_fixed :: struct {
    identifier:      string,
    layer_instances: []LayerInstance_fixed,
}

LayerInstanceType :: enum {
    Entities,
    IntGrid,
}

LayerInstanceIdentifier :: enum {
    Walls,
    Ceiling,
    Floor,
    Entities,
}

LayerInstance :: struct {
    identifier:       LayerInstanceIdentifier `json:"__identifier"`,
    type:             LayerInstanceType `json:"__type"`,
    entity_instances: []EntityInstance `json:"entityInstances"`,
    int_grid:         []i32 `json:"intGridCsv"`,
}

LayerInstance_fixed :: struct {
    identifier:       LayerInstanceIdentifier,
    type:             LayerInstanceType,
    entity_instances: []EntityInstance_fixed,
    int_grid:         []i32,
}

EntityInstanceGroup :: enum {
    Static,
    PlayerStart,
    LevelEnd,
    Pickup,
    Enemy,
    Key,
    Float,
}

ArrayOrString :: union {
    []i32,
    string,
}

EntityInstance :: struct {
    identifier:      EntityInstanceGroup `json:"__identifier"`,
    grid:            ArrayOrString `json:"__grid"`,
    field_instances: []FieldInstance `json:"fieldInstances"`,
}

EntityInstance_fixed :: struct {
    identifier:      EntityInstanceGroup,
    position:        linalg.Vector2f32,
    field_instances: []FieldInstance_fixed,
}

FieldInstanceGroup :: enum {
    type,
    ViewerAngle,
    next_level,
}

FieldInstance :: struct {
    group: FieldInstanceGroup `json:"__identifier"`,
    type:  string `json:"__type"`,
    value: json.Value `json:"__value"`,
}

FieldInstance_fixed :: struct {
    group:    FieldInstanceGroup,
    type:     EntityInstanceGroup,
    instance: string,
    value:    f32,
}
