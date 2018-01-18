// JukeBox

import Foundation

class CD {
    // Stores data like id, artist and songs
}

class Song {
    // Stores data like id, title, length, etc
}

class User {
    // General information of the user: name, id, etc
}

class SongSelector {
    // Allows to the user to select the songs and keeps a big queue of songs to play.
    // Interacts directly with the cd player, due that the cdplayer can just store one CD at time.
    // Additionaly display the info of the current song and the following songs
    var currentSong: Song? {
        return nil
    }
}

// A list of songs to play, not necessarily songs from the same CD
class PlayList {
    private var song: Song
    private var songsQueue: [Song]
    
    init(song: Song, songQueue: [Song]) {
        self.song = song
        self.songsQueue = songQueue
    }
    
    var nextSongToPlay: Song? {
        return self.songsQueue.first
    }
    
    func queueSong(_ song: Song) {
        self.songsQueue.append(song)
    }
}

// CD player that can store one cd to play and follows
// a playlist composed of song inside of the provided cd.
class CDPlayer {
    var playList: [Song]
    var cd: CD
    
    init(cd: CD, playlist: [Song]) {
        self.playList = playlist
        self.cd = cd
    }
    
    func playSong(_ song: Song) {
        
    }
}

// Basic stucture of the Jukebox itself
class Jukebox {
    private let cdPlayer: CDPlayer
    private var user: User
    private let cdCollection: [CD]
    private let songSelector: SongSelector
    
    init(cdPlayer: CDPlayer, user: User, cdCollection: [CD], songSelector: SongSelector) {
        self.cdPlayer = cdPlayer
        self.user = user
        self.cdCollection = cdCollection
        self.songSelector = songSelector
    }
    
    var currentSong: Song? {
        return self.songSelector.currentSong
    }
}
