package src
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.display.StageDisplayState;
	
	public class FullScreen
	{
		private var fsBtn:MovieClip;
		private var vl:VideoLoader;
		private var appStage:Stage;
		
		public function FullScreen( fsBtn:MovieClip, appStage:Stage, vl:VideoLoader )
		{
			this.fsBtn = fsBtn;
			this.vl = vl;
			this.appStage = appStage;
			
			fsBtn.buttonMode = true;
			fsBtn.addEventListener(MouseEvent.CLICK, goScaledFullScreen);
			fsBtn.addEventListener(MouseEvent.MOUSE_OVER, toggleButtonHandler, false, 0, true );
			fsBtn.addEventListener(MouseEvent.MOUSE_OUT, toggleButtonHandler, false, 0, true );
			fsBtn.addEventListener(MouseEvent.CLICK, toggleButtonHandler, false, 0, true );
		}
		
		private function goScaledFullScreen( e:MouseEvent ):void
		{
			if(appStage.displayState == StageDisplayState.NORMAL) appStage.displayState = StageDisplayState.FULL_SCREEN;
			else appStage.displayState = StageDisplayState.NORMAL;
			trace("appStage.displayState: " + appStage.displayState );
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


	}
}