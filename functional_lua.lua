-- functions for programming in a functional style

-- function compose(...)
-- 	local args = {...}
-- 	return function(x)
-- 	  for _,f in ipairs(args) do
-- 			x = f(x)
-- 	  end
-- 	  return x
-- 	end
-- end

function id(...)
	return ...
end

function curry(f)
	return function(x)
		return function(y)
			return f(x,y)
		end
	end
end

function uncurry(f)
	return function(x,y)
		return f(x)(y)
	end
end

function papply(f,a,...)
	return
		a == nil and f or
		papply(function(...) return f(a,...) end, ...)
end

function compose(f,g,...)
	local r = {...}
	return
		not g and f or
		function(...)
			return compose(g,unpack(r))(f(...))
		end
end

function map(f,xs)
	local _xs = {}
	for k,v in pairs(xs) do
		_xs[k] = f(v)
	end
	return _xs
end

function mapi(f,xs)
	local _xs = {}
	for _,v in ipairs(xs) do
		table.insert(_xs,f(v))
	end
	return _xs
end

function filter(p,xs)
	local _xs = {}
	for k,v in pairs(xs) do
		if p(v) then
			_xs[k] = v
		end
	end
	return _xs
end

function filteri(p,xs)
	local _xs = {}
	for _,v in ipairs(xs) do
		if p(v) then
			table.insert(_xs,v)
		end
	end
	return _xs
end

function fold(f,a,xs)
	for _,v in pairs(xs) do
		a = f(a,v)
	end
	return a
end

function foldi(f,a,xs)
	for _,v in ipairs(xs) do
		a = f(a,v)
	end
	return a
end

function fold_(f,xs,a)
	for _,v in pairs(xs) do
		a = a and f(a,v) or a
	end
	return a
end

-- local function _papply(f,x)
-- 	return function(...)
-- 		return f(x,...)
-- 	end
-- end
--
-- function papply(f,...)
-- 	for _,arg in ipairs{...} do
-- 		f = _papply(f,arg)
-- 	end
-- 	return f
-- end

function range(s,f,st)
	local r = {}
	for i=s,f,st or 1 do
		table.insert(r,i)
	end
	return r
end


-- local function _foldr(f,a,...)
-- 	if select("#",...) == 0 then
-- 		return a
-- 	else
-- 		return f(select(1,...),function() return _foldr(f,a,select(2,...)) end) -- _foldr(f,f(a,select(1,...)),select(2,...))
-- 	end
-- end

function skip(n,...)
	return select(n+1,...)
end

local function skipa(n,...)
	return {skip(n,...)}
end

-- local function _foldr(f,a,...)
-- 	if select("#",...) == 0 then
-- 		return a
-- 	else
-- 		local x = ...
-- 		local rest = skipa(1,...)
-- 		return f(x,function() return _foldr(f,a,unpack(rest)) end)
-- 	end
-- end
--
-- function foldr(f,a,xs)
-- 	return _foldr(f,a,unpack(xs))
-- end
--
-- function map(f,xs)
-- 	return foldr(function(x,a) a = a(); table.insert(a,f(x)); return a end,{},xs)
-- end
--
-- function all(xs)
-- 	return foldr(function(x,a) return x and a() end,true,xs)
-- end
