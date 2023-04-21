import java.util.*;

ArrayList<Integer> getScaleNotes(int rootNote, int[] scale) {
  ArrayList<Integer> notesList = new ArrayList<Integer>();
  
  int scalePos = 0;
  int note = rootNote;
  int lastNote = 1 + (N_OCTAVES + 2) * 12; // Add one for the 9th not of the last octave
  
  do {
    notesList.add(note);
    note += scale[scalePos];
    scalePos = scalePos < scale.length - 1 ? scalePos + 1 : 0;
  } while (note <= lastNote);
  
  do {
    if (note != rootNote) notesList.add(note);
    note -= scale[scalePos];
    scalePos = scalePos > 0 ? scalePos - 1 : scale.length - 1;
  } while (note >= 0);
  
  Collections.sort(notesList);   

  return notesList;
}
