-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local fps = require("fps");
-- Screen measurements
_W = display.contentWidth - display.screenOriginX*2
_H = display.contentHeight - display.screenOriginY*2
_TL = { x = 0 + display.screenOriginX, y = 0 + display.screenOriginY }
_TR = { x = display.contentWidth - display.screenOriginX, y = 0 + display.screenOriginY }
_BL = { x = 0 + display.screenOriginX, y = display.contentHeight - display.screenOriginY }
_BR = { x = display.contentWidth - display.screenOriginX, y = display.contentHeight - display.screenOriginY }
_C = { x = display.contentWidth/2, y = display.contentHeight/2 }

local random = math.random;
local sin = math.sin;
local cos = math.cos;
local tan = math.tan;
local round = math.round;
local ceil = math.ceil;
local floor = math.floor;
local sqrt = math.sqrt;
local abs = math.abs;
local pow = math.pow;
local atan2 = math.atan2;
local rad = math.rad;
local pi = math.pi;

local background = display.newRect( _C.x, _C.y, _W, _H );
background:setFillColor( .4,.4,.5 );



local mainGroup = display.newGroup();
local rockGroup = display.newGroup();
mainGroup:insert(rockGroup);

function makeRock()
	local rockShape = {}

	local points = 20;

	local pointSize = 360/points;

	for i=1,points do
		local angle = pointSize*i;
		local distanceFromCenter = random(35,50);
		local position = {
			x = ceil(cos(rad(angle))*distanceFromCenter),
			y = ceil(sin(rad(angle))*distanceFromCenter)
		}
		rockShape[#rockShape+1] = position.x;
		rockShape[#rockShape+1] = position.y;
	end

	local rock = display.newPolygon( 0, 0, rockShape )
	rock.anchorX,rock.anchorY = .5,.5;
	
	return rock;
end


local rock1 = makeRock();
rock1.x,rock1.y = _C.x+100,_C.y-100;
rockGroup:insert(rock1);
rock1.strokeWidth = 40;
rock1:setStrokeColor( 1,0,0 );

local rock2 = makeRock();
rock2.x,rock2.y = _C.x+100,_C.y+100;
rockGroup:insert(rock2);
rock2.strokeWidth = 40;
rock2:setStrokeColor( 1,0,0 );

transition.to( mainGroup, {x=_C.x,time=4000,iterations=-1} )



local testGradients = true;

local paint = {
	type = "gradient",
    color1 = {1,1,1},
    color2 = {0,0,0},
    direction = "left"
}

local amountToTest = 10;

local testAlphas = {}
local testGradients = {}

for i=1,amountToTest do
	testAlphas[i] = display.newRect( _C.x, _C.y, _W, _H );
	testGradients[i] = display.newRect( _C.x, _C.y, _W, _H );

	testGradients[i].fill = paint;
	testAlphas[i].alpha = 0.01;

	testGradients[i].isVisible = false;
	testAlphas[i].isVisible = false;
end

local debugText = display.newText( "Nothing",_C.x,100,"Arial",20 );

local display = 0;
timer.performWithDelay( 3000, function() 
	display = display + 1;

	if(display == 1)then
		debugText.text = "0.01 alpha"
		for i=1,amountToTest do
			testGradients[i].isVisible = false;
			testAlphas[i].isVisible = true;
		end
	end

	if(display == 2)then
		debugText.text = "Gradients"
		for i=1,amountToTest do
			testGradients[i].isVisible = true;
			testAlphas[i].isVisible = false;
		end
	end

	if(display == 3)then
		debugText.text = "Nothing"
		for i=1,amountToTest do
			testGradients[i].isVisible = false;
			testAlphas[i].isVisible = false;
		end
		display = 0;
	end

end,-1);



local fps = require("fps")
local performance = fps.PerformanceOutput.new();
performance.group.x, performance.group.y = 0,_H-100;
performance.alpha = 0.6;



