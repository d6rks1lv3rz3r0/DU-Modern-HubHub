----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------- Initialize -----------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
--Converts boolean to 1,0 for easier checking.
boolTonumber={[true]=1,[false]=0}

if not _init then
    
    NHubs = 0
    DataTable = {}
    Empty = {}
    Page = 1
    PageMax = 1
    
    Cards = false
    Table = true
    
    ReloadPressedTime = 0
    ReloadButtonToggle = true
    _init = true
    
    ItemSort = false
    QuantitySort = false
    VolumeSort = true
    MassSort = false
    
end

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function mysplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

Payload = getInput()

if Payload ~= nil and Payload ~= '' then
        
    PayloadType = mysplit(Payload, "&")    
    
    Info = mysplit(PayloadType[1], "$")
    NHubs = Info[1]
    Page = Info[2]
    PageMax = Info[3]
    DisplayMode = Info[4]
    SortSwitch = Info[5]
    UpdateTime = Info[6]
    
    if SortSwitch == 1 then
        ItemSort = false
        QuantitySort = false
        VolumeSort = true
        MassSort = false
    elseif SortSwitch == 2 then
        ItemSort = false
        QuantitySort = true
        VolumeSort = false
        MassSort = false
    elseif SortSwitch == 3 then
        ItemSort = false
        QuantitySort = false
        VolumeSort = false
        MassSort = true
    elseif SortSwitch == 4 then
        ItemSort = true
        QuantitySort = false
        VolumeSort = false
        MassSort = false
    end
    
    if DisplayMode == "Table" then
        Cards = false
        Table = true
    elseif DisplayMode == "Cards" then
        Cards = true
        Table = false
    end
    
    
    HubsInfo = mysplit(PayloadType[2], "$")
    
    if PayloadType[3] ~= nil and PayloadType[3] ~= '' then
        
        DataRows = mysplit(PayloadType[3], "#")  
        DataTable = {}
        for idx, v in ipairs(DataRows) do
            CurrentRow = mysplit(v, "$") 
            DataTable[idx] = {Q = CurrentRow[1],V = CurrentRow[2],M = CurrentRow[3],I = CurrentRow[4],N = CurrentRow[5]}
        end
        
    end

end

----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------- Background -----------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------

local rx, ry = getResolution()
local vw = rx/100
local vh = ry/100
local Logo = createLayer()
local LogoCurtain = createLayer()
local Aura0 = createLayer()
local Aura1 = createLayer()
local Font = loadFont(getAvailableFontName(5), 6*vh)

setNextFillColor(Aura0,0,0.2,0.8,0.15)
setNextShadow(Aura0,100*vh,0,0.2,0.8,0.15)
addBox(Aura0, 40*vw, 40*vh, 20*vw, 20*vh)

for ii = 3,165,8 do
    setNextStrokeColor(Aura0,0,0.2,0.8,0.05)
    setNextStrokeWidth(Aura0,0.05*vh)
    addLine(Aura0,ii*vh,0,ii*vh,ry)
end

for ii = 6,98,8 do
    setNextStrokeColor(Aura0,0,0.2,0.8,0.05)
    setNextStrokeWidth(Aura0,0.05*vh)
    addLine(Aura0,0,ii*vh,rx,ii*vh)
end

PX = {0,0.2,0.23,0.77,0.8,1}
PY = {0.03,0.03,0.07,0.07,0.03,0.03}
    
for ii = 1,#PX-1,1 do
    setNextStrokeColor(Aura1, 0,0.4,0.8, 1) 
    addLine(Aura1, PX[ii]*rx, PY[ii]*ry, PX[ii+1]*rx, PY[ii+1]*ry) 
end

for ii = 1,#PX-1,1 do
    setNextStrokeColor(Aura1, 0,0.4,0.8, 1) 
    addLine(Aura1, PX[ii]*rx, ry-PY[ii]*ry, PX[ii+1]*rx, ry-PY[ii+1]*ry) 
end

setFontSize(Font, 4*vh)
setNextTextAlign(Aura1, AlignH_Center, AlignV_Middle)
setNextFillColor(Aura1, 255/255, 255/255, 255/255, 1)
addText(Aura1, Font, "Refreshed: " .. round(tonumber(UpdateTime)/60,1) .. " Minutes Ago" , 0.5*rx ,0.035*ry)

----------
-- Logo --
----------

X = {400, 420, 380, 322, 322, 380, 432, 432, 444, 444}
Y = {641+20, 509+20, 472+20, 526+20, 272+20, 326+20, 285+20, 188+20, 188+20, 285+20}

local s = 875/ry
local t = (rx - ry)/2
local LogoAlpha = 1

setNextFillColor(LogoCurtain,0/255, 0/255, 0/255,0.9)
addBox(LogoCurtain, 40*vw, 20*vh, 20*vw, 60*vh)

-- Zero --

setDefaultFillColor(Logo, Shape_Polygon, 144/255, 144/255, 144/255, 1)

addQuad(Logo,X[1]/s + t,Y[1]/s,X[2]/s + t,Y[2]/s,X[3]/s + t,Y[3]/s,X[4]/s + t,Y[4]/s)
setNextFillColor(Logo,160/255, 160/255, 160/255,LogoAlpha)
addQuad(Logo,X[3]/s + t,Y[3]/s,X[4]/s + t,Y[4]/s,X[5]/s + t,Y[5]/s,X[6]/s + t,Y[6]/s)
addQuad(Logo,X[5]/s + t,Y[5]/s,X[6]/s + t,Y[6]/s,X[7]/s + t,Y[7]/s,X[8]/s + t,Y[8]/s)
addQuad(Logo,rx -1*(X[1]/s + t),Y[1]/s,rx -1*(X[2]/s + t),Y[2]/s,rx -1*(X[3]/s + t),Y[3]/s,rx -1*(X[4]/s + t),Y[4]/s)
setNextFillColor(Logo,120/255, 120/255, 120/255,LogoAlpha)
addQuad(Logo,rx -1*(X[3]/s + t),Y[3]/s,rx -1*(X[4]/s + t),Y[4]/s,rx -1*(X[5]/s + t),Y[5]/s,rx -1*(X[6]/s + t),Y[6]/s)
setNextFillColor(Logo,160/255, 160/255, 160/255,LogoAlpha)
addQuad(Logo,rx -1*(X[5]/s + t),Y[5]/s,rx -1*(X[6]/s + t),Y[6]/s,rx -1*(X[7]/s + t),Y[7]/s,rx -1*(X[8]/s + t),Y[8]/s)
addQuad(Logo,X[7]/s + t,Y[7]/s,X[8]/s + t,Y[8]/s,X[9]/s + t,Y[9]/s,X[10]/s + t,Y[10]/s)

-- Shading Zero --

setDefaultStrokeWidth(Logo,Shape_Line,1.5*vh)

setNextStrokeColor(Logo,110/255, 110/255, 110/255, LogoAlpha)
addLine(Logo,X[4]/s + t,Y[4]/s,X[5]/s + t,Y[5]/s)

setNextStrokeColor(Logo,90/255, 90/255, 90/255, LogoAlpha)
addLine(Logo,X[6]/s + t,Y[6]/s,X[3]/s + t,Y[3]/s)

setNextStrokeColor(Logo,155/255, 155/255, 155/255, LogoAlpha)
addLine(Logo,X[2]/s + t,Y[2]/s,X[3]/s + t,Y[3]/s)

setNextStrokeColor(Logo,80/255, 80/255, 80/255, LogoAlpha)
addLine(Logo,X[1]/s + t,Y[1]/s,X[4]/s + t,Y[4]/s)

setNextStrokeColor(Logo,100/255, 100/255, 100/255, LogoAlpha)
addLine(Logo,X[1]/s + t,Y[1]/s,X[2]/s + t,Y[2]/s)

setNextStrokeColor(Logo,60/255, 60/255, 60/255, LogoAlpha)
addLine(Logo,X[6]/s + t,Y[6]/s,X[7]/s + t,Y[7]/s)

setNextStrokeColor(Logo,110/255, 110/255, 110/255, LogoAlpha)
addLine(Logo,rx -1*(X[4]/s + t),Y[4]/s,rx -1*(X[5]/s + t),Y[5]/s)

setNextStrokeColor(Logo,90/255, 90/255, 90/255, LogoAlpha)
addLine(Logo,rx -1*(X[6]/s + t),Y[6]/s,rx -1*(X[3]/s + t),Y[3]/s)

setNextStrokeColor(Logo,130/255, 130/255, 130/255, LogoAlpha)
addLine(Logo,X[5]/s + t,Y[5]/s,X[8]/s + t,Y[8]/s)

setNextStrokeColor(Logo,155/255, 155/255, 155/255, LogoAlpha)
addLine(Logo,rx -1*(X[2]/s + t),Y[2]/s,rx -1*(X[3]/s + t),Y[3]/s)

setNextStrokeColor(Logo,80/255, 80/255, 80/255, LogoAlpha)
addLine(Logo,rx -1*(X[1]/s + t),Y[1]/s,rx -1*(X[4]/s + t),Y[4]/s)

setNextStrokeColor(Logo,100/255, 100/255, 100/255, LogoAlpha)
addLine(Logo,rx -1*(X[1]/s + t),Y[1]/s,rx -1*(X[2]/s + t),Y[2]/s)

setNextStrokeColor(Logo,60/255, 60/255, 60/255, LogoAlpha)
addLine(Logo,rx -1*(X[6]/s + t),Y[6]/s,rx -1*(X[7]/s + t),Y[7]/s)

setNextStrokeColor(Logo,130/255, 130/255, 130/255, LogoAlpha)
addLine(Logo,rx -1*(X[5]/s + t),Y[5]/s,rx -1*(X[8]/s + t),Y[8]/s)

setNextStrokeColor(Logo,130/255, 130/255, 130/255, LogoAlpha)
addLine(Logo,X[8]/s + t,Y[8]/s,rx -1*(X[8]/s + t),Y[8]/s)

----------
-- Logo --
----------


----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------- Foreground -----------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------- Buttons / Tabs -------------------------------------------------------------------------

local SubFont = loadFont(getAvailableFontName(9), 3*vh)

local function insidePolygon(polygon, x, y)
    point = {x = x, y = y}
    local oddNodes = false
    local j = #polygon
    for i = 1, #polygon do
        if (polygon[i].y < point.y and polygon[j].y >= point.y or polygon[j].y < point.y and polygon[i].y >= point.y) then
            if (polygon[i].x + ( point.y - polygon[i].y ) / (polygon[j].y - polygon[i].y) * (polygon[j].x - polygon[i].x) < point.x) then
                oddNodes = not oddNodes;
            end
        end
        j = i;
    end
    return oddNodes 
end

setFontSize(Font, 4*vh)
wb, hb = getTextBounds(Font,"Reload Data")
ReloadPoly = {
    {x = 0.10*rx - wb/2,y = 94.5*vh - hb/2},
    {x = 0.10*rx - wb/2,y = 94.5*vh + hb/2},
    {x = 0.10*rx + wb/2,y = 94.5*vh + hb/2},
    {x = 0.10*rx + wb/2,y = 94.5*vh - hb/2}
}

setFontSize(Font, 4*vh)
wb, hb = getTextBounds(Font,"Cards")
CardsPoly = {
    {x = 0.10*rx - wb,y = 3.5*vh},
    {x = 0.10*rx - wb,y = 3.5*vh + hb},
    {x = 0.10*rx,y = 3.5*vh + hb},
    {x = 0.10*rx,y = 3.5*vh}
}

setFontSize(Font, 4*vh)
wb, hb = getTextBounds(Font,"Table")
TablePoly = {
    {x = 0.12*rx + wb,y = 3.5*vh},
    {x = 0.12*rx + wb,y = 3.5*vh + hb},
    {x = 0.12*rx,y = 3.5*vh + hb},
    {x = 0.12*rx,y = 3.5*vh}
}

setFontSize(Font, 4*vh)
wb, hb = getTextBounds(Font,"Item")
ItemPoly = {
    {x = 9.5*vh + 2.5*vh + wb,y = 15*vh - 0.5*vh},
    {x = 9.5*vh + 2.5*vh + wb,y = 15*vh - 0.5*vh - hb},
    {x = 9.5*vh + 2.5*vh,y = 15*vh - 0.5*vh - hb},
    {x = 9.5*vh + 2.5*vh,y = 15*vh - 0.5*vh}
}

setFontSize(Font, 4*vh)
wb, hb = getTextBounds(Font,"Quantity")
QuantityPoly = {
    {x = 9.5*vh + 114.5*vh - 12.5*vh - wb/2,y = 15*vh - 0.5*vh},
    {x = 9.5*vh + 114.5*vh - 12.5*vh - wb/2,y = 15*vh - 0.5*vh - hb},
    {x = 9.5*vh + 114.5*vh - 12.5*vh + wb/2,y = 15*vh - 0.5*vh - hb},
    {x = 9.5*vh + 114.5*vh - 12.5*vh + wb/2,y = 15*vh - 0.5*vh}
}

setFontSize(Font, 4*vh)
wb, hb = getTextBounds(Font,"Volume")
VolumePoly = {
    {x = 9.5*vh + 114.5*vh - 35*vh - wb/2,y = 15*vh - 0.5*vh},
    {x = 9.5*vh + 114.5*vh - 35*vh - wb/2,y = 15*vh - 0.5*vh - hb},
    {x = 9.5*vh + 114.5*vh - 35*vh + wb/2,y = 15*vh - 0.5*vh - hb},
    {x = 9.5*vh + 114.5*vh - 35*vh + wb/2,y = 15*vh - 0.5*vh}
}

setFontSize(Font, 4*vh)
wb, hb = getTextBounds(Font,"Mass")
MassPoly = {
    {x = 9.5*vh + 114.5*vh - 53*vh - wb/2,y = 15*vh - 0.5*vh},
    {x = 9.5*vh + 114.5*vh - 53*vh - wb/2,y = 15*vh - 0.5*vh - hb},
    {x = 9.5*vh + 114.5*vh - 53*vh + wb/2,y = 15*vh - 0.5*vh - hb},
    {x = 9.5*vh + 114.5*vh - 53*vh + wb/2,y = 15*vh - 0.5*vh}
}



if getCursorPressed() then
    
    x, y = getCursor()
    
    if insidePolygon(ReloadPoly, x, y) and ReloadButtonToggle then
        setOutput('Reload')
        ReloadPressedTime = getTime()
    elseif insidePolygon(TablePoly, x, y) and Cards then
        Table = true
        Cards = false
        setOutput('Table')
        logMessage('Table')
    elseif insidePolygon(CardsPoly, x, y) and Table then
        Table = false
        Cards = true
        setOutput('Cards')
        logMessage('Cards')
    elseif insidePolygon(ItemPoly, x, y) and not ItemSort then
        ItemSort = true
        QuantitySort = false
        VolumeSort = false
        MassSort = false
        setOutput('Item')
        logMessage('Item')
    elseif insidePolygon(QuantityPoly, x, y) and not QuantitySort then
        ItemSort = false
        QuantitySort = true
        VolumeSort = false
        MassSort = false
        setOutput('Quantity')
        logMessage('Quantity')
    elseif insidePolygon(VolumePoly, x, y) and not VolumeSort then
        ItemSort = false
        QuantitySort = false
        VolumeSort = true
        MassSort = false
        setOutput('Volume')
        logMessage('Volume')
    elseif insidePolygon(MassPoly, x, y) and not MassSort then
        ItemSort = false
        QuantitySort = false
        VolumeSort = false
        MassSort = true
        setOutput('Mass')
        logMessage('Mass')
    end
         
end

CheckTime = getTime()
ReloadWaitTime = (NHubs - 1)*30

if (CheckTime-ReloadPressedTime) < CheckTime then
    ReloadText = string.format('Reloading: %.0fs',ReloadWaitTime - (CheckTime-ReloadPressedTime))
    ReloadButtonToggle = false
    if (CheckTime-ReloadPressedTime) > ReloadWaitTime then
        ReloadText = "Reload Data"
        ReloadButtonToggle = true
    end
else
    ReloadText = "Reload Data"
    ReloadButtonToggle = true
end

setFontSize(Font, 4*vh)
setNextTextAlign(Aura1, AlignH_Center, AlignV_Middle)
setNextFillColor(Aura1,0.8,0.8,0.3,1)
addText(Aura1,Font,ReloadText,0.10*rx,94*vh)

if Cards then
    setNextFillColor(Aura1,1,1,1,1)
else
    setNextFillColor(Aura1,0.8,0.8,0.3,1)
end
setFontSize(Font, 4*vh)
setNextTextAlign(Aura1, AlignH_Right, AlignV_Ascender)
addText(Aura1,Font,"Cards",0.10*rx,3.5*vh)

setFontSize(Font, 4*vh)
setNextTextAlign(Aura1, AlignH_Center, AlignV_Ascender)
setNextFillColor(Aura1,0.8,0.8,0.3,1)
addText(Aura1,Font,"|",0.11*rx,3.5*vh)

if Table then
    setNextFillColor(Aura1,1,1,1,1)
else
    setNextFillColor(Aura1,0.8,0.8,0.3,1)
end
setFontSize(Font, 4*vh)
setNextTextAlign(Aura1, AlignH_Left, AlignV_Ascender)
addText(Aura1,Font,"Table",0.12*rx,3.5*vh)

----------------------------------------------------------- Item Cards ---------------------------------------------------------------------

local function wrap(str, limit)
    local Lines, here, limit = {}, 1, limit or 72
    local Lim = (str:find("(%s+)()(%S+)()")) 
    if Lim == nil then Lim = string.len(str) else Lim = Lim -1 end
    Lines[1] = string.sub(str,1,Lim)  -- Put the first word of the string in the first index of the table.
  
    str:gsub("(%s+)()(%S+)()",
          function(sp, st, word, fi)  -- Function gets called once for every space found.
            if fi-here > limit then
                  here = st
                  Lines[#Lines+1] = word                                             -- If at the end of a line, start a new table index...
            else Lines[#Lines] = Lines[#Lines].." "..word end  -- ... otherwise add to the current table index.
          end)
  
    return Lines
  end
  
  function ItemCard(layer,font,data,X,Y,SX,SY,ibr,ibg,ibb)
  
      -- Top Corner --
      
      setNextStrokeColor(layer,ibr,ibg,ibb,1)
      setNextStrokeWidth(layer,0.5*vh)  
      addLine(layer, X, Y, X + SX*0.3 , Y)
  
      setNextStrokeColor(layer,ibr,ibg,ibb,0.75)
      setNextStrokeWidth(layer,0.5*vh)
      addLine(layer, X, Y, X , Y + SY*0.3)
  
      setNextFillColor(layer,ibr,ibg,ibb,1)
      addCircle(layer,X, Y, 1*vh)
      
      -- Bottom Corner --
  
      setNextStrokeColor(layer,ibr,ibg,ibb,0.75)
      setNextStrokeWidth(layer,0.5*vh)
      addLine(layer, X + SX, Y + SY, X + SX - SX*0.1 , Y + SY)
  
      setNextStrokeColor(layer,ibr,ibg,ibb,0.55)
      setNextStrokeWidth(layer,0.5*vh)
      addLine(layer, X + SX, Y + SY, X + SX, Y + SY - SY*0.2)
  
      setNextFillColor(layer,ibr,ibg,ibb,1)
      addCircle(layer,X + SX, Y + SY, 1*vh)
  
      -- Image --
      cpath = data["I"]
      cpath = string.gsub(cpath, "@","elements/")
      cpath = string.gsub(cpath, ">","functional")
      cpath = string.gsub(cpath, "<","iconslib/materialslib/env_")
      cpath = string.gsub(cpath, "!","icon")
      cpath = string.gsub(cpath, "ş","_001")
      cpath = string.gsub(cpath, "ç","part")
      url = "resources_generated/" .. cpath .. ".png"
      image = loadImage(url)
      addImage(layer, image, X + 1*vh, Y + 1*vh, 16*vh, 16*vh)
      
      -- Text --
  
      local myTable = wrap(data["N"],10)
      
      for ii = 1,math.min(#myTable,4) do
          setNextTextAlign(layer, AlignH_Left, AlignV_Ascender)
          setNextFillColor(layer, 255/255, 255/255, 255/255, 1)
          addText(layer, SubFont, myTable[ii], X+1*vh+17*vh, Y + 1*vh + (ii-1)*3*vh)
      end
  
      setNextTextAlign(layer, AlignH_Right, AlignV_Ascender)
      setNextFillColor(layer, 255/255, 255/255, 255/255, 1)
      addText(layer, font, tostring(data["Q"]), X+1*vh+38*vh, Y + 14*vh)
  
  end
  
  X = 2.5*vh
  Y = 12*vh
  SX = 40*vh
  SY = 18*vh
  
  local List = createLayer()
  
  ibr = 0.2
  ibg = 0.7
  ibb = 1
  
  ----------------------------------------------------------- Tabular Background ---------------------------------------------------------------------
  
  if Table then
  
      X = 9.5*vh
      Y = 15*vh
      SX = 114.5*vh
      SY = 4.5*vh
  
      local HeaderFont = loadFont(getAvailableFontName(5), 4*vh)
  
      setNextFillColor(List, 0,0.8,1,0.4 + 0.6*boolTonumber[ItemSort])
      setNextTextAlign(List, AlignH_Left, AlignV_Descender)
      addText(List, HeaderFont, "Item", X + 2.5*vh, Y - 0.5*vh)
  
      setNextFillColor(List, 0,0.8,1,0.4 + 0.6*boolTonumber[QuantitySort])
      setNextTextAlign(List, AlignH_Center, AlignV_Descender)
      addText(List, HeaderFont, "Quantity", X + SX - 12.5*vh, Y - 0.5*vh)
  
      setNextFillColor(List, 0,0.8,1,0.4 + 0.6*boolTonumber[VolumeSort])
      setNextTextAlign(List, AlignH_Center, AlignV_Descender)
      addText(List, HeaderFont, "Volume", X + SX - 35*vh, Y - 0.5*vh)
  
      setNextFillColor(List, 0,0.8,1,0.4 + 0.6*boolTonumber[MassSort])
      setNextTextAlign(List, AlignH_Center, AlignV_Descender)
      addText(List, HeaderFont, "Mass", X + SX - 53*vh, Y - 0.5*vh)
  
      for jj = 1,11 do
          setNextStrokeColor(List,1,1,1,0.05+jj*0.085)
          setNextStrokeWidth(List,0.02*vh+jj*0.02*vh)
          addLine(List,X + SX/21*(jj-1) + 0.1*vh, Y + (1-1)*10*vh, X + SX/21*(jj) - 0.1*vh, Y + (1-1)*10*vh)
      end
  
      for jj = 12,21 do
          setNextStrokeColor(List,1,1,1,1-(jj-11)*0.085)
          setNextStrokeWidth(List,0.22*vh-(jj-11)*0.02*vh)
          addLine(List,X + SX/21*(jj-1) + 0.1*vh, Y + (1-1)*10*vh, X + SX/21*(jj) - 0.1*vh, Y + (1-1)*10*vh)
      end
  
      for ii = 1,8 do
  
          setNextFillColor(List,1,1,1,0.1)
          addBox(List, X, Y + (ii-1)*2*SY, SX, SY)
  
          setNextFillColor(List,0,0.6,1,0.1)
          addBox(List, X, Y + (ii-1)*2*SY, SX, SY)
  
          setNextFillColor(List,1,1,1,0.1)
          addBox(List, X, Y + SY + (ii-1)*2*SY, SX, SY)
  
          setNextFillColor(List,0,0.3,0.5,0.1)
          addBox(List, X, Y + SY + (ii-1)*2*SY, SX, SY)
  
      end
      
  end
  
  ----------------------------------------------------------- Fill Data ---------------------------------------------------------------------
  
  if DataTable[1] ~= nil then
            
      if Cards then
          counter = 0
          for ii = 1,3 do
              for jj = 1,3 do
                  counter = counter + 1
                  if DataTable[counter] ~= nil then
                      ItemCard(List,SubFont,DataTable[counter],X+(ii-1)*44*vh,Y+(jj-1)*25*vh,SX,SY,ibr,ibg,ibb)
                  end
              end
          end
      end
      
      if Table then
          
          X = 9.5*vh
          Y = 13*vh
          
          for ii = 1,16 do
              
              if DataTable[ii] ~= nil then
                  
                  Row = DataTable[ii]
  
                  setNextFillColor(List, 1, 1, 1, 1)
                  setNextTextAlign(List, AlignH_Left, AlignV_Middle)
                  addText(List, SubFont, Row["N"], X + 3*vh, Y + SY + (ii-1)*SY)
  
                  setNextFillColor(List, 1, 1, 1, 1)
                  setNextTextAlign(List, AlignH_Center, AlignV_Middle)
                  addText(List, SubFont, Row["Q"], X + SX - 12.5*vh, Y + SY + (ii-1)*SY)
  
                  setNextFillColor(List, 1, 1, 1, 1)
                  setNextTextAlign(List, AlignH_Center, AlignV_Middle)
                  addText(List, SubFont, string.format('%.2f kL',Row["V"]/1000), X + SX - 35*vh, Y + SY + (ii-1)*SY)
  
                  setNextFillColor(List, 1, 1, 1, 1)
                  setNextTextAlign(List, AlignH_Center, AlignV_Middle)
                  addText(List, SubFont, string.format('%.2f t',Row["M"]/1000), X + SX - 53*vh, Y + SY + (ii-1)*SY)
                  
              end
          
          end
          
      end
      
  end
  
  ----------------------------------------------------------- Pagination -----------------------------------------------------------------
  
  if Cards then
  
      X = 40*vw
      Y = 87*vh
      SX = 70*vw
      SY = 5*vh
      SliderW = 40*vh
      SliderH = 5*vh
  
      Data = 100*(Page-1)/(PageMax-1);
  
      setNextFillColor(List,0.2,0.7,1,1)
      addBoxRounded(List, 
          X - SX/2 + Data/100*(SX-SliderW), 
          Y - SliderH/2, 
          SliderW, 
          SliderH,
          2*vh)	
  
      setNextFillColor(List,0,0.2,0.8,0.1)
      addBoxRounded(List, 
          X - SX/2,
          Y - SY/2, 
          SX, 
          SY,
          2*vh)
      
  end
  
  ----------------------------------------------------------- Horizontal Gauges --------------------------------------------------------------
  
  function HorizontalGauge(layer,font,Data,Mass,X,Y,SX,SY,n,r,g,b)
  
      Height = math.ceil(Data/(100/n))
  
      for jj = 1,Height,1 do
          setNextFillColor(layer,r,g,b,0.2+(jj^3)*(0.8/(Height^3)))
          addQuad(layer,
              X - SX/2 + (jj-1)*SX/n + SX/n*0.2,
              Y - SY/2,
              X - SX/2 + (jj-1)*SX/n + SX/n*0.2,
              Y + SY/2,
              X - SX/2 + (jj-1)*SX/n + SX/n*0.8,
              Y + SY/2,
              X - SX/2 + (jj-1)*SX/n + SX/n*0.8,
              Y - SY/2)
      end
  
      -- Flair --
  
      setNextStrokeColor(layer,r,g,b,1)
      setNextStrokeWidth(layer,0.5*vh)
      addLine(layer, X - SX/2 - vh, Y - SY/2 - vh, X - SX/2 - vh, Y - SY/2 - vh + SY*0.6 )
  
      setNextStrokeColor(layer,r,g,b,1)
      setNextStrokeWidth(layer,0.5*vh)
      addLine(layer, X - SX/2 - vh, Y - SY/2 - vh, X - SX/2 - vh + SX*0.4, Y - SY/2 - vh )
  
      setNextFillColor(layer,r,g,b,1)
      addCircle(layer,X - SX/2 - vh, Y - SY/2 - vh, 1*vh)
  
      setNextStrokeColor(layer,r,g,b,0.5)
      setNextStrokeWidth(layer,0.25*vh)
      addLine(layer, X + SX/2 + vh, Y + SY/2 + vh, X + SX/2 + vh, Y + SY/2 + vh - SY*0.5 )
  
      setNextStrokeColor(layer,r,g,b,0.5)
      setNextStrokeWidth(layer,0.25*vh)
      addLine(layer, X + SX/2 + vh, Y + SY/2 + vh, X + SX/2 + vh - SX*0.4, Y + SY/2 + vh )
  
      setNextFillColor(layer,r,g,b,1)
      addCircle(layer,X + SX/2 + vh, Y + SY/2 + vh, 0.5*vh)
      
      -- Text --
      
      setNextTextAlign(layer, AlignH_Left, AlignV_Middle)
      setNextFillColor(layer, r, g, b, 1)
      addText(layer, font, string.format("%.1f",Data) .. "%", X+SX/2+2*vh, Y)
      
      setNextTextAlign(layer, AlignH_Right, AlignV_Middle)
      setNextFillColor(layer, r, g, b, 1)
      addText(layer, font, string.format("%.1f",Mass) .. "t", X - SX/2 - 2*vh, Y)
  
  end
  
  R = {1,0.2,0.2,1,1,0,1,0.5}
  G = {0.2,1,0.2,1,0,1,0.5,0.2}
  B = {0.2,0.2,1,0,1,1,0.2,1}
  
  TotalMass = 0
  TotalVolume = 0
  TotalCapacity = 0
  
  for ii = 1,NHubs do
      M = HubsInfo[1+(ii-1)*3]
      V = HubsInfo[2+(ii-1)*3]
      C = HubsInfo[3+(ii-1)*3]
      
      TotalMass = TotalMass + M
      TotalVolume = TotalVolume + V
      TotalCapacity = TotalCapacity + C
      
      HorizontalGauge(List,SubFont,100*V/C,M,150*vh,28*vh+ii*8*vh,16*vh,3*vh,10,R[ii],G[ii],B[ii])
  end
  
  -------------------------------------------------------- Round Gauge  --------------------------------------------------------------
  
  local Pie = createLayer()
  
  x1 = 0.5
  x2 = 0.6
  y1 = 25
  y2 = 30
  
  Data = 100*TotalVolume/TotalCapacity
  
  for ii = 0,360*Data/100,7.2 do
      
      theta = 180 + ii
      
      setNextFillColor(Pie,1,1,1,1)
      addQuad(Pie,
          50*vw - (-x2*vw*math.cos(math.rad(theta))+y2*vh*math.sin(math.rad(theta))),
          50*vh - (-x2*vw*math.sin(math.rad(theta))-y2*vh*math.cos(math.rad(theta))),
          50*vw - (x2*vw*math.cos(math.rad(theta))+y2*vh*math.sin(math.rad(theta))),
          50*vh - (x2*vw*math.sin(math.rad(theta))-y2*vh*math.cos(math.rad(theta))),
          50*vw - (x1*vw*math.cos(math.rad(theta))+y1*vh*math.sin(math.rad(theta))),
          50*vh - (x1*vw*math.sin(math.rad(theta))-y1*vh*math.cos(math.rad(theta))),
          50*vw - (-x1*vw*math.cos(math.rad(theta))+y1*vh*math.sin(math.rad(theta))),
          50*vh - (-x1*vw*math.sin(math.rad(theta))-y1*vh*math.cos(math.rad(theta)))
      )
        
      
  end
  
  for ii = math.floor(360*Data/(7.2*100))*7.2,359,7.2 do
      
      theta = 180 + ii
      
      setNextFillColor(Pie,0.2,0.7,1,0.1)
      addQuad(Pie,
          50*vw - (-x2*vw*math.cos(math.rad(theta))+y2*vh*math.sin(math.rad(theta))),
          50*vh - (-x2*vw*math.sin(math.rad(theta))-y2*vh*math.cos(math.rad(theta))),
          50*vw - (x2*vw*math.cos(math.rad(theta))+y2*vh*math.sin(math.rad(theta))),
          50*vh - (x2*vw*math.sin(math.rad(theta))-y2*vh*math.cos(math.rad(theta))),
          50*vw - (x1*vw*math.cos(math.rad(theta))+y1*vh*math.sin(math.rad(theta))),
          50*vh - (x1*vw*math.sin(math.rad(theta))-y1*vh*math.cos(math.rad(theta))),
          50*vw - (-x1*vw*math.cos(math.rad(theta))+y1*vh*math.sin(math.rad(theta))),
          50*vh - (-x1*vw*math.sin(math.rad(theta))-y1*vh*math.cos(math.rad(theta)))
      )
        
      
  end
  
  setNextFillColor(Pie,0,0,0,0)
  setNextStrokeColor(Pie,0.2,0.7,1,1)
  setNextStrokeWidth(Pie,0.5*vh)
  addCircle(Pie,50*vw,50*vh,23*vh)
  
  setNextFillColor(Pie,0,0,0,0)
  setNextStrokeColor(Pie,0.2,0.7,1,1)
  setNextStrokeWidth(Pie,0.5*vh)
  addCircle(Pie,50*vw,50*vh,31.5*vh)
  
  setFontSize(Font, 5*vh)
  setNextTextAlign(Aura1, AlignH_Center, AlignV_Middle)
  setNextFillColor(Aura1,1,1,1,1)
  addText(Aura1,Font,string.format("%.2f",Data) .. "%",89.6*vw,16.5*vh)
  
  setFontSize(Font, 2.75*vh)
  setNextTextAlign(Aura1, AlignH_Center, AlignV_Middle)
  setNextFillColor(Aura1,1,1,1,1)
  addText(Aura1,Font,string.format("%.1f",TotalVolume) .. " kL",89.6*vw,20*vh)
  
  addLine(Aura1,85.6*vw,21.5*vh,93.6*vw,21.5*vh)
  
  setFontSize(Font, 2.75*vh)
  setNextTextAlign(Aura1, AlignH_Center, AlignV_Middle)
  setNextFillColor(Aura1,1,1,1,1)
  addText(Aura1,Font,string.format("%.1f",TotalCapacity) .. " kL",89.6*vw,23*vh)
  
  setFontSize(Font, 2.75*vh)
  setNextTextAlign(Aura1, AlignH_Center, AlignV_Middle)
  setNextFillColor(Aura1,1,1,1,1)
  addText(Aura1,Font,string.format("%.1f",TotalMass) .. " t",89.6*vw,12.5*vh)
  
  setLayerOrigin(Pie,0.5*rx,0.5*ry)
  setLayerScale(Pie,0.42,0.42)
  setLayerTranslation(Pie,0.395*rx,-0.32*ry)
  
  ------------------------------------------------------------------------------------------------------------------------------------------------
  
  requestAnimationFrame(60)