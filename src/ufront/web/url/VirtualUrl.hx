package ufront.web.url;

/**
A `VirtualUrl` is similar to its super-class `PartialUrl`, except that it keeps track of if the URL is intended to be "Virtual" or "Physical".

- A "Physical" URL means that the path is actually a physical file and is available through the web server, and does not require routing through Ufront.
  It is suitable for physical assets, such as stylesheets and javascript files.
- A "Virtual" URL means that the path is not a physical file, and must be loaded through Ufront (through your `index.n` file or similar).
  It is suitable for any page generated by Ufront.

Each URL is considered "virtual" by default, but is marked `isPhysical` if:

- The URL begins with a `~`, for example: `~/js/client.js` if considered physical, while `/js/client.js` is considered virtual.
- The function call to `VirtualUrl.parse()` (or `HttpContext.generateUri()`) passes an argument to specify `isPhysical=true`.
**/
class VirtualUrl extends PartialUrl {

	/** Did the parsed URL begin with a `~` segment, so is it intended to be relative to the app path? **/
	public var isPhysical:Bool;

	function new( ?isPhysical:Bool=false ) {
		super();
		this.isPhysical = isPhysical;
	}

	/** Parse a URL into a `VirtualUrl` object, being careful to check for a leading "~" segment. **/
	public static function parse( url:String, ?isPhysical:Bool=false ) {
		var u = new VirtualUrl( isPhysical );
		feed( u, url );
		return u;
	}

	/** Process a URL string and feed it into the given `VirtualUrl` object. **/
	static function feed( u:VirtualUrl, url:String ) {
		PartialUrl.feed( u, url );
		if( u.segments[0]=="~" ) {
			u.segments.shift();
			if( u.segments.length==1 && u.segments[0]=="" )
				u.segments.pop();
			u.isPhysical = true;
		}
	}
}
