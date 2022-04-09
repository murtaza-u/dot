/* Lemonaid does not do lemonbar specific formatting for you
 * This means you yourself have to add the format specifiers for bg, fg,
 * underline, overline, etc.
 * This gives the user much more control over how they want to setup their bar.
 * Lemonaid only handles the signals and runs your commands after the specified
 * time interval.
 * This makes lemonaid more akin to the unix philosophy and helps make the
 * codebase lean and clean
 */

static const unsigned short int left = 0;     // no. of left aligned blocks
static const unsigned short int centre = 0;   // no. of centre aligned blocks
static const unsigned short int right = 11;   // no. of right aligned blocks

// Blocks must be in the order of their alignment
static const Block blocks[] = {
    // command                  update interval(in s)   update signal
    {"crypto",                  3600,                   16},
    {"cpu",                     60,                     1},
    {"mem",                     60,                     2},
    {"tempt",                   60,                     3},
    {"weather",                 3600,                   5},
    {"vol",                     0,                      10},
    {"brightness-indicator",    0,                      14},
    {"battery",                 60,                     6},
    {"net",                     1,                      21},
    {"wifi-indicator",          0,                      12},
    {"clock",                   60,                     7},
};

// sets delimeter between status commands. NULL character ('\0') means no delimeter.
static const char *delim = "  ";
static const unsigned int delim_length = 3;
