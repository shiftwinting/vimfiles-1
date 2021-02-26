local Path = require'plenary.path'

local M = {}

-- @Summary path から一番近い markers を含むディレクトリを返す
-- @Description
-- @Param  markers ファイル名かディレクトリ名のリスト
-- @Param  path 起点となるパス
M.nearest_ancestor = function(markers, path)
  local root = '/'
  local p = Path:new(path)

  -- / になるまで、上に遡る
  while p:absolute() ~= root do
    for _, name in ipairs(markers) do
      if p:joinpath(name):exists() then
        return p:absolute()
      end
    end

    -- /home の parents() は nil になるため
    if p:parents() == nil then
      p = Path:new('/')
    else
      p = Path:new(p:parents())
    end

  end

  -- /.git とかを探す
  for _, name in ipairs(markers) do
    if p:joinpath(name):exists() then
      return p:absolute()
    end
  end

  return ''
end


return M
