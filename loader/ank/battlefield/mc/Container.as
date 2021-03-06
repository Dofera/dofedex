class ank.battlefield.mc.Container extends MovieClip
{
	function Container(var2, var3, var4)
	{
		super();
		if(var3 != undefined)
		{
			this.initialize(var3,var4,var5);
		}
	}
	function initialize(var2, var3, var4)
	{
		if(var3 == undefined)
		{
			ank.utils.Logger.err("pas de _oDatacenter !");
		}
		this._mcBattlefield = var2;
		this._oDatacenter = var3;
		this._sObjectsFile = var4;
		this.clear(true);
	}
	function clear(var2)
	{
		this.maxDepth = 0;
		this.minDepth = -1000;
		this.zoom(100);
		if(this.ExternalContainer == undefined || var2)
		{
			this.createEmptyMovieClip("ExternalContainer",100);
			var var3 = new MovieClipLoader();
			var3.addListener(this._parent);
			if(var2)
			{
				this.ExternalContainer.clear();
			}
			var3.loadClip(this._sObjectsFile,this.ExternalContainer);
		}
		else
		{
			this.ExternalContainer.clear();
		}
		this.SpriteInfos.removeMovieClip();
		this.createEmptyMovieClip("SpriteInfos",200);
		this.Points.removeMovieClip();
		this.createEmptyMovieClip("Points",300);
		this.Text.removeMovieClip();
		this.createEmptyMovieClip("Text",400);
		this.OverHead.removeMovieClip();
		this.createEmptyMovieClip("OverHead",500);
		if(!this.LoadManager)
		{
			this.createEmptyMovieClip("LoadManager",600);
		}
	}
	function applyMask(var2)
	{
		var var3 = this._oDatacenter.Map.width - 1;
		var var4 = this._oDatacenter.Map.height - 1;
		if(var2 == undefined)
		{
			var2 = true;
		}
		this.createEmptyMovieClip("_mcMask",10);
		if(var2)
		{
			this._mcMask.beginFill(0);
			this._mcMask.moveTo(0,0);
			this._mcMask.lineTo(var3 * ank.battlefield.Constants.CELL_WIDTH,0);
			this._mcMask.lineTo(var3 * ank.battlefield.Constants.CELL_WIDTH,var4 * ank.battlefield.Constants.CELL_HEIGHT);
			this._mcMask.lineTo(0,var4 * ank.battlefield.Constants.CELL_HEIGHT);
			this._mcMask.lineTo(0,0);
			this._mcMask.endFill();
		}
		else
		{
			this._mcMask.beginFill(0);
			this._mcMask.moveTo(-1000,-1000);
			this._mcMask.lineTo(-1000,-999);
			this._mcMask.lineTo(-999,-999);
			this._mcMask.lineTo(-999,-1000);
			this._mcMask.lineTo(-1000,-1000);
			this._mcMask.endFill();
		}
		this.setMask(this._mcMask);
	}
	function adjusteMap(var2)
	{
		this.zoomMap();
		this.center();
	}
	function setColor(var2)
	{
		if(var2 == undefined)
		{
			var2 = new Object();
			var2.ra = 100;
			var2.rb = 0;
			var2.ga = 100;
			var2.gb = 0;
			var2.ba = 100;
			var2.bb = 0;
		}
		var var3 = new Color(this);
		var3.setTransform(var2);
	}
	function zoom(var2)
	{
		this._xscale = var2;
		this._yscale = var2;
	}
	function getZoom()
	{
		return this._xscale;
	}
	function setXY(var2, var3)
	{
		this._x = var2;
		this._y = var3;
	}
	function center(var2)
	{
		var var3 = this._xscale / 100;
		var var4 = this._yscale / 100;
		var var5 = (this._mcBattlefield.screenWidth - ank.battlefield.Constants.CELL_WIDTH * var3 * (this._oDatacenter.Map.width - 1)) / 2;
		var var6 = (this._mcBattlefield.screenHeight - ank.battlefield.Constants.CELL_HEIGHT * var4 * (this._oDatacenter.Map.height - 1)) / 2;
		this.setXY(var5,var6);
	}
	function zoomMap(var2)
	{
		var var3 = this.getZoomFactor();
		if(var3 == 100)
		{
			return false;
		}
		this.zoom(var3,false);
		return true;
	}
	function getZoomFactor(var2)
	{
		var var3 = this._oDatacenter.Map.width;
		var var4 = this._oDatacenter.Map.height;
		var var5 = 0;
		if(var3 <= ank.battlefield.Constants.DEFAULT_MAP_WIDTH)
		{
			return 100;
		}
		if(var4 <= ank.battlefield.Constants.DEFAULT_MAP_HEIGHT)
		{
			return 100;
		}
		if(var4 > var3)
		{
			var5 = this._mcBattlefield.screenWidth / (ank.battlefield.Constants.CELL_WIDTH * (var3 - 1)) * 100;
		}
		else
		{
			var5 = this._mcBattlefield.screenHeight / (ank.battlefield.Constants.CELL_HEIGHT * (var4 - 1)) * 100;
		}
		return var5;
	}
}
