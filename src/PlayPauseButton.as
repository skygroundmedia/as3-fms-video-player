package src 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class PlayPauseButton
	{
		private var playMc:MovieClip;
		private var vl:VideoLoader;
		
		public function PlayPauseButton ( playMc:MovieClip, vl:VideoLoader)
		{
			this.playMc = playMc;
			this.vl = vl;
		}
		
		public function activateListeners():void
		{
			playMc.buttonMode = true;
			playMc.addEventListener( MouseEvent.MOUSE_OVER, toggleButtonHandler, false, 0, true );
			playMc.addEventListener( MouseEvent.MOUSE_OUT, toggleButtonHandler, false, 0, true );
			playMc.addEventListener( MouseEvent.CLICK, toggleButtonHandler, false, 0, true );
			playMc.addEventListener( MouseEvent.CLICK, togglePauseHandler, false, 0, true );
		}
		
		public function deactivateListeners():void
		{
			playMc.buttonMode = false;
			playMc.removeEventListener( MouseEvent.MOUSE_OVER, toggleButtonHandler );
			playMc.removeEventListener( MouseEvent.MOUSE_OUT, toggleButtonHandler );
			playMc.removeEventListener( MouseEvent.CLICK, toggleButtonHandler );
			playMc.removeEventListener( MouseEvent.CLICK, togglePauseHandler );
		}

		private function toggleButtonHandler( e:MouseEvent ):void
		{
		//	trace(e.type + "\n" + e.target.currentFrame + "\n" + e.target.currentLabel);
			if(e.type == "mouseOver")
				if(e.target.currentLabel == "play") e.target.gotoAndStop("playOver");
				else if (e.target.currentLabel == "pause") e.target.gotoAndStop("pauseOver");
			if(e.type == "mouseOut")
				if(e.target.currentLabel == "playOver") e.target.gotoAndStop("play");
				else if (e.target.currentLabel == "pauseOver") e.target.gotoAndStop("pause");
			if(e.type == "click")
				if (e.target.currentLabel == "playOver") e.target.gotoAndStop("pauseOver");
				else if (e.target.currentLabel == "pauseOver") e.target.gotoAndStop("playOver");			
		}

		private function togglePauseHandler( e:MouseEvent ):void
		{
			vl.togglePauseNs();
		}
	}
}