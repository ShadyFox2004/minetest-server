-- t4b/init.lua

t4b = {}

function t4b.count(tab)
	local count = 0
	for _ in pairs(tab) do
		count = count + 1
	end
	return count
end
