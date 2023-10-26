static func _uuid_to_bytes(uuid: String) -> PackedByteArray:
	var uuid_bytes = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	var v: int

	v = uuid.substr(0, 8).hex_to_int()
	uuid_bytes[0] = v >> 24
	uuid_bytes[1] = (v >> 16) & 0xff;
	uuid_bytes[2] = (v >> 8) & 0xff;
	uuid_bytes[3] = v & 0xff;

	v = uuid.substr(9, 4).hex_to_int()
	uuid_bytes[4] = v >> 8;
	uuid_bytes[5] = v & 0xff;
  
	v = uuid.substr(14, 4).hex_to_int()
	uuid_bytes[6] = v >> 8;
	uuid_bytes[7] = v & 0xff;
  
	v = uuid.substr(19, 4).hex_to_int()
	uuid_bytes[8] = v >> 8;
	uuid_bytes[9] = v & 0xff;

	v = uuid.substr(24).hex_to_int()
	uuid_bytes[10] = (v / 0x10000000000) & 0xff;
	uuid_bytes[11] = (v / 0x100000000) & 0xff;
	uuid_bytes[12] = (v >> 24) & 0xff;
	uuid_bytes[13] = (v >> 16) & 0xff;
	uuid_bytes[14] = (v >> 8) & 0xff;
	uuid_bytes[15] = v & 0xff;
	
	return uuid_bytes

static func v5(value: String, nspace: String) -> String:
	var sha1 = HashingContext.new()
	sha1.start(HashingContext.HASH_SHA1)
	sha1.update(_uuid_to_bytes(nspace))
	sha1.update(value.to_utf8_buffer())
	
	var hs = sha1.finish()
	
	var uuid_parts = []
	for i in range(16):
		uuid_parts.append("%02x" % hs[i])

	uuid_parts[6] = "%02x" % ((uuid_parts[6].hex_to_int() & 0x0f) | 0x50)
	uuid_parts[8] = "%02x" % ((uuid_parts[8].hex_to_int() & 0x3f) | 0x80)
	
	return "%s%s%s%s-%s%s-%s%s-%s%s-%s%s%s%s%s%s" % uuid_parts
