LoadTilesetHeader:
	call GetPredefRegisters
	push hl
	ld d, 0
	ld a, [wCurMapTileset]
	add a
	add a
	ld e, a
	ld hl, Tilesets
	add hl, de
	add hl, de
	add hl, de
	ld de, wTilesetBank
	ld bc, $b
	call CopyData
	ld a, [hl]
	ld [hTilesetType], a
	xor a
	ld [$ffd8], a
	pop hl
	ld a, [wCurMapTileset]
	push hl
	push de
	ld hl, DungeonTilesets
	ld de, $1
	call IsInArray
	pop de
	pop hl
	jr c, .notDungeonTileset
	ld a, [wCurMapTileset]
	ld b, a
	ld a, [hPreviousTileset]
	cp b
	jr z, .done
.notDungeonTileset
	ld a, [wDestinationWarpID]
	cp $ff
	jr z, .done
	call LoadDestinationWarpPosition
	ld a, [wYCoord]
	and $1
	ld [wYBlockCoord], a
	ld a, [wXCoord]
	and $1
	ld [wXBlockCoord], a
.done
	ret

INCLUDE "data/dungeon_tilesets.asm"

INCLUDE "data/tileset_headers.asm"
