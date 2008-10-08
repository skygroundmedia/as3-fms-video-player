package src
{
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class VolumeControl
	{
		private var volBarMc:MovieClip;
		private var volScrubMc:MovieClip;
		private var volMeterMc:MovieClip
		private var vl:VideoLoader;
		
		public function VolumeControl (volBarMc:MovieClip, volScrubMc:MovieClip, volMeterMc:MovieClip, vl:VideoLoader)
		{
			this.volBarMc = volBarMc;
			this.volScrubMc = volScrubMc;
			this.volMeterMc = volMeterMc;
			this.vl = vl;
			
			//A. This allows you to have 2 MovieClips on top of one another yet still have access to the MC underneath
			volScrubMc.mouseEnabled = false;
			volScrubMc.mouseChildren = false;
						
			//B. Adjust the Volume Bar based on the Current Volume of the Song
			volScrubMc.scaleX = vl.getVol();
			//C. Look at the current volume of the sound and divide it into equal segments, then decide which segement volMeterMc is currently on
			volMeterMc.gotoAndStop(volMeterMc.currentLabels[Math.floor((volScrubMc.scaleX * (volBarMc.width - 1)) / (volBarMc.width / volMeterMc.currentLabels.length))].name);
		}
		
		public function activateListeners():void
		{
			volBarMc.buttonMode = true;
			volBarMc.addEventListener( MouseEvent.MOUSE_DOWN, volStartDrag );		
		}
		
		public function deactivateListeners():void
		{
			volBarMc.buttonMode = false;
			volBarMc.removeEventListener( MouseEvent.MOUSE_DOWN, volStartDrag );		
		}
		
		private function volStartDrag( e:MouseEvent ):void
		{
			updateVolume( e );
			volBarMc.addEventListener(MouseEvent.MOUSE_MOVE, updateVolume);
			volBarMc.stage.addEventListener(MouseEvent.MOUSE_UP, volumeStopDrag);
			volScrubMc.addEventListener(MouseEvent.MOUSE_MOVE, updateVolume);			
		}
		
		private function volumeStopDrag( e:MouseEvent ):void
		{
			volBarMc.removeEventListener(MouseEvent.MOUSE_MOVE, updateVolume);
			volBarMc.stage.removeEventListener(MouseEvent.MOUSE_UP, volumeStopDrag);			
			volScrubMc.removeEventListener(MouseEvent.MOUSE_MOVE, updateVolume);			
		}
		
		public function updateVolume( e:MouseEvent ):void
		{
			//A. Calculate the Distance Between the MouseXPosition (e.localX) and the volbarMc
			var dist:Number = ( (e.localX) / volBarMc.width );
			if ( dist >= 0 && dist <= 1 ){
				//i. Adjust the Volume Bar GUI
				volScrubMc.scaleX = dist;
				//ii. Adjust the Sound Volume
				vl.setVol( dist );
				//iii. Adjust the Volume Meter GUI
				updateVolMeter(dist);
			}
		}
		
		private function updateVolMeter( dist:Number ):void
		{
			//A. volMeterMc has a number of FrameLabels inside it's MovieClip representing the different GUI states (Be sure to Look!)
			//B. Divide the Width of the volBarMc into an equal amount of FrameLables | Segments
			var segments:Number = volBarMc.width / volMeterMc.currentLabels.length;
			//C. Based on the where the user adjusts their volume (i.e. 50%, 20%), calculate which segment that would fall under
			var label:FrameLabel = volMeterMc.currentLabels[Math.floor(dist * (volBarMc.width - 1) / segments)];
			//D. Jump to that Frame label to update the GUI
			volMeterMc.gotoAndStop(label.name);			
		}
	}
}