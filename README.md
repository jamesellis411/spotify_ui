# Spotify Player UI — SwiftUI Recreation

A pixel-faithful recreation of Spotify’s now-playing screen built with **SwiftUI**. This project focuses on UI patterns and interaction design: a custom draggable progress slider, animated marquee metadata, and fully interactive playback controls. A Combine timer simulates playback and cleanly halts at track end.

![Demo](./Docs/demo.gif) <!-- Replace with your GIF or remove this line -->

---

## Features

- 🎚️ **Custom Spotify-style slider** (`GeometryReader` + `DragGesture`) with clamped seeking  
- 🏷️ **Marquee artist metadata** that auto-scrolls long text and loops smoothly  
- ⏱️ **Playback simulation** using `Timer.publish(...).autoconnect()`  
- ❤️ **Micro-interactions**: like (heart) toggle, play/pause swap, end-of-track handling  
- 🖼️ **Responsive layout**: scalable album art, safe-area gradient background  
- 🔢 **Readable timing**: `formatTime` with monospaced digits to prevent jitter

---

Here’s the UI running on the simulator:

<img src="./Docs/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202025-09-27%20at%2000.19.20.png" 
     alt="Spotify UI Screenshot" 
     width="400"/>

Looks pretty close to the real Spotify player!
