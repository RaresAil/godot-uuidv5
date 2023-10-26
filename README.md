# UUID v5 Generator for Godot Engine 4

A UUID v5 generator for godot

## Usage

The first arg in the method is a string value that you want to encode in v5 and the second one is the name space which must be a valid UUID

```go
var uuid = preload("res://addons/uuidv5/v5.gd")
var generated_uuid = uuid.v5("any string", "6ba7b810-9dad-11d1-80b4-00c04fd430c8")
```
