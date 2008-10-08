package src
{
	public class VideoObject extends Object
	{
		public var title:String;
		public var dir:String;
		public var path:String;

		public function VideoObject( title:String, directory:String, path:String )
		{
			this.title = title;
			this.dir   = directory;
			this.path  = path;
		}
	}
}