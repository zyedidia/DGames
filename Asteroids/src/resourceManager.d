import std.path;
import std.file;
import std.stdio;

import dsfml.graphics;
import dsfml.audio;

import util;

class ResourceManager {
    static string RES_PATH;
    static Texture[string] textures;
    static Sound[string] sounds;

    static void init(string arg0) {
        this.RES_PATH = dirName(arg0) ~ "/res";
    }

    static void loadSounds() {
        foreach (DirEntry d; dirEntries(RES_PATH ~ "/sound", SpanMode.shallow)) {
            if (d.name.contains(".wav") || d.name.contains(".ogg")) {
                SoundBuffer buffer = new SoundBuffer();
                if (!buffer.loadFromFile(d.name)) {
                    writeln("Error loading " ~ d.name);
                }

                Sound sound = new Sound();
                sound.setBuffer(buffer);
                sounds[baseName(d.name)] = sound;
            }
        }
    }

    static void loadTextures(string path = "img") {
        foreach (DirEntry d; dirEntries(RES_PATH ~ "/" ~ path, SpanMode.shallow)) {
            if (d.isDir()) {
                loadTextures(path ~ "/" ~ baseName(d.name));
            }
            if (d.name.contains(".png")) {
                Texture t = new Texture();
                if (!t.loadFromFile(d.name)) {
                    writeln("Error loading " ~ d.name);
                }
                textures[baseName(d.name)] = t;
            }
        }
    }
}
