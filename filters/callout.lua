-- https://github.com/gutenberg/latex-awesomebox?tab=readme-ov-file

local admonitions = {
	warning   = "warning",
	note      = "note",
	tip       = "tip",
	important = "important",
	caution   = "caution",
	abstract  = "abstract"
}

Para = function(para)
	if para.content[1] == nil then
		return para
	end

	local admonition_text = nil
	if para.content[1].text == "!!!" then
		admonition_text = admonitions[para.content[3].text]
	end

	-- not an admonition: exit
	if admonition_text == nil then return para end
	
	-- ------------------------------------------------------------------------
	-- TEST
	--
	local doc = pandoc.Pandoc(para)

	-- Remove
	table.remove(para.content, 1)
	table.remove(para.content, 1)
	table.remove(para.content, 1)
	
	local title = admonition_text:gsub("^%l", string.upper)
	if para.content[1].t == "LineBreak" then
		table.remove(para.content, 1)
	elseif para.content[1].t == "Space" then
		title = ""
		while para.content[1].t ~= "LineBreak" do
			if para.content[1].t == "Str" then
				title = title .. para.content[1].text .. " "
			end
			table.remove(para.content, 1)
		end
		table.remove(para.content, 1)
	end

	table.insert(para.content, 1, pandoc.RawInline("latex", "\\notebox{Lorem ipsum…}"))

	return para

end
