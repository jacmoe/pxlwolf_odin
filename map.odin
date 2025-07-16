package pxlwolf_odin

import "core:encoding/json"
import "core:fmt"
import "core:log"
import linalg "core:math/linalg"
import "core:os"


load_map :: proc(map_name: string, alloc := context.temp_allocator) -> Map {
    m: Map
    m_raw: Map_raw
    map_exists: bool = true

    map_file_path := fmt.tprintf("assets/levels/{}.{}", map_name, "json")
    if !os.exists(map_file_path) {
        log.infof("We have not yet generated a map")
        map_exists = false
        map_file_path = fmt.tprintf("assets/levels/{}.{}", map_name, "ldtk")
    }

    jdata, ok := os.read_entire_file(map_file_path, alloc)
    if !ok {
        log.fatalf("Failed to read file: ", map_name)
        os.exit(-1)
    }

    if map_exists {
        _ = m_raw
        err := json.unmarshal(jdata, &m, allocator = alloc)
        if err != nil {
            log.fatalf("Failed to unmarshal JSON: ", err)
            os.exit(-1)
        }
    } else {
        err := json.unmarshal(jdata, &m_raw, allocator = alloc)
        if err != nil {
            log.fatalf("Failed to unmarshal JSON: ", err)
            os.exit(-1)
        }

        // create a Map
        m.levels = make([]Level, len(m_raw.levels), alloc)
        for level, i in m_raw.levels {
            m.levels[i].name = level.identifier
            m.levels[i].path = level.path
        }

        // marshall the Map
        marshall_json_data, marshall_err := json.marshal(
        m,
        {
            // Adds indentation etc
            pretty         = true,

            // Output enum member names instead of numeric value.
            use_enum_names = true,
        },
        )

        if marshall_err != nil {
            fmt.eprintfln("Unable to marshal JSON: %v", marshall_err)
            os.exit(1)
        }

        // write map to file
        write_path := fmt.tprintf("assets/levels/{}.{}", map_name, "json")
        werr := os.write_entire_file_or_err(write_path, marshall_json_data)

        if werr != nil {
            fmt.eprintfln("Unable to write file: %v", werr)
            os.exit(1)
        }

    }

    return m
}

load_level :: proc(level_name: string, alloc := context.temp_allocator) -> LevelInstance {
    l: LevelInstance
    l_raw: LevelInstance_raw
    level_exists: bool = true

    level_file_path := fmt.tprintf("assets/levels/{}.{}", level_name, "json")
    if !os.exists(level_file_path) {
        log.infof("We have not yet generated a map")
        level_exists = false
        level_file_path = fmt.tprintf("assets/levels/{}.{}", level_name, "ldtk")
    }

    jdata, ok := os.read_entire_file(level_file_path, alloc)

    if !ok {
        log.fatalf("Failed to read file: ", level_file_path)
        os.exit(-1)
    }

    err := json.unmarshal(jdata, &l_raw, allocator = alloc)
    if err != nil {
        log.fatalf("Failed to unmarshal JSON: ", err)
        os.exit(-1)
    }
    return l
}

// Structures


// Map
Map :: struct {
    levels: []Level,
}

Level :: struct {
    name: string,
    path: string,
}

Map_raw :: struct {
    levels: []Level_raw `json:"levels"`,
}

Level_raw :: struct {
    identifier: string `json:"identifier"`,
    path:       string `json:"externalRelPath"`,
}


// Level Instance
LevelInstance :: struct {
    name:            string,
    layer_instances: []LayerInstance,
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

FieldInstanceGroup :: enum {
    type,
    ViewerAngle,
    next_level,
}

LayerInstance :: struct {
    name:     LayerInstanceIdentifier,
    type:     LayerInstanceType,
    entities: []EntityInstance,
    grid:     []i32,
}

EntityInstance :: struct {
    type:            EntityInstanceGroup,
    position:        linalg.Vector2f32,
    field_instances: []FieldInstance,
}

FieldInstance :: struct {
    group:    FieldInstanceGroup,
    type:     EntityInstanceGroup,
    instance: string,
    value:    f32,
}

LevelInstance_raw :: struct {
    identifier:      string `json:"identifier"`,
    layer_instances: []LayerInstance_raw `json:"layerInstances"`,
}

LayerInstance_raw :: struct {
    identifier:       LayerInstanceIdentifier `json:"__identifier"`,
    type:             LayerInstanceType `json:"__type"`,
    entity_instances: []EntityInstance `json:"entityInstances"`,
    int_grid:         []i32 `json:"intGridCsv"`,
}

EntityInstance_raw :: struct {
    identifier:      EntityInstanceGroup `json:"__identifier"`,
    grid:            ArrayOrString `json:"__grid"`,
    field_instances: []FieldInstance_raw `json:"fieldInstances"`,
}

FieldInstance_raw :: struct {
    group: FieldInstanceGroup `json:"__identifier"`,
    type:  string `json:"__type"`,
    value: json.Value `json:"__value"`,
}
