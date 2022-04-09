static int instant = 1;
static int topbar = 1;  /* -b  option; if 0, dmenu appears at bottom */
static int fuzzy = 1;   /* -F  option; if 0, dmenu doesn't use fuzzy matching */

/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
    "JetBrains Mono Nerd Font:size=10:style=medium:antialias=true:autohint=true",
    "NotoColorEmoji:size=13",
};

static const char *prompt = NULL;      /* -p  option; prompt to the left of input field */

static const char *colors[SchemeLast][2] = {
	/*                           fg         bg       */
	[SchemeNorm]            = { "#fbf1c7", "#1d2120" },
	[SchemeSel]             = { "#000000", "#83a598" },
	[SchemeSelHighlight]    = { "#fbf1c7", "#10385f" },
	[SchemeNormHighlight]   = { "#cc241d", "#1d2120" },
	[SchemeOut]             = { "#000000", "#689d6a" },
	[SchemeMid]             = { "#fbf1c7", "#000000" },
};

/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines = 0;

/* -h option; minimum height of a menu line */
static unsigned int lineheight = 6;
static unsigned int min_lineheight = 4;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* Size of the window border */
static const unsigned int border_width = 2;
