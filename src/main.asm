;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.0 #11528 (MINGW64)
;--------------------------------------------------------
	.module main
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _clear_screen
	.globl _title_screen
	.globl _update_sprite_animation
	.globl _unflip_sprite_horiz
	.globl _flip_sprite_horiz
	.globl _setchar
	.globl _gotoxy
	.globl _move_sprite
	.globl _get_sprite_prop
	.globl _set_sprite_prop
	.globl _set_sprite_tile
	.globl _set_sprite_data
	.globl _scroll_bkg
	.globl _move_bkg
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _waitpadup
	.globl _waitpad
	.globl _joypad
	.globl _printf
	.globl _is_player_walking
	.globl _player_animation_frame
	.globl _player_direction
	.globl _player_virtual_y
	.globl _player_virtual_x
	.globl _player_y
	.globl _player_x
	.globl _PLAYER_SPRITE_ANIM_R
	.globl _PLAYER_SPRITE_ANIM_L
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_PLAYER_SPRITE_ANIM_L::
	.ds 24
_PLAYER_SPRITE_ANIM_R::
	.ds 24
_player_x::
	.ds 1
_player_y::
	.ds 1
_player_virtual_x::
	.ds 2
_player_virtual_y::
	.ds 2
_player_direction::
	.ds 1
_player_animation_frame::
	.ds 1
_is_player_walking::
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;main.c:13: UINT8 PLAYER_SPRITE_ANIM_L[] = {
	ld	hl, #_PLAYER_SPRITE_ANIM_L
	ld	(hl), #0x04
	ld	hl, #(_PLAYER_SPRITE_ANIM_L + 0x0001)
	ld	(hl), #0x00
	ld	hl, #(_PLAYER_SPRITE_ANIM_L + 0x0002)
	ld	(hl), #0x00
	ld	hl, #(_PLAYER_SPRITE_ANIM_L + 0x0003)
	ld	(hl), #0x04
	ld	hl, #(_PLAYER_SPRITE_ANIM_L + 0x0004)
	ld	(hl), #0x00
	ld	hl, #(_PLAYER_SPRITE_ANIM_L + 0x0005)
	ld	(hl), #0x08
	ld	hl, #(_PLAYER_SPRITE_ANIM_L + 0x0006)
	ld	(hl), #0x04
	ld	hl, #(_PLAYER_SPRITE_ANIM_L + 0x0007)
	ld	(hl), #0x00
	ld	hl, #(_PLAYER_SPRITE_ANIM_L + 0x0008)
	ld	(hl), #0x0c
	ld	hl, #(_PLAYER_SPRITE_ANIM_L + 0x0009)
	ld	(hl), #0x10
	ld	hl, #(_PLAYER_SPRITE_ANIM_L + 0x000a)
	ld	(hl), #0x0c
	ld	hl, #(_PLAYER_SPRITE_ANIM_L + 0x000b)
	ld	(hl), #0x14
	ld	hl, #(_PLAYER_SPRITE_ANIM_L + 0x000c)
	ld	(hl), #0x04
	ld	hl, #(_PLAYER_SPRITE_ANIM_L + 0x000d)
	ld	(hl), #0x00
	ld	hl, #(_PLAYER_SPRITE_ANIM_L + 0x000e)
	ld	(hl), #0x18
	ld	hl, #(_PLAYER_SPRITE_ANIM_L + 0x000f)
	ld	(hl), #0x1c
	ld	hl, #(_PLAYER_SPRITE_ANIM_L + 0x0010)
	ld	(hl), #0x18
	ld	hl, #(_PLAYER_SPRITE_ANIM_L + 0x0011)
	ld	(hl), #0x20
	ld	hl, #(_PLAYER_SPRITE_ANIM_L + 0x0012)
	ld	(hl), #0x04
	ld	hl, #(_PLAYER_SPRITE_ANIM_L + 0x0013)
	ld	(hl), #0x01
	ld	hl, #(_PLAYER_SPRITE_ANIM_L + 0x0014)
	ld	(hl), #0x1a
	ld	hl, #(_PLAYER_SPRITE_ANIM_L + 0x0015)
	ld	(hl), #0x1e
	ld	hl, #(_PLAYER_SPRITE_ANIM_L + 0x0016)
	ld	(hl), #0x1a
	ld	hl, #(_PLAYER_SPRITE_ANIM_L + 0x0017)
	ld	(hl), #0x22
;main.c:20: UINT8 PLAYER_SPRITE_ANIM_R[] = {
	ld	hl, #_PLAYER_SPRITE_ANIM_R
	ld	(hl), #0x04
	ld	hl, #(_PLAYER_SPRITE_ANIM_R + 0x0001)
	ld	(hl), #0x00
	ld	hl, #(_PLAYER_SPRITE_ANIM_R + 0x0002)
	ld	(hl), #0x02
	ld	hl, #(_PLAYER_SPRITE_ANIM_R + 0x0003)
	ld	(hl), #0x06
	ld	hl, #(_PLAYER_SPRITE_ANIM_R + 0x0004)
	ld	(hl), #0x02
	ld	hl, #(_PLAYER_SPRITE_ANIM_R + 0x0005)
	ld	(hl), #0x0a
	ld	hl, #(_PLAYER_SPRITE_ANIM_R + 0x0006)
	ld	(hl), #0x04
	ld	hl, #(_PLAYER_SPRITE_ANIM_R + 0x0007)
	ld	(hl), #0x00
	ld	hl, #(_PLAYER_SPRITE_ANIM_R + 0x0008)
	ld	(hl), #0x0e
	ld	hl, #(_PLAYER_SPRITE_ANIM_R + 0x0009)
	ld	(hl), #0x12
	ld	hl, #(_PLAYER_SPRITE_ANIM_R + 0x000a)
	ld	(hl), #0x0e
	ld	hl, #(_PLAYER_SPRITE_ANIM_R + 0x000b)
	ld	(hl), #0x16
	ld	hl, #(_PLAYER_SPRITE_ANIM_R + 0x000c)
	ld	(hl), #0x04
	ld	hl, #(_PLAYER_SPRITE_ANIM_R + 0x000d)
	ld	(hl), #0x00
	ld	hl, #(_PLAYER_SPRITE_ANIM_R + 0x000e)
	ld	(hl), #0x1a
	ld	hl, #(_PLAYER_SPRITE_ANIM_R + 0x000f)
	ld	(hl), #0x1e
	ld	hl, #(_PLAYER_SPRITE_ANIM_R + 0x0010)
	ld	(hl), #0x1a
	ld	hl, #(_PLAYER_SPRITE_ANIM_R + 0x0011)
	ld	(hl), #0x22
	ld	hl, #(_PLAYER_SPRITE_ANIM_R + 0x0012)
	ld	(hl), #0x04
	ld	hl, #(_PLAYER_SPRITE_ANIM_R + 0x0013)
	ld	(hl), #0x01
	ld	hl, #(_PLAYER_SPRITE_ANIM_R + 0x0014)
	ld	(hl), #0x18
	ld	hl, #(_PLAYER_SPRITE_ANIM_R + 0x0015)
	ld	(hl), #0x1c
	ld	hl, #(_PLAYER_SPRITE_ANIM_R + 0x0016)
	ld	(hl), #0x18
	ld	hl, #(_PLAYER_SPRITE_ANIM_R + 0x0017)
	ld	(hl), #0x20
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;main.c:48: void flip_sprite_horiz(UINT8 sprite_id)
;	---------------------------------
; Function flip_sprite_horiz
; ---------------------------------
_flip_sprite_horiz::
;main.c:50: set_sprite_prop(sprite_id, get_sprite_prop(sprite_id) | S_FLIPX);
	ldhl	sp,	#2
	ld	a, (hl)
	push	af
	inc	sp
	call	_get_sprite_prop
	inc	sp
	ld	a, e
	set	5, a
	push	af
	inc	sp
	ldhl	sp,	#3
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_sprite_prop
	add	sp, #2
;main.c:51: }
	ret
;main.c:56: void unflip_sprite_horiz(UINT8 sprite_id)
;	---------------------------------
; Function unflip_sprite_horiz
; ---------------------------------
_unflip_sprite_horiz::
;main.c:58: set_sprite_prop(sprite_id, get_sprite_prop(sprite_id) & ~S_FLIPX);
	ldhl	sp,	#2
	ld	a, (hl)
	push	af
	inc	sp
	call	_get_sprite_prop
	inc	sp
	ld	a, e
	res	5, a
	push	af
	inc	sp
	ldhl	sp,	#3
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_sprite_prop
	add	sp, #2
;main.c:59: }
	ret
;main.c:69: UINT8 update_sprite_animation(UINT8 sprite_id, UINT8 *anim, UINT8 direction, UINT8 frame)
;	---------------------------------
; Function update_sprite_animation
; ---------------------------------
_update_sprite_animation::
	add	sp, #-4
;main.c:71: UINT8 len = anim[direction];
	ldhl	sp,#(8 - 1)
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	inc	hl
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#0
	ld	(hl), a
;main.c:72: UINT8 flip = anim[direction + 1];
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	inc	bc
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#1
;main.c:73: UINT8 tile_id = anim[direction + 2 + frame];
	ld	(hl+), a
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	inc	bc
	inc	bc
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c,l
	ld	a,h
	ld	b, (hl)
;main.c:75: if (flip)
	ldhl	sp,	#1
	ld	a, (hl)
	or	a, a
	jr	Z,00102$
;main.c:77: flip_sprite_horiz(sprite_id);
	push	bc
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	call	_flip_sprite_horiz
	inc	sp
	pop	bc
	jr	00103$
00102$:
;main.c:81: unflip_sprite_horiz(sprite_id);
	push	bc
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	call	_unflip_sprite_horiz
	inc	sp
	pop	bc
00103$:
;main.c:84: set_sprite_tile(sprite_id, tile_id);
	push	bc
	inc	sp
	ldhl	sp,	#7
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_sprite_tile
	add	sp, #2
;main.c:86: return (frame + 1) % len;
	ldhl	sp,#(3 - 1)
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	inc	bc
	ldhl	sp,	#0
	ld	e, (hl)
	ld	d, #0x00
	push	de
	push	bc
	call	__modsint
	add	sp, #4
;main.c:87: }
	add	sp, #4
	ret
;main.c:89: void title_screen(void)
;	---------------------------------
; Function title_screen
; ---------------------------------
_title_screen::
;main.c:92: clear_screen();
	call	_clear_screen
;main.c:94: gotoxy(5, 5);
	ld	a, #0x05
	push	af
	inc	sp
	ld	a, #0x05
	push	af
	inc	sp
	call	_gotoxy
	add	sp, #2
;main.c:95: printf("GehBoiHaven");
	ld	hl, #___str_0
	push	hl
	call	_printf
	add	sp, #2
;main.c:96: gotoxy(3, 15);
	ld	a, #0x0f
	push	af
	inc	sp
	ld	a, #0x03
	push	af
	inc	sp
	call	_gotoxy
	add	sp, #2
;main.c:97: printf("- Press START -");
	ld	hl, #___str_1
	push	hl
	call	_printf
	add	sp, #2
;main.c:99: waitpad(J_START);
	ld	a, #0x80
	push	af
	inc	sp
	call	_waitpad
	inc	sp
;main.c:100: waitpadup();
;main.c:101: }
	jp	_waitpadup
___str_0:
	.ascii "GehBoiHaven"
	.db 0x00
___str_1:
	.ascii "- Press START -"
	.db 0x00
;main.c:103: void clear_screen(void)
;	---------------------------------
; Function clear_screen
; ---------------------------------
_clear_screen::
;main.c:106: UINT8 y = 18;
	ld	c, #0x12
;main.c:107: while (y)
00104$:
	ld	a, c
	or	a, a
	ret	Z
;main.c:109: y -= 1;
	dec	c
;main.c:110: x = 20;
	ld	b, #0x14
;main.c:111: while (x)
00101$:
	ld	a, b
	or	a, a
	jr	Z,00104$
;main.c:113: x -= 1;
	dec	b
;main.c:114: gotoxy(x, y);
	push	bc
	ld	a, c
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_gotoxy
	add	sp, #2
	pop	bc
;main.c:115: setchar(' ');
	push	bc
	ld	a, #0x20
	push	af
	inc	sp
	call	_setchar
	inc	sp
	pop	bc
	jr	00101$
;main.c:118: }
	ret
;main.c:120: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	dec	sp
;main.c:122: title_screen();
	call	_title_screen
;main.c:123: clear_screen();
	call	_clear_screen
;main.c:126: set_bkg_data(0, TILESET_TILE_COUNT, TILESET);
	ld	hl, #_TILESET
	push	hl
	ld	a, #0x5f
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_data
	add	sp, #4
;main.c:130: set_bkg_tiles(0, 0, TILEMAP_WIDTH, TILEMAP_HEIGHT, TILEMAP);
	ld	hl, #_TILEMAP
	push	hl
	ld	a, #0x20
	push	af
	inc	sp
	ld	a, #0x20
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;main.c:132: SHOW_BKG;
	ld	hl, #0xff40
	ld	a, (hl)
	set	0, a
	ld	hl, #0xff40
	ld	(hl), a
;main.c:135: UINT8 frame_skip = 8;  // On met à jour l'animation toutes les 8 frames
	ldhl	sp,	#0
	ld	(hl), #0x08
;main.c:141: player_x = 80;
	ld	hl, #_player_x
	ld	(hl), #0x50
;main.c:142: player_y = 72;
	ld	hl, #_player_y
	ld	(hl), #0x48
;main.c:143: player_virtual_x = 80;
	ld	hl, #_player_virtual_x
	ld	(hl), #0x50
	inc	hl
	ld	(hl), #0x00
;main.c:144: player_virtual_y = 72;
	ld	hl, #_player_virtual_y
	ld	(hl), #0x48
	inc	hl
	ld	(hl), #0x00
;main.c:145: player_direction = PLAYER_DIRECTION_DOWN;
	ld	hl, #_player_direction
	ld	(hl), #0x00
;main.c:146: player_animation_frame = 0;
	ld	hl, #_player_animation_frame
	ld	(hl), #0x00
;main.c:147: is_player_walking = 0;
	ld	hl, #_is_player_walking
	ld	(hl), #0x00
;main.c:150: set_sprite_data(0, PLAYER_SPRITES_TILE_COUNT, PLAYER_SPRITES);
	ld	hl, #_PLAYER_SPRITES
	push	hl
	ld	a, #0x24
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_sprite_data
	add	sp, #4
;main.c:153: SPRITES_8x16;
	ld	hl, #0xff40
	ld	a, (hl)
	set	2, a
	ld	hl, #0xff40
	ld	(hl), a
;main.c:156: SHOW_SPRITES;
	ld	l, #0x40
	ld	a, (hl)
	set	1, a
	ld	hl, #0xff40
	ld	(hl), a
;main.c:159: move_sprite(PLAYER_SPRITE_L_ID, player_x, player_y);
	ld	hl, #_player_y
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #_player_x
	ld	a, (hl)
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_move_sprite
	add	sp, #3
;main.c:160: set_sprite_prop(PLAYER_SPRITE_L_ID, S_PALETTE);
	ld	a, #0x10
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_sprite_prop
	add	sp, #2
;main.c:162: move_sprite(PLAYER_SPRITE_R_ID, player_x + 8, player_y);
	ld	hl, #_player_x
	ld	a, (hl)
	add	a, #0x08
	ld	b, a
	ld	hl, #_player_y
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	ld	a, #0x01
	push	af
	inc	sp
	call	_move_sprite
	add	sp, #3
;main.c:163: set_sprite_prop(PLAYER_SPRITE_R_ID, S_PALETTE);
	ld	a, #0x10
	push	af
	inc	sp
	ld	a, #0x01
	push	af
	inc	sp
	call	_set_sprite_prop
	add	sp, #2
;main.c:165: while (1)
00137$:
;main.c:168: wait_vbl_done();
	call	_wait_vbl_done
;main.c:172: keys = joypad();
	call	_joypad
	ld	a, e
	ld	c, a
;main.c:174: if (keys & J_UP && player_virtual_y > 70)
	bit	2, c
	jp	Z,00114$
	ld	hl, #_player_virtual_y
	ld	a, #0x46
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jr	Z,00222$
	bit	7, d
	jr	NZ,00223$
	cp	a, a
	jr	00223$
00222$:
	bit	7, d
	jr	Z,00223$
	scf
00223$:
	jr	NC,00114$
;main.c:176: scroll_bkg(0, -1);
	push	bc
	ld	a, #0xff
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_scroll_bkg
	add	sp, #2
	pop	bc
;main.c:177: player_direction = PLAYER_DIRECTION_UP;
	ld	hl, #_player_direction
	ld	(hl), #0x06
;main.c:178: is_player_walking = 1;
	ld	hl, #_is_player_walking
	ld	(hl), #0x01
	jp	00115$
00114$:
;main.c:180: else if (keys & J_DOWN && player_virtual_y < 190)
	bit	3, c
	jp	Z,00110$
	ld	hl, #_player_virtual_y
	ld	a, (hl)
	sub	a, #0xbe
	inc	hl
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	ld	e, a
	bit	7, e
	jr	Z,00225$
	bit	7, d
	jr	NZ,00226$
	cp	a, a
	jr	00226$
00225$:
	bit	7, d
	jr	Z,00226$
	scf
00226$:
	jr	NC,00110$
;main.c:182: scroll_bkg(0, 1);
	push	bc
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_scroll_bkg
	add	sp, #2
	pop	bc
;main.c:183: player_direction = PLAYER_DIRECTION_DOWN;
	ld	hl, #_player_direction
	ld	(hl), #0x00
;main.c:184: is_player_walking = 1;
	ld	hl, #_is_player_walking
	ld	(hl), #0x01
	jp	00115$
00110$:
;main.c:186: else if (keys & J_LEFT && player_virtual_x > 70)
	bit	1, c
	jp	Z,00106$
	ld	hl, #_player_virtual_x
	ld	a, #0x46
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jr	Z,00228$
	bit	7, d
	jr	NZ,00229$
	cp	a, a
	jr	00229$
00228$:
	bit	7, d
	jr	Z,00229$
	scf
00229$:
	jr	NC,00106$
;main.c:188: scroll_bkg(-1, 0);    
	push	bc
	xor	a, a
	push	af
	inc	sp
	ld	a, #0xff
	push	af
	inc	sp
	call	_scroll_bkg
	add	sp, #2
	pop	bc
;main.c:189: player_direction = PLAYER_DIRECTION_LEFT;
	ld	hl, #_player_direction
	ld	(hl), #0x12
;main.c:190: is_player_walking = 1;
	ld	hl, #_is_player_walking
	ld	(hl), #0x01
	jp	00115$
00106$:
;main.c:192: else if (keys & J_RIGHT && player_virtual_x < 170)
	bit	0, c
	jp	Z,00102$
	ld	hl, #_player_virtual_x
	ld	a, (hl)
	sub	a, #0xaa
	inc	hl
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	ld	e, a
	bit	7, e
	jr	Z,00231$
	bit	7, d
	jr	NZ,00232$
	cp	a, a
	jr	00232$
00231$:
	bit	7, d
	jr	Z,00232$
	scf
00232$:
	jr	NC,00102$
;main.c:194: scroll_bkg(1, 0);
	push	bc
	xor	a, a
	push	af
	inc	sp
	ld	a, #0x01
	push	af
	inc	sp
	call	_scroll_bkg
	add	sp, #2
	pop	bc
;main.c:195: player_direction = PLAYER_DIRECTION_RIGHT;
	ld	hl, #_player_direction
	ld	(hl), #0x0c
;main.c:196: is_player_walking = 1;
	ld	hl, #_is_player_walking
	ld	(hl), #0x01
	jr	00115$
00102$:
;main.c:200: is_player_walking = 0;
	ld	hl, #_is_player_walking
	ld	(hl), #0x00
;main.c:201: frame_skip = 1;  // On force le rafraîchissement de l'animation
	ldhl	sp,	#0
	ld	(hl), #0x01
00115$:
;main.c:204: if (keys & J_START)
	bit	7, c
	jr	Z,00118$
;main.c:206: move_bkg(0, 0);
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_move_bkg
	add	sp, #2
;main.c:207: player_x = 80;
	ld	hl, #_player_x
	ld	(hl), #0x50
;main.c:208: player_y = 72;
	ld	hl, #_player_y
	ld	(hl), #0x48
;main.c:209: player_virtual_x = 80;
	ld	hl, #_player_virtual_x
	ld	(hl), #0x50
	inc	hl
	ld	(hl), #0x00
;main.c:210: player_virtual_y = 72;
	ld	hl, #_player_virtual_y
	ld	(hl), #0x48
	inc	hl
	ld	(hl), #0x00
00118$:
;main.c:215: if (is_player_walking)
	ld	hl, #_is_player_walking
	ld	a, (hl)
	or	a, a
	jp	Z, 00134$
;main.c:224: if (player_direction == PLAYER_DIRECTION_RIGHT) player_virtual_x += 1;
	ld	hl, #_player_direction
	ld	a, (hl)
	sub	a, #0x0c
	jr	NZ,00128$
	ld	hl, #_player_virtual_x
	inc	(hl)
	jp	NZ,00129$
	inc	hl
	inc	(hl)
	jp	00129$
00128$:
;main.c:225: else if (player_direction == PLAYER_DIRECTION_LEFT) player_virtual_x -= 1;
	ld	hl, #_player_direction
	ld	a, (hl)
	sub	a, #0x12
	jr	NZ,00125$
	ld	hl, #_player_virtual_x + 1
	dec	hl
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	dec	de
	dec	hl
	ld	(hl), e
	inc	hl
	ld	(hl), d
	jr	00129$
00125$:
;main.c:226: else if (player_direction == PLAYER_DIRECTION_UP) player_virtual_y -= 1;
	ld	hl, #_player_direction
	ld	a, (hl)
	sub	a, #0x06
	jr	NZ,00122$
	ld	hl, #_player_virtual_y + 1
	dec	hl
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	dec	de
	dec	hl
	ld	(hl), e
	inc	hl
	ld	(hl), d
	jr	00129$
00122$:
;main.c:227: else if (player_direction == PLAYER_DIRECTION_DOWN) player_virtual_y += 1;
	ld	hl, #_player_direction
	ld	a, (hl)
	or	a, a
	jr	NZ,00129$
	ld	hl, #_player_virtual_y
	inc	(hl)
	jr	NZ,00241$
	inc	hl
	inc	(hl)
00241$:
00129$:
;main.c:229: move_sprite(PLAYER_SPRITE_L_ID, player_x, player_y);
	ld	hl, #_player_y
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #_player_x
	ld	a, (hl)
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_move_sprite
	add	sp, #3
;main.c:230: move_sprite(PLAYER_SPRITE_R_ID, player_x + 8, player_y);
	ld	hl, #_player_x
	ld	a, (hl)
	add	a, #0x08
	ld	b, a
	ld	hl, #_player_y
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	ld	a, #0x01
	push	af
	inc	sp
	call	_move_sprite
	add	sp, #3
;main.c:235: frame_skip -= 1;
	ldhl	sp,	#0
	ld	a, (hl)
	dec	a
	ld	(hl), a
;main.c:237: if (!frame_skip)
	or	a, a
	jp	NZ, 00137$
;main.c:239: frame_skip = 8;
	ld	(hl), #0x08
	jr	00135$
;main.c:243: continue;
00134$:
;main.c:248: player_animation_frame = 0;
	ld	hl, #_player_animation_frame
	ld	(hl), #0x00
00135$:
;main.c:254: PLAYER_SPRITE_ANIM_L,
;main.c:253: PLAYER_SPRITE_L_ID,
	ld	hl, #_player_animation_frame
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #_player_direction
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #_PLAYER_SPRITE_ANIM_L
	push	hl
	xor	a, a
	push	af
	inc	sp
	call	_update_sprite_animation
	add	sp, #5
;main.c:259: PLAYER_SPRITE_ANIM_R,
;main.c:258: PLAYER_SPRITE_R_ID,
	ld	hl, #_player_animation_frame
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #_player_direction
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #_PLAYER_SPRITE_ANIM_R
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	call	_update_sprite_animation
	add	sp, #5
	ld	hl, #_player_animation_frame
	ld	(hl), e
	jp	00137$
;main.c:263: }
	inc	sp
	ret
	.area _CODE
	.area _CABS (ABS)
