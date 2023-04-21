import themidibus.*;

MidiBus midiBus;
int rootNote = 54;
ArrayList<Integer> notesInKey;

int[] MAJOR_SCALE = {2, 2, 1, 2, 2, 2, 1};
int[] MINOR_SCALE = {2, 1, 2, 2, 1, 2, 2};

int N_OCTAVES = 8;

int octave = 3;
int previousNote = -1;
boolean isLatched = false;

void setup() {
  size(640, 360);
  background(255);

  midiBus = new MidiBus(this, -1, "SOUND");

  notesInKey = getScaleNotes(rootNote, MINOR_SCALE);
  
  println("started");
}

void draw() {}

void keyPressed() {
  println("Key: " + keyCode);
  // Tab 9
  // / 111
  // * 106
  // back 8
  // - 109
  // + 107
  // . 110
  // Enter 10
  
  switch (keyCode) {
    case 9: // Tab
      isLatched = !isLatched;
      // Also do:
    case 96: // 0
      if (previousNote >= 0) {
        midiBus.sendNoteOff(0, previousNote, 127);
        previousNote = -1;
      }
      break;
    case 109: // -
      notesInKey = getScaleNotes(rootNote, MINOR_SCALE);
      break;
    case 107: // +
      notesInKey = getScaleNotes(rootNote, MAJOR_SCALE);
      break;
    case 106: // *
      if (octave < N_OCTAVES) octave++;
      break;
    case 111: // /
      if (octave > 0) octave--;
      break;
  }

  // 1 to 9
  if (keyCode >= 97 && keyCode <= 105) {
    int number = keyCode - 96;
    int note = notesInKey.get((octave * 12) + number - 1);
    if (previousNote != note) {
      if (previousNote >= 0) {
        midiBus.sendNoteOff(0, previousNote, 127);
        println("Off: " + (previousNote));
      }

      midiBus.sendNoteOn(0, note, 127);
      println("On: " + note);
      previousNote = note;
    }
  }
}

void keyReleased() {
  // 1 to 9
  if (keyCode >= 97 && keyCode <= 105) {
    int number = keyCode - 96;
    int note = notesInKey.get((octave * 12) + number - 1);
    if (!isLatched && previousNote >= 0 && note == previousNote) {
      println("Off: " + note);
      midiBus.sendNoteOff(0, note, 127);
      previousNote = -1;
    }
  }
}
