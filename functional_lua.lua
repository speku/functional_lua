-- functions for programming in a functional style

function compose(...)
	return function(x)
	  for _,f in ipairs{...} do
		x = f(x)
	  end
	  return x
	end
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
	local _a = a 
	for _,v in pairs(xs) do
		_a = f(_a,v)
	end
	return _a
end

function foldi(f,a,xs)
	local _a = a 
	for _,v in ipairs(xs) do
		_a = f(_a,v)
	end
	return _a
end


function fold_(f,xs)
	local _a 
	for k,v in pairs(xs) do
		if _a == nil then
			_a = v
		else
			_a = f(_a,v)
		end
	end 
	return _a
end

function _papply(f,x)
	return function(...)
		return f(x,...)
	end
end

function papply(f,...)
	for _,arg in ipairs{...} do
		f = _papply(f,arg)
	end
	return f
end

function range(s,f,st)
	local r = {}
	for i=s,f,st or 1 do 
		table.insert(r,i)
	end 
	return r
end