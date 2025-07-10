// Code generated from JSON Schema using quicktype. DO NOT EDIT.
// To parse and unparse this JSON data, add this code to your project and do:
//
//    welcome, err := UnmarshalWelcome(bytes)
//    bytes, err = welcome.Marshal()

package main

import "bytes"
import "errors"

import "encoding/json"

func UnmarshalWelcome(data []byte) (Welcome, error) {
	var r Welcome
	err := json.Unmarshal(data, &r)
	return r, err
}

func (r *Welcome) Marshal() ([]byte, error) {
	return json.Marshal(r)
}

type Welcome struct {
	Header            Header          `json:"__header__"`
	Identifier        string          `json:"identifier"`
	Iid               string          `json:"iid"`
	Uid               int64           `json:"uid"`
	WorldX            int64           `json:"worldX"`
	WorldY            int64           `json:"worldY"`
	WorldDepth        int64           `json:"worldDepth"`
	PxWid             int64           `json:"pxWid"`
	PxHei             int64           `json:"pxHei"`
	BgColor           string          `json:"__bgColor"`
	WelcomeBgColor    interface{}     `json:"bgColor"`
	UseAutoIdentifier bool            `json:"useAutoIdentifier"`
	BgRelPath         interface{}     `json:"bgRelPath"`
	WelcomeBgPos      interface{}     `json:"bgPos"`
	BgPivotX          float64         `json:"bgPivotX"`
	BgPivotY          float64         `json:"bgPivotY"`
	SmartColor        string          `json:"__smartColor"`
	BgPos             interface{}     `json:"__bgPos"`
	ExternalRelPath   interface{}     `json:"externalRelPath"`
	FieldInstances    []interface{}   `json:"fieldInstances"`
	LayerInstances    []LayerInstance `json:"layerInstances"`
	Neighbours        []Neighbour     `json:"__neighbours"`
}

type Header struct {
	FileType   string `json:"fileType"`
	App        string `json:"app"`
	Doc        string `json:"doc"`
	Schema     string `json:"schema"`
	AppAuthor  string `json:"appAuthor"`
	AppVersion string `json:"appVersion"`
	URL        string `json:"url"`
}

type LayerInstance struct {
	Identifier         string           `json:"__identifier"`
	Type               string           `json:"__type"`
	CWid               int64            `json:"__cWid"`
	CHei               int64            `json:"__cHei"`
	GridSize           int64            `json:"__gridSize"`
	Opacity            int64            `json:"__opacity"`
	PxTotalOffsetX     int64            `json:"__pxTotalOffsetX"`
	PxTotalOffsetY     int64            `json:"__pxTotalOffsetY"`
	TilesetDefUid      interface{}      `json:"__tilesetDefUid"`
	TilesetRelPath     interface{}      `json:"__tilesetRelPath"`
	Iid                string           `json:"iid"`
	LevelID            int64            `json:"levelId"`
	LayerDefUid        int64            `json:"layerDefUid"`
	PxOffsetX          int64            `json:"pxOffsetX"`
	PxOffsetY          int64            `json:"pxOffsetY"`
	Visible            bool             `json:"visible"`
	OptionalRules      []interface{}    `json:"optionalRules"`
	IntGridCSV         []int64          `json:"intGridCsv"`
	AutoLayerTiles     []interface{}    `json:"autoLayerTiles"`
	Seed               int64            `json:"seed"`
	OverrideTilesetUid interface{}      `json:"overrideTilesetUid"`
	GridTiles          []interface{}    `json:"gridTiles"`
	EntityInstances    []EntityInstance `json:"entityInstances"`
}

type EntityInstance struct {
	Identifier     EntityInstanceIdentifier `json:"__identifier"`
	Grid           []int64                  `json:"__grid"`
	Pivot          []float64                `json:"__pivot"`
	Tags           []interface{}            `json:"__tags"`
	Tile           interface{}              `json:"__tile"`
	SmartColor     SmartColor               `json:"__smartColor"`
	Iid            string                   `json:"iid"`
	Width          int64                    `json:"width"`
	Height         int64                    `json:"height"`
	DefUid         int64                    `json:"defUid"`
	Px             []int64                  `json:"px"`
	FieldInstances []FieldInstance          `json:"fieldInstances"`
	WorldX         int64                    `json:"__worldX"`
	WorldY         int64                    `json:"__worldY"`
}

type FieldInstance struct {
	Identifier       FieldInstanceIdentifier `json:"__identifier"`
	Type             TypeEnum                `json:"__type"`
	Value            *Value                  `json:"__value"`
	Tile             interface{}             `json:"__tile"`
	DefUid           int64                   `json:"defUid"`
	RealEditorValues []RealEditorValue       `json:"realEditorValues"`
}

type RealEditorValue struct {
	ID     ID      `json:"id"`
	Params []Param `json:"params"`
}

type Neighbour struct {
	LevelIid string `json:"levelIid"`
	Dir      string `json:"dir"`
}

type FieldInstanceIdentifier string

const (
	NextLevel   FieldInstanceIdentifier = "next_level"
	Type        FieldInstanceIdentifier = "type"
	ViewerAngle FieldInstanceIdentifier = "ViewerAngle"
)

type ID string

const (
	VFloat  ID = "V_Float"
	VString ID = "V_String"
)

type TypeEnum string

const (
	ArrayLocalEnumEnemies TypeEnum = "Array<LocalEnum.Enemies>"
	ArrayLocalEnumItems   TypeEnum = "Array<LocalEnum.Items>"
	ArrayLocalEnumStatic  TypeEnum = "Array<LocalEnum.Static>"
	Float                 TypeEnum = "Float"
	String                TypeEnum = "String"
)

type EntityInstanceIdentifier string

const (
	Enemy       EntityInstanceIdentifier = "Enemy"
	LevelEnd    EntityInstanceIdentifier = "LevelEnd"
	Pickup      EntityInstanceIdentifier = "Pickup"
	PlayerStart EntityInstanceIdentifier = "PlayerStart"
	Static      EntityInstanceIdentifier = "Static"
)

type SmartColor string

const (
	Ba0C7F    SmartColor = "#BA0C7F"
	The11A32B SmartColor = "#11A32B"
	The625Dd1 SmartColor = "#625DD1"
	The6710A9 SmartColor = "#6710A9"
	The94D9B3 SmartColor = "#94D9B3"
)

type Param struct {
	Integer *int64
	String  *string
}

func (x *Param) UnmarshalJSON(data []byte) error {
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, &x.String, false, nil, false, nil, false, nil, false, nil, false)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Param) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, x.String, false, nil, false, nil, false, nil, false, nil, false)
}

type Value struct {
	Integer     *int64
	String      *string
	StringArray []string
}

func (x *Value) UnmarshalJSON(data []byte) error {
	x.StringArray = nil
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, &x.String, true, &x.StringArray, false, nil, false, nil, false, nil, true)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Value) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, x.String, x.StringArray != nil, x.StringArray, false, nil, false, nil, false, nil, true)
}

func unmarshalUnion(data []byte, pi **int64, pf **float64, pb **bool, ps **string, haveArray bool, pa interface{}, haveObject bool, pc interface{}, haveMap bool, pm interface{}, haveEnum bool, pe interface{}, nullable bool) (bool, error) {
	if pi != nil {
		*pi = nil
	}
	if pf != nil {
		*pf = nil
	}
	if pb != nil {
		*pb = nil
	}
	if ps != nil {
		*ps = nil
	}

	dec := json.NewDecoder(bytes.NewReader(data))
	dec.UseNumber()
	tok, err := dec.Token()
	if err != nil {
		return false, err
	}

	switch v := tok.(type) {
	case json.Number:
		if pi != nil {
			i, err := v.Int64()
			if err == nil {
				*pi = &i
				return false, nil
			}
		}
		if pf != nil {
			f, err := v.Float64()
			if err == nil {
				*pf = &f
				return false, nil
			}
			return false, errors.New("Unparsable number")
		}
		return false, errors.New("Union does not contain number")
	case float64:
		return false, errors.New("Decoder should not return float64")
	case bool:
		if pb != nil {
			*pb = &v
			return false, nil
		}
		return false, errors.New("Union does not contain bool")
	case string:
		if haveEnum {
			return false, json.Unmarshal(data, pe)
		}
		if ps != nil {
			*ps = &v
			return false, nil
		}
		return false, errors.New("Union does not contain string")
	case nil:
		if nullable {
			return false, nil
		}
		return false, errors.New("Union does not contain null")
	case json.Delim:
		if v == '{' {
			if haveObject {
				return true, json.Unmarshal(data, pc)
			}
			if haveMap {
				return false, json.Unmarshal(data, pm)
			}
			return false, errors.New("Union does not contain object")
		}
		if v == '[' {
			if haveArray {
				return false, json.Unmarshal(data, pa)
			}
			return false, errors.New("Union does not contain array")
		}
		return false, errors.New("Cannot handle delimiter")
	}
	return false, errors.New("Cannot unmarshal union")
}

func marshalUnion(pi *int64, pf *float64, pb *bool, ps *string, haveArray bool, pa interface{}, haveObject bool, pc interface{}, haveMap bool, pm interface{}, haveEnum bool, pe interface{}, nullable bool) ([]byte, error) {
	if pi != nil {
		return json.Marshal(*pi)
	}
	if pf != nil {
		return json.Marshal(*pf)
	}
	if pb != nil {
		return json.Marshal(*pb)
	}
	if ps != nil {
		return json.Marshal(*ps)
	}
	if haveArray {
		return json.Marshal(pa)
	}
	if haveObject {
		return json.Marshal(pc)
	}
	if haveMap {
		return json.Marshal(pm)
	}
	if haveEnum {
		return json.Marshal(pe)
	}
	if nullable {
		return json.Marshal(nil)
	}
	return nil, errors.New("Union must not be null")
}
