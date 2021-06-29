-- rand/init.lua

rand = {pr = PcgRandom(minetest.get_mapgen_setting("seed"))}

function rand.dy(y)
	return rand.pr:next(1, y)
end

function rand.az(a, z)
	return rand.pr:next(a, z)
end

function rand.xdy(x, y)
	local out = 0
	for i = 1, x do
		out = out + rand.pr:next(1, y)
	end
	return out
end

function rand.seq(a, z)
	if not z then
		z = a
		a = 1
	end
	local seq = {}
	for i = a, z do
		table.insert(seq, i)
	end
	local tmp
	for i = 1, #seq do
		j = rand.dy(#seq)
		tmp = seq[i]
		seq[i] = seq[j]
		seq[j] = tmp
	end
	return seq
end

function rand.pick(parts, vals, count)
	count = count or 1
	if #parts < 1 or #vals < 1 then 
		return 
	elseif count >= #vals then
		return vals
	end

	local sum = parts[1]
	local thresholds = {0, parts[1]}
	for i = 2, #parts do
		sum = sum + parts[i]
		table.insert(thresholds, sum)
	end
	local max = sum

	local random 
	local out = {}
	for i = 1, count do
		random = rand.dy(max)
		for j = 2, #thresholds do
			if random > thresholds[j - 1] and random <= thresholds[j] then
				table.insert(out, vals[j - 1])
				break
			end
		end
	end
	return out
end

