import dsfml.audio;
import std.file;
import std.string;
import std.stdio;
import std.path;

class ResourceManager {
    static Sound[string] sounds;

    static void loadSounds(string resPath) {
        foreach (DirEntry d; dirEntries(resPath, SpanMode.shallow)) {
            if (d.name.indexOf(".wav") != -1) {
                SoundBuffer buffer = new SoundBuffer();
                if (!buffer.loadFromFile(d.name))
                    writeln("Error loading " ~ d.name);

                Sound sound = new Sound();
                sound.setBuffer(buffer);
                sounds[baseName(d.name)] = sound;
            }
        }
    }
}
