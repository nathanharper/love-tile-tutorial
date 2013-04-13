local sprite
local sx,sy = 0,0

function loadMap(path)
  love.filesystem.load(path)() -- attention! extra parenthesis
end

function newMap(tileWidth, tileHeight, tilesetPath, tileString, quadInfo)
  local tileW = tileWidth
  local tileH = tileHeight
  local tileset = love.graphics.newImage(tilesetPath)
  
  local tilesetW, tilesetH = tileset:getWidth(), tileset:getHeight()
  sprite = love.graphics.newSpriteBatch(tileset) -- TODO: set max num of sprites
  
  local quads = {}
  
  for _,info in ipairs(quadInfo) do
    -- info[1] = the character, info[2] = x, info[3] = y
    quads[info[1]] = love.graphics.newQuad(info[2], info[3], tileW,  tileH, tilesetW, tilesetH)
  end
  
  local width = #(tileString:match("[^\n]+"))

  local rowIndex,columnIndex = 1,1
  for row in tileString:gmatch("[^\n]+") do
    assert(#row == width, 'Map is not aligned: width of row ' .. tostring(rowIndex) .. ' should be ' .. tostring(width) .. ', but it is ' .. tostring(#row))
    columnIndex = 1
    for character in row:gmatch(".") do
      sprite:addq(quads[character], (columnIndex-1)*tileW, (rowIndex-1)*tileH)
      columnIndex = columnIndex + 1
    end
    rowIndex=rowIndex+1
  end

end

function drawMap()
  love.graphics.draw(sprite,sx,sy)
end

function updateMap(dx,dy)
    sx = sx+dx
    sy = sy+dy
end
