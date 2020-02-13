#include <stdio.h>
#include <C:\Users\FDO\GB-test\src\gbdk\include\gb\gb.h>
#include <C:\Users\FDO\GB-test\src\gbdk\include\gb\console.h>
#include "tileset.h"
#include "tilemap.h"
#include "player.sprites.h"

// Id ("nb") des deux sprites utilisés pour représenter le joueur
#define PLAYER_SPRITE_L_ID 0
#define PLAYER_SPRITE_R_ID 1

// Données de l'animation des sprites du joueur
UINT8 PLAYER_SPRITE_ANIM_L[] = {
// TAILLE | MIRROIR | ID DES TUILES   | DIRECTION
   4,       0,        0 , 4,  0,  8,   // Bas
   4,       0,       12, 16, 12, 20,   // Haut
   4,       0,       24, 28, 24, 32,   // Droite
   4,       1,       26, 30, 26, 34,   // Gauche
};
UINT8 PLAYER_SPRITE_ANIM_R[] = {
// TAILLE | MIRROIR | ID DES TUILES   | DIRECTION
   4,       0,        2,  6,  2, 10,   // Bas
   4,       0,       14, 18, 14, 22,   // Haut
   4,       0,       26, 30, 26, 34,   // Droite
   4,       1,       24, 28, 24, 32,   // Gauche
};

// Liste des sous-animation (les nombre représentent l'octet où la
// sous-animation commence dans les données globales de l'animation du
// joueur)
#define PLAYER_DIRECTION_DOWN  0
#define PLAYER_DIRECTION_UP    6
#define PLAYER_DIRECTION_RIGHT 12
#define PLAYER_DIRECTION_LEFT  18

// Variables stockant l'état du joueur
UINT8 player_x;
UINT8 player_y;
INT16 player_virtual_x;
INT16 player_virtual_y;
UINT8 player_direction;
UINT8 player_animation_frame;
UINT8 is_player_walking;

// Retourne un sprite horizontalement (sur l'axe X).
//
// sprite_id: l'id ("nb") du sprite à modifier.
void flip_sprite_horiz(UINT8 sprite_id)
{
    set_sprite_prop(sprite_id, get_sprite_prop(sprite_id) | S_FLIPX);
}

// Supprime le retournement horizontal d'un sprite.
//
// sprite_id: l'id ("nb") du sprite à modifier.
void unflip_sprite_horiz(UINT8 sprite_id)
{
    set_sprite_prop(sprite_id, get_sprite_prop(sprite_id) & ~S_FLIPX);
}

// Met à jour les tuiles d'un sprite pour l'animer.
//
// sprite_id: l'id ("nb") du sprite à modifier
// anim:      pointeur vers les données de l'animation
// direction: direction de l'animation (= offset de la sous-animation)
// frame:     la nouvelle frame de l'animation qui doit être affichée
//
// Retourne la prochaine frame de l'animation.
UINT8 update_sprite_animation(UINT8 sprite_id, UINT8 *anim, UINT8 direction, UINT8 frame)
{
    UINT8 len = anim[direction];
    UINT8 flip = anim[direction + 1];
    UINT8 tile_id = anim[direction + 2 + frame];

    if (flip)
    {
        flip_sprite_horiz(sprite_id);
    }
    else
    {
        unflip_sprite_horiz(sprite_id);
    }

    set_sprite_tile(sprite_id, tile_id);

    return (frame + 1) % len;
}

void title_screen(void)
{
    // 1. Effacer tout ce qui se trouve à l'écran
    clear_screen();
    // 2. Afficher notre écran de titre
    gotoxy(5, 5);
    printf("GehBoiHaven");
    gotoxy(3, 15);
    printf("- Press START -");
    // 3. Attendre que le joueur appuie sur START et qu'il relâche le bouton
    waitpad(J_START);
    waitpadup();
}

void clear_screen(void)
{
    UINT8 x;
    UINT8 y = 18;
    while (y)
    {
        y -= 1;
        x = 20;
        while (x)
        {
            x -= 1;
            gotoxy(x, y);
            setchar(' ');
        }
    }
}

void main(void)
{
    title_screen();
    clear_screen();

    // On copie les tuiles dans la mémoire vidéo
    set_bkg_data(0, TILESET_TILE_COUNT, TILESET);

    // On copie la tilemap dans la mémoire vidéo (dans notre cas,
    // la tilemap contient tout le contenu de la couche background)
    set_bkg_tiles(0, 0, TILEMAP_WIDTH, TILEMAP_HEIGHT, TILEMAP);

    SHOW_BKG;

    UINT8 keys = 0;
    UINT8 frame_skip = 8;  // On met à jour l'animation toutes les 8 frames
                           // seulement, sinon l'animation serait trop
                           // rapide (8 frames = ~133 ms entre chaque frame
                           // de l'animation)

    // On initialise l'état du joueur
    player_x = 80;
    player_y = 72;
    player_virtual_x = 80;
    player_virtual_y = 72;
    player_direction = PLAYER_DIRECTION_DOWN;
    player_animation_frame = 0;
    is_player_walking = 0;

    // Charge les tuiles des sprites dans la mémoire vidéo
    set_sprite_data(0, PLAYER_SPRITES_TILE_COUNT, PLAYER_SPRITES);

    // On utilise des sprites de 8×16 px
    SPRITES_8x16;

    // On rend les sprites visibles
    SHOW_SPRITES;

    // On initialise les deux sprites qui représentent le joueur
    move_sprite(PLAYER_SPRITE_L_ID, player_x, player_y);
    set_sprite_prop(PLAYER_SPRITE_L_ID, S_PALETTE);

    move_sprite(PLAYER_SPRITE_R_ID, player_x + 8, player_y);
    set_sprite_prop(PLAYER_SPRITE_R_ID, S_PALETTE);

    while (1)
    {
        // On attend le rafraichissement de l'écran (v-sync)
        wait_vbl_done();

        // On lit les touche du gamepad pour savoir si le joueur
        // se déplace, et dans quelle direction
        keys = joypad();

        if (keys & J_UP && player_virtual_y > 70)
        {
            scroll_bkg(0, -1);
            player_direction = PLAYER_DIRECTION_UP;
            is_player_walking = 1;
        }
        else if (keys & J_DOWN && player_virtual_y < 190)
        {
            scroll_bkg(0, 1);
            player_direction = PLAYER_DIRECTION_DOWN;
            is_player_walking = 1;
        }
        else if (keys & J_LEFT && player_virtual_x > 70)
        {   
            scroll_bkg(-1, 0);    
            player_direction = PLAYER_DIRECTION_LEFT;
            is_player_walking = 1;
        }
        else if (keys & J_RIGHT && player_virtual_x < 170)
        {
            scroll_bkg(1, 0);
            player_direction = PLAYER_DIRECTION_RIGHT;
            is_player_walking = 1;
        }
        else
        {
            is_player_walking = 0;
            frame_skip = 1;  // On force le rafraîchissement de l'animation
        }
        // On retourne à la vue d'origine lorsque l'on appuie sur START
        if (keys & J_START)
        {
            move_bkg(0, 0);
            player_x = 80;
            player_y = 72;
            player_virtual_x = 80;
            player_virtual_y = 72;

        }

        // On met à jour la position du joueur s'il est en train de marcher
        if (is_player_walking)
        {
            // condition : quand on arrive près du bord de la map
            // if (player_direction == PLAYER_DIRECTION_RIGHT) player_x += 1;
            // else if (player_direction == PLAYER_DIRECTION_LEFT) player_x -= 1;
            // else if (player_direction == PLAYER_DIRECTION_UP) player_y -= 1;
            // else if (player_direction == PLAYER_DIRECTION_DOWN) player_y += 1;

            // calcul de la position virtuelle pour savoir quand on sort de la map
            if (player_direction == PLAYER_DIRECTION_RIGHT) player_virtual_x += 1;
            else if (player_direction == PLAYER_DIRECTION_LEFT) player_virtual_x -= 1;
            else if (player_direction == PLAYER_DIRECTION_UP) player_virtual_y -= 1;
            else if (player_direction == PLAYER_DIRECTION_DOWN) player_virtual_y += 1;

            move_sprite(PLAYER_SPRITE_L_ID, player_x, player_y);
            move_sprite(PLAYER_SPRITE_R_ID, player_x + 8, player_y);

            // Ici on compte les frames pour ne pas mettre à jour l'animation
            // à chaque rafraîchissement de l'écran : l'animation serait trop
            // rapide sinon...
            frame_skip -= 1;

            if (!frame_skip)
            {
                frame_skip = 8;
            }
            else
            {
                continue;
            }
        }
        else
        {
            player_animation_frame = 0;
        }

        // On met à jour les tuiles utilisées dans les sprites
        update_sprite_animation(
                PLAYER_SPRITE_L_ID,
                PLAYER_SPRITE_ANIM_L,
                player_direction,
                player_animation_frame);
        player_animation_frame = update_sprite_animation(
                PLAYER_SPRITE_R_ID,
                PLAYER_SPRITE_ANIM_R,
                player_direction,
                player_animation_frame);
    }
}