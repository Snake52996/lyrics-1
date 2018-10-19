
public class Lyrics.Metasong : Object {
    public string artist { get; set; }
    public string title { get; set; }
    public string genre { get; set; }
    public string album { get; set; }
    public int64 duration { get; set; }
    public string uri  { get; set; }
    public string path  { get; set; }
    public string filename  { get; set; }
    public string thumb  { get; set; }

    public Metasong.from_metadata (HashTable<string,Variant> metadata) {
        artist = string.joinv (", ", metadata["xesam:artist"].get_strv ());
        title = metadata["xesam:title"].get_string ();
        genre = string.joinv (", ", metadata["xesam:genre"].get_strv ());
        album = metadata["xesam:album"].get_string ();
        duration = metadata["mpris:length"].get_int64 ();

        uri = metadata["xesam:url"].get_string ();
        var file = File.parse_name (uri);
        path = file.get_path ();
        filename = file.get_basename ();

        thumb = File.parse_name (metadata["mpris:artUrl"].get_string ()).get_path ();
        message (@"arturl $thumb");
    }

    public bool compare_uri (string uri2) {
        return uri == uri2;
    }

    public string to_string () {
        var builder = new StringBuilder ();
        builder.append (@"Artist: $artist");
        builder.append (@"Title: $title");
        builder.append (@"Album: $album");
        builder.append (@"Duration: $duration");
        builder.append (@"URI: $uri");
        builder.append (@"Path: $path");
        builder.append (@"Filename: $filename");
        return builder.str;
    }
}
