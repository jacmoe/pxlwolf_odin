package pxlwolf_odin

import "core:encoding/json"
import "core:fmt"
import "core:log"
import linalg "core:math/linalg"
import "core:os"
import "core:path/filepath"


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

    full_level_name := filepath.short_stem(level_map[level_name])

    level_file_path := fmt.tprintf("assets/levels/pxlwolf/{}.{}", full_level_name, "json")
    if !os.exists(level_file_path) {
        level_exists = false
        level_file_path = fmt.tprintf("assets/levels/pxlwolf/{}.{}", full_level_name, "ldtkl")
    }

    jdata, ok := os.read_entire_file(level_file_path, alloc)

    if !ok {
        log.fatalf("Failed to read file: ", level_file_path)
        os.exit(-1)
    }

    if level_exists {
        err := json.unmarshal(jdata, &l, allocator = alloc)
        if err != nil {
            log.fatalf("Failed to unmarshal JSON: ", err)
            os.exit(-1)
        }
    } else {
        err := json.unmarshal(jdata, &l_raw, allocator = alloc)
        if err != nil {
            log.fatalf("Failed to unmarshal JSON: ", err)
            os.exit(-1)
        }

        // create a LevelInstance

        l.name = l_raw.identifier
        l.layer_instances = make([]LayerInstance, len(l_raw.layer_instances), alloc)
        for layer_instance, i in l_raw.layer_instances {
            l.layer_instances[i].name = layer_instance.identifier
            l.layer_instances[i].type = layer_instance.type
            l.layer_instances[i].grid = layer_instance.int_grid
            l.layer_instances[i].entities = make([]EntityInstance, len(layer_instance.entity_instances), alloc)
            for entity_instance, j in layer_instance.entity_instances {
                l.layer_instances[i].entities[j].type = entity_instance.identifier
                the_x := cast(f32)entity_instance.grid.([]i32)[0]
                the_y := cast(f32)entity_instance.grid.([]i32)[1]
                l.layer_instances[i].entities[j].position = linalg.Vector2f32{the_x, the_y}
                l.layer_instances[i].entities[j].field_instances = make(
                    []FieldInstance,
                    len(entity_instance.field_instances),
                    alloc,
                )
                for field_instance, k in entity_instance.field_instances {
                    if field_instance.type == "String" {
                        l.layer_instances[i].entities[j].field_instances[k].str = get_string_from_json_value(
                            field_instance.value,
                        )
                    } else if field_instance.type == "Float" {
                        l.layer_instances[i].entities[j].field_instances[k].flt = get_float_from_json_value(
                            field_instance.value,
                        )
                    } else {
                        str_to_convert := field_instance.value.(json.Array)[0]
                        l.layer_instances[i].entities[j].field_instances[k].str =
                            get_string_from_json_value_array(str_to_convert)
                    }
                }
            }
        }


        // marshall the Map
        marshall_json_data, marshall_err := json.marshal(
                l,
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

        _ = marshall_json_data

        // write map to file
        write_path := fmt.tprintf("assets/levels/pxlwolf/{}.{}", full_level_name, "json")
        werr := os.write_entire_file_or_err(write_path, marshall_json_data)

        if werr != nil {
            fmt.eprintfln("Unable to write file: %v", werr)
            os.exit(1)
        }

    }

    return l
}

get_float_from_json_value :: proc(value: json.Value) -> f32 {
    #partial switch type in value {
    case f64:
        return f32(value.(f64))
    }
    return 0.0
}

get_string_from_json_value :: proc(value: json.Value) -> string {
    #partial switch type in value {
    case string:
        return value.(string)
    }
    return ""
}

get_string_from_json_value_array :: proc(value: json.Value) -> string {
    #partial switch type in value {
    case string:
        return value.(string)
    }
    return ""
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
    None,
    Entities,
    IntGrid,
}

LayerInstanceIdentifier :: enum {
    None,
    Walls,
    Ceiling,
    Floor,
    Entities,
}

EntityInstanceGroup :: enum {
    None,
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
    None,
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
    str: string,
    flt:    f32,
}

LevelInstance_raw :: struct {
    identifier:      string `json:"identifier"`,
    layer_instances: []LayerInstance_raw `json:"layerInstances"`,
}

LayerInstance_raw :: struct {
    identifier:       LayerInstanceIdentifier `json:"__identifier"`,
    type:             LayerInstanceType `json:"__type"`,
    entity_instances: []EntityInstance_raw `json:"entityInstances"`,
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
