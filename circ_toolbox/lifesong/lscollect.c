/*
 * LSCOLLECT Lifesong data collection core program
 *  
 * 
 * Simon D. Levy        Hall Lab       Brandeis University      2001
 */

#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <X11/Xos.h>
#include <X11/Xatom.h>
#include <signal.h>
#include <stdio.h>
#include <math.h>
#include <sys/timeb.h>
#include <dmedia/dmedia.h>

/* recording time */
static double seconds;

/* map between keypad offsets and indices */ \
static int keymap[9] = {7, 4, 8, 6, 2, 9, 3, 1, 5};

#define LOGFILE "lifesong.log"

#define SFCOMMAND \
"/usr/local/matlab/lifesong/sfrecord -time %f -fileformat wave -channels 1 -rate 8000 lifesong.wav &"

#define WIDTH 600
#define HEIGHT 200

#define BITMAPDEPTH 1
#define TOO_SMALL 0
#define BIG_ENOUGH 1

#define FONTNAME "12x24"

long get_msec();
static long start_msec;

static Display *display;
  unsigned int display_width, display_height;
static int screen_num;
static char *progname;
static GC gc;
static XFontStruct *font_info;
static Window win;
static  unsigned int win_width, win_height;
static FILE *fp;
static XKeyboardControl kbd_control;


int main(int argc, char **argv) {

  void getGC();
  void load_font();
  void event_loop();
  
  int x, y;   /* window position */
  unsigned int border_width = 4;  /* four pixels */
  char *window_name = "Lifesong Data Collection Program";
  XSizeHints size_hints;
  char *display_name = NULL;
  int do_exit();

  progname = argv[0];

  /* check arg provided */
  if (argc < 2) {
    fprintf(stderr, "%s: No argument provided for # seconds\n", progname);
    exit(1);
  }

  /* check file opened okay */
  if (!(fp=fopen(LOGFILE, "w"))) {
    fprintf(stderr, "%s: Couldn't open log file %s for writing\n", 
	    progname, LOGFILE);
    exit(1);
  }

  /* connect to X server */
  if ( (display=XOpenDisplay(display_name)) == NULL )
  {
    fprintf(stderr, "%s: cannot connect to X server %s\n", 
            progname, XDisplayName(display_name));
    exit(1);
  }

  /* get recording duration in seconds */
  seconds = atof(argv[1]);

  /* get screen size from display structure macro */
  screen_num = DefaultScreen(display);
  display_width = DisplayWidth(display, screen_num);
  display_height = DisplayHeight(display, screen_num);

  /* Note that in a real application, x and y would default to 0
   * but would be settable from the command line or resource database.  
   */
  x = y = 0;

  /* size window size to whole display */
  win_width = display_width, win_height = display_height;

  /* create opaque window */
  win = XCreateSimpleWindow(display, RootWindow(display,screen_num), 
      x, y, win_width, win_height, border_width, BlackPixel(display,
      screen_num), WhitePixel(display,screen_num));

  /* Set size hints for window manager.  The window manager may
   * override these settings.  Note that in a real
   * application if size or position were set by the user
   * the flags would be UPosition and USize, and these would
   * override the window manager's preferences for this window. */
#ifdef X11R3
  size_hints.flags = PPosition | PSize | PMinSize;
  size_hints.x = x;
  size_hints.y = y;
  size_hints.width = width;
  size_hints.height = height;
  size_hints.min_width = WIDTH;
  size_hints.min_height = HEIGHT;
#else /* X11R4 or later */
  /* x, y, width, and height hints are now taken from
   * the actual settings of the window when mapped. Note
   * that PPosition and PSize must be specified anyway. */

  size_hints.flags = PPosition | PSize | PMinSize;
  size_hints.min_width = WIDTH;
  size_hints.min_height = HEIGHT;
#endif

#ifndef X11R3
/* X11R4 or later */
  {
  XWMHints wm_hints;
  XClassHint class_hints;

  /* format of the window name has changed in R4 */
  XTextProperty windowName;

  /* These calls store window_name into XTextProperty structures and
   * set their other fields properly. */
  if (XStringListToTextProperty(&window_name, 1, &windowName) == 0) {
    (void) fprintf( stderr, 
		    "%s: structure allocation for windowName failed.\n", 
		    progname);
    exit(-1);
  }
    
  wm_hints.initial_state = NormalState;
  wm_hints.input = True;
  wm_hints.flags = StateHint | InputHint;

  class_hints.res_name = progname;
  class_hints.res_class = "Collect";

  XSetWMProperties(display, win, &windowName, 0L, 
      argv, argc, &size_hints, &wm_hints, 
      &class_hints);
  }
#endif

  /* select event types wanted */
  XSelectInput(display, win, 
	       FocusChangeMask | ExposureMask | KeyPressMask | KeyReleaseMask);

  /* load font and get font information structure */
  load_font();

  /* create GC for text and drawing */
  getGC();

  /* display window */
  XMapWindow(display, win);

  /* start timer */
  start_msec = get_msec();

  /* disallow keyboard auto-repeat */
  kbd_control.auto_repeat_mode = 0;
  XChangeKeyboardControl (display, KBAutoRepeatMode, &kbd_control);

  /* handle events till done */
  event_loop();

  /* close log file */
  fclose(fp);

  /* done */
  return do_exit();
}

/* handle events until ENTER is hit twice */
void event_loop() {

  void draw_text(char *, int, int);
  void handle_key_event(XEvent *, FILE *);
  void ring_callback(int);
  XEvent event;

  /* issue Unix shell command for recording */
  char cmd[200];
  sprintf(cmd, SFCOMMAND, seconds);
  system(cmd);

  /* set up for alarm callback */
  signal(SIGALRM, ring_callback);
  alarm((int)seconds);

  /* get events, use first to display text and graphics */
  while (1)  {

    XNextEvent(display, &event);

    switch  (event.type) {

    case Expose:
      /* unless this is the last contiguous expose,
       * don't draw the window */
      if (event.xexpose.count != 0)
        break;
      draw_text("RECORDING...", display_width/2, display_height/2);
      break;


    case KeyPress:
      handle_key_event(&event, fp);
      break;
      
    case KeyRelease:
      handle_key_event(&event, fp);
      break;

    default:
      /* all events selected by StructureNotifyMask
       * except ConfigureNotify are thrown away here,
       * since nothing is done with them */
      break;

    } /* end switch */

  } /* end while */

  puts("DONE");
  
}

/* handle key presses, returning 1 if Enter is hit, else 0 */
void handle_key_event(XEvent *event, FILE *fp) {
  
  XComposeStatus compose;
  KeySym keysym;
  char buffer[20];
  int bufsize = 20;
  long long ust;
  void draw_text(char *, int, int);
  int key;
  static int keystate[9];
  static int already_hit;
  
  /* clear window on first keypress */
  if (!already_hit) {
    XClearWindow(display, win);
    already_hit = 1;
  }

  XLookupString((XKeyEvent *)event, buffer, bufsize, &keysym, &compose);

  key = keysym - 0xff95;

  /* ignore keys out of range */
  if (key >= 0 && key <=8 ) {

    /* lookup key symbol in table */
    int keynum = keymap[key];

    /* if in range, process key */
    if (keynum >=1 && keynum <= 9) {

      unsigned long lapse = get_msec() - start_msec;

      int x_offset = win_width/2, y_offset = win_width/2;

      /* helps put feedback message in center of window */
      int font_width = font_info->min_bounds.width;
      int font_height = font_info->ascent + font_info->descent;
      int what = (event->type == KeyPress);
      int i;

      keystate[keynum] = what;

      for (i=0; i<9; ++i) {
	int key_x = x_offset + ((keynum-1) % 3) * font_width;
	int key_y = y_offset - ((keynum-1) / 3) * font_height;
	if (keystate[keynum]) {
	  char text[2];
	  text[0] =  '0'+ keynum;
	  draw_text(text, key_x, key_y);
	}
	else {
	  XClearArea(display, win, key_x, key_y - font_height, 
		     font_width, font_height, 0);
	}
      }

      /* record event in file */
      dmGetUST(&ust);
      fprintf(fp, "%d %d %ld %lld\n", keynum, what, lapse, ust);
    }
  }
}


/* create GC for text and drawing */
void getGC() {

  unsigned long valuemask = 0; /* ignore XGCvalues and use defaults */
  XGCValues values;

  /* Create default Graphics Context */
  gc = XCreateGC(display, win, valuemask, &values);

  /* specify font */
  XSetFont(display, gc, font_info->fid);
}

/* load font and get font information structure */
void load_font() {

  if ((font_info = XLoadQueryFont(display,FONTNAME)) == NULL)
  {
    (void) fprintf( stderr, "%s: Cannot open %s font\n", progname, FONTNAME);
    exit( -1 );
  }
}

/* draw text message in window */
void draw_text(char *txt, int x_offset, int y_offset) {

  XDrawString(display, win, gc, x_offset, y_offset, txt, strlen(txt));

}

/* get current time in milliseconds */
long get_msec() {

  struct timeb tb;
  ftime(&tb);
  return (tb.time*1000 + tb.millitm);
}

/* called by signal() */
void ring_callback(int signo) {

  int do_exit();
  signal(SIGALRM,SIG_IGN);
  do_exit();
}

/* exit gracefully */
int do_exit() {

  XEvent dummy;

  /* you can ring my bell... */
  XBell(display, 100);

  /* re-allow keyboard auto-repeat */
  kbd_control.auto_repeat_mode = 1;
  XChangeKeyboardControl (display, KBAutoRepeatMode, &kbd_control);

  /* issue and handle a dummy event, so bell will ring */
  XPutBackEvent(display, &dummy);
  XNextEvent(display, &dummy);
  XFlush(display);

  exit(0);

}
