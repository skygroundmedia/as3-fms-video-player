package src
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
		
	public class ProgressSlider
	{
		private var seekBarMc:MovieClip
		private var seekScrubMc:MovieClip;
		private var progPercent:Number;
		private var vl:VideoLoader;		
		private var isPlaying:Boolean;
		
		public function ProgressSlider ( seekBarMc:MovieClip, seekScrubMc:MovieClip, vl:VideoLoader )
		{
			this.seekBarMc	 = seekBarMc;
			this.seekScrubMc = seekScrubMc;
			this.vl = vl;
			this.isPlaying = vl.isPlaying;
			
			//This allows you to still be able to have 2 MovieClips on top of each other but still be able to access the MC underneath
			seekScrubMc.mouseEnabled = false;
			seekScrubMc.mouseChildren = false;
			
			seekBarMc.addEventListener( MouseEvent.MOUSE_DOWN, updateProgress );			
			seekBarMc.addEventListener( Event.ENTER_FRAME, showProgress );
		}
		
		public function activateListeners():void
		{
			seekBarMc.buttonMode = true;
			seekBarMc.addEventListener( MouseEvent.MOUSE_DOWN, updateProgress );			
		}

		public function deactivateListeners():void
		{
			seekBarMc.buttonMode = false;
			seekBarMc.removeEventListener( MouseEvent.MOUSE_DOWN, updateProgress );	
		}		
		
		private function showProgress( e:Event ):void
		{
			//A. When we are dragging the slider, the progress bar is going to try to update while we are dragging, so this forces the progress bar to only update when the sound isPlaying
			if( isPlaying == true)
			{
				progPercent = vl.nsTime / vl.nsDuration;
				//This ensures that there will be a value placed to the scaleX even if the FMS hasn't responded with the length of the NetStream
				if( !isNaN( progPercent ) ) seekScrubMc.scaleX = progPercent;
				else seekScrubMc.scaleX = 0;
			}			
		}
		
		private function updateProgress(e:MouseEvent):void
		{
			//A. When we are scrubbing through the seekBarMc, we dont' want to hear the audio hitter so pause the song
			if( isPlaying == true ) vl.pauseNs();
			else isPlaying = false;
			
			seekBarMc.stage.addEventListener(MouseEvent.MOUSE_UP, stopDragging);
			seekBarMc.removeEventListener(Event.ENTER_FRAME, showProgress);
		}
		
		private function stopDragging(e:MouseEvent):void
		{
			//A. Calculate the distance between where the user clicks on bar and the seekBarMc.width
			var dist:Number = ((e.localX) / seekBarMc.width);
			//trace(e.localX);
			//B. Update the Time so that when the song plays again, it will know where to begin
			vl.seekNs( dist * vl.nsDuration );
			//C. If the sound was playing as we dragged it, it will continue to play after we stop dragging
			if(isPlaying == true) vl.resumeNs();
			
			//D. Turn on the ENTER_FRAME listener again
			seekBarMc.addEventListener(Event.ENTER_FRAME, showProgress);
			seekBarMc.stage.removeEventListener(MouseEvent.MOUSE_UP, stopDragging);
		}
	}
}