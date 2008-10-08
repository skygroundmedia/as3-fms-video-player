/**********************************************************************************************
 * <?xml version="1.0" encoding="UTF-8"?>
 * <videos> 
 * 	 <video> 
 *     <title>Adobe Band 800k</title> 
 *     <directory>2008/08/01/</directory> 
 *     <src>AdobeBand_800K_H264.mp4</src> 
 *   </video> 
 * </videos>
 * 
 **********************************************************************************************/
package src
{
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class XMLLoader extends EventDispatcher
	{
		private var _data:Array;

		public function XMLLoader(target:IEventDispatcher=null)
		{
			super(target);
		}

		public function load( xmlURL:String ):void
		{
			var loader:URLLoader = new URLLoader();
				loader.addEventListener( Event.COMPLETE, onXMLLoaded );
				loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, false, 0, true);
				loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false, 0, true);
				loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
				loader.addEventListener(ProgressEvent.PROGRESS, progressHandler, false, 0, true);
				loader.load( new URLRequest( xmlURL ) );
		}
		
		public function getImageData():Array
		{
			return _data;
		}

		private function onXMLLoaded( e:Event ):void
		{
			_data = new Array();
			
			var xml:XML = new XML( e.currentTarget.data );
			var videos:XMLList = xml.child( "video" );
			var numVideos:uint = videos.length();
			var image:XML;
			
			for(var i:uint = 0; i < numVideos; i++){
				video = videos[i] as XML;
				//trace( image.child("caption") );				
				_data.push( new Video( image.child("title").toString(), image.child("directory").toString(), image.child("src").toString() ) );
			}
			//Fire once the XML has been converted into Image Objects
			dispatchEvent( new Event( Event.COMPLETE ) );			
		}
		
		private function httpStatusHandler (e:Event):void
		{
			//trace("httpStatusHandler:" + e);
		}
		
		private function securityErrorHandler (e:Event):void
		{
			trace("securityErrorHandler:" + e);
		}
		
		private function ioErrorHandler(e:Event):void
		{
			trace("ioErrorHandler: " + e);
		}
		
		private function progressHandler(e:Event):void
		{
			//trace(e.currentTarget.bytesLoaded + " / " + e.currentTarget.bytesTotal);
		}
	}
}