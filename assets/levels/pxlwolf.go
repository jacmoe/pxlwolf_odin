// Code generated from JSON Schema using quicktype. DO NOT EDIT.
// To parse and unparse this JSON data, add this code to your project and do:
//
//    welcome, err := UnmarshalWelcome(bytes)
//    bytes, err = welcome.Marshal()

package main

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
	Header              Header        `json:"__header__"`
	Iid                 string        `json:"iid"`
	JSONVersion         string        `json:"jsonVersion"`
	AppBuildID          int64         `json:"appBuildId"`
	NextUid             int64         `json:"nextUid"`
	IdentifierStyle     string        `json:"identifierStyle"`
	Toc                 []interface{} `json:"toc"`
	WorldLayout         string        `json:"worldLayout"`
	WorldGridWidth      int64         `json:"worldGridWidth"`
	WorldGridHeight     int64         `json:"worldGridHeight"`
	DefaultLevelWidth   int64         `json:"defaultLevelWidth"`
	DefaultLevelHeight  int64         `json:"defaultLevelHeight"`
	DefaultPivotX       int64         `json:"defaultPivotX"`
	DefaultPivotY       int64         `json:"defaultPivotY"`
	DefaultGridSize     int64         `json:"defaultGridSize"`
	DefaultEntityWidth  int64         `json:"defaultEntityWidth"`
	DefaultEntityHeight int64         `json:"defaultEntityHeight"`
	BgColor             string        `json:"bgColor"`
	DefaultLevelBgColor string        `json:"defaultLevelBgColor"`
	MinifyJSON          bool          `json:"minifyJson"`
	ExternalLevels      bool          `json:"externalLevels"`
	ExportTiled         bool          `json:"exportTiled"`
	SimplifiedExport    bool          `json:"simplifiedExport"`
	ImageExportMode     string        `json:"imageExportMode"`
	ExportLevelBg       bool          `json:"exportLevelBg"`
	PNGFilePattern      interface{}   `json:"pngFilePattern"`
	BackupOnSave        bool          `json:"backupOnSave"`
	BackupLimit         int64         `json:"backupLimit"`
	BackupRelPath       interface{}   `json:"backupRelPath"`
	LevelNamePattern    string        `json:"levelNamePattern"`
	TutorialDesc        interface{}   `json:"tutorialDesc"`
	CustomCommands      []interface{} `json:"customCommands"`
	Flags               []string      `json:"flags"`
	Defs                Defs          `json:"defs"`
	Levels              []Level       `json:"levels"`
	Worlds              []interface{} `json:"worlds"`
	DummyWorldIid       string        `json:"dummyWorldIid"`
}

type Defs struct {
	Layers        []Layer       `json:"layers"`
	Entities      []Entity      `json:"entities"`
	Tilesets      []interface{} `json:"tilesets"`
	Enums         []Enum        `json:"enums"`
	ExternalEnums []interface{} `json:"externalEnums"`
	LevelFields   []interface{} `json:"levelFields"`
}

type Entity struct {
	Identifier       string        `json:"identifier"`
	Uid              int64         `json:"uid"`
	Tags             []interface{} `json:"tags"`
	ExportToToc      bool          `json:"exportToToc"`
	AllowOutOfBounds bool          `json:"allowOutOfBounds"`
	Doc              interface{}   `json:"doc"`
	Width            int64         `json:"width"`
	Height           int64         `json:"height"`
	ResizableX       bool          `json:"resizableX"`
	ResizableY       bool          `json:"resizableY"`
	MinWidth         interface{}   `json:"minWidth"`
	MaxWidth         interface{}   `json:"maxWidth"`
	MinHeight        interface{}   `json:"minHeight"`
	MaxHeight        interface{}   `json:"maxHeight"`
	KeepAspectRatio  bool          `json:"keepAspectRatio"`
	TileOpacity      int64         `json:"tileOpacity"`
	FillOpacity      int64         `json:"fillOpacity"`
	LineOpacity      int64         `json:"lineOpacity"`
	Hollow           bool          `json:"hollow"`
	Color            string        `json:"color"`
	RenderMode       string        `json:"renderMode"`
	ShowName         bool          `json:"showName"`
	TilesetID        interface{}   `json:"tilesetId"`
	TileRenderMode   string        `json:"tileRenderMode"`
	TileRect         interface{}   `json:"tileRect"`
	UITileRect       interface{}   `json:"uiTileRect"`
	NineSliceBorders []interface{} `json:"nineSliceBorders"`
	MaxCount         int64         `json:"maxCount"`
	LimitScope       string        `json:"limitScope"`
	LimitBehavior    string        `json:"limitBehavior"`
	PivotX           float64       `json:"pivotX"`
	PivotY           float64       `json:"pivotY"`
	FieldDefs        []FieldDef    `json:"fieldDefs"`
}

type FieldDef struct {
	Identifier           string        `json:"identifier"`
	Doc                  interface{}   `json:"doc"`
	Type                 string        `json:"__type"`
	Uid                  int64         `json:"uid"`
	FieldDefType         string        `json:"type"`
	IsArray              bool          `json:"isArray"`
	CanBeNull            bool          `json:"canBeNull"`
	ArrayMinLength       interface{}   `json:"arrayMinLength"`
	ArrayMaxLength       interface{}   `json:"arrayMaxLength"`
	EditorDisplayMode    string        `json:"editorDisplayMode"`
	EditorDisplayScale   int64         `json:"editorDisplayScale"`
	EditorDisplayPos     string        `json:"editorDisplayPos"`
	EditorLinkStyle      string        `json:"editorLinkStyle"`
	EditorDisplayColor   interface{}   `json:"editorDisplayColor"`
	EditorAlwaysShow     bool          `json:"editorAlwaysShow"`
	EditorShowInWorld    bool          `json:"editorShowInWorld"`
	EditorCutLongValues  bool          `json:"editorCutLongValues"`
	EditorTextSuffix     interface{}   `json:"editorTextSuffix"`
	EditorTextPrefix     interface{}   `json:"editorTextPrefix"`
	UseForSmartColor     bool          `json:"useForSmartColor"`
	ExportToToc          bool          `json:"exportToToc"`
	Searchable           bool          `json:"searchable"`
	Min                  interface{}   `json:"min"`
	Max                  interface{}   `json:"max"`
	Regex                interface{}   `json:"regex"`
	AcceptFileTypes      interface{}   `json:"acceptFileTypes"`
	DefaultOverride      interface{}   `json:"defaultOverride"`
	TextLanguageMode     interface{}   `json:"textLanguageMode"`
	SymmetricalRef       bool          `json:"symmetricalRef"`
	AutoChainRef         bool          `json:"autoChainRef"`
	AllowOutOfLevelRef   bool          `json:"allowOutOfLevelRef"`
	AllowedRefs          string        `json:"allowedRefs"`
	AllowedRefsEntityUid interface{}   `json:"allowedRefsEntityUid"`
	AllowedRefTags       []interface{} `json:"allowedRefTags"`
	TilesetUid           interface{}   `json:"tilesetUid"`
}

type Enum struct {
	Identifier           string        `json:"identifier"`
	Uid                  int64         `json:"uid"`
	Values               []Value       `json:"values"`
	IconTilesetUid       interface{}   `json:"iconTilesetUid"`
	ExternalRelPath      interface{}   `json:"externalRelPath"`
	ExternalFileChecksum interface{}   `json:"externalFileChecksum"`
	Tags                 []interface{} `json:"tags"`
}

type Value struct {
	ID       string      `json:"id"`
	TileRect interface{} `json:"tileRect"`
	Color    int64       `json:"color"`
}

type Layer struct {
	Type                           string         `json:"__type"`
	Identifier                     string         `json:"identifier"`
	LayerType                      string         `json:"type"`
	Uid                            int64          `json:"uid"`
	Doc                            interface{}    `json:"doc"`
	UIColor                        interface{}    `json:"uiColor"`
	GridSize                       int64          `json:"gridSize"`
	GuideGridWid                   int64          `json:"guideGridWid"`
	GuideGridHei                   int64          `json:"guideGridHei"`
	DisplayOpacity                 int64          `json:"displayOpacity"`
	InactiveOpacity                float64        `json:"inactiveOpacity"`
	HideInList                     bool           `json:"hideInList"`
	HideFieldsWhenInactive         bool           `json:"hideFieldsWhenInactive"`
	CanSelectWhenInactive          bool           `json:"canSelectWhenInactive"`
	RenderInWorldView              bool           `json:"renderInWorldView"`
	PxOffsetX                      int64          `json:"pxOffsetX"`
	PxOffsetY                      int64          `json:"pxOffsetY"`
	ParallaxFactorX                int64          `json:"parallaxFactorX"`
	ParallaxFactorY                int64          `json:"parallaxFactorY"`
	ParallaxScaling                bool           `json:"parallaxScaling"`
	RequiredTags                   []interface{}  `json:"requiredTags"`
	ExcludedTags                   []interface{}  `json:"excludedTags"`
	AutoTilesKilledByOtherLayerUid interface{}    `json:"autoTilesKilledByOtherLayerUid"`
	UIFilterTags                   []interface{}  `json:"uiFilterTags"`
	UseAsyncRender                 bool           `json:"useAsyncRender"`
	IntGridValues                  []IntGridValue `json:"intGridValues"`
	IntGridValuesGroups            []interface{}  `json:"intGridValuesGroups"`
	AutoRuleGroups                 []interface{}  `json:"autoRuleGroups"`
	AutoSourceLayerDefUid          interface{}    `json:"autoSourceLayerDefUid"`
	TilesetDefUid                  interface{}    `json:"tilesetDefUid"`
	TilePivotX                     int64          `json:"tilePivotX"`
	TilePivotY                     int64          `json:"tilePivotY"`
	BiomeFieldUid                  interface{}    `json:"biomeFieldUid"`
}

type IntGridValue struct {
	Value      int64       `json:"value"`
	Identifier *string     `json:"identifier"`
	Color      string      `json:"color"`
	Tile       interface{} `json:"tile"`
	GroupUid   int64       `json:"groupUid"`
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

type Level struct {
	Identifier        string        `json:"identifier"`
	Iid               string        `json:"iid"`
	Uid               int64         `json:"uid"`
	WorldX            int64         `json:"worldX"`
	WorldY            int64         `json:"worldY"`
	WorldDepth        int64         `json:"worldDepth"`
	PxWid             int64         `json:"pxWid"`
	PxHei             int64         `json:"pxHei"`
	BgColor           string        `json:"__bgColor"`
	LevelBgColor      interface{}   `json:"bgColor"`
	UseAutoIdentifier bool          `json:"useAutoIdentifier"`
	BgRelPath         interface{}   `json:"bgRelPath"`
	LevelBgPos        interface{}   `json:"bgPos"`
	BgPivotX          float64       `json:"bgPivotX"`
	BgPivotY          float64       `json:"bgPivotY"`
	SmartColor        string        `json:"__smartColor"`
	BgPos             interface{}   `json:"__bgPos"`
	ExternalRelPath   string        `json:"externalRelPath"`
	FieldInstances    []interface{} `json:"fieldInstances"`
	LayerInstances    interface{}   `json:"layerInstances"`
	Neighbours        []Neighbour   `json:"__neighbours"`
}

type Neighbour struct {
	LevelIid string `json:"levelIid"`
	Dir      Dir    `json:"dir"`
}

type Dir string

const (
	E Dir = "e"
	W Dir = "w"
)
