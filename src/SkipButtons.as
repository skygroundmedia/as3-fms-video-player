package src
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;	
	
	public class SkipButtons
	{
		private var nextBtn:SimpleButton;
		private var prevBtn:SimpleButton;
		private var vl:VideoLoader
		
		public function SkipButtons (nextBtn, prevBtn, vl:VideoLoader)
		{
			this.nextBtn = nextBtn;
			this.prevBtn = prevBtn;
			this.vl = vl;	
		}
		
		public function activateListeners():void
		{
			nextBtn.addEventListener( MouseEvent.CLICK, nextNs );
			prevBtn.addEventListener( MouseEvent.CLICK, prevNs );
		}
		
		public function deactivateListeners():void
		{
			nextBtn.removeEventListener( MouseEvent.CLICK, nextNs );
			prevBtn.removeEventListener( MouseEvent.CLICK, prevNs );
		}
		
		private function nextNs( e:MouseEvent ):void
		{
			vl.changeNsAsset(1);
		}
		
		private function prevNs( e:MouseEvent ):void
		{
			vl.changeNsAsset(-1);			
		}
	}
}