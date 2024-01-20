-- Inspired by https://stackoverflow.com/questions/74289155/formatting-docbook-admonitions-with-pandoc

-- pandoc -f markdown+hard_line_breaks -t pdf -o doc.pdf --lua-filter=admonitions.lua doc.md
-- pandoc -t json -o ast.json doc.md

local admonitions = {
	warning   = "warning",
	note      = "note",
	tip       = "tip",
	important = "important",
	caution   = "caution",
	abstract  = "abstract"
}
  
-- local opts = PANDOC_WRITER_OPTIONS -- reuse options to render snippets
-- opts.columns = opts.columns - 4    -- admons are indented by four spaces
-- opts.template = nil                -- render a snippet

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
	-- TEST NOT WORKS
	-- Nothing is printed in the document
	--
	-- local md = pandoc.write(pandoc.Pandoc(para.content), "markdown", opts)
	-- return pandoc.RawBlock("markdown", md)
	
	-- ------------------------------------------------------------------------
	-- TEST WORKS
	-- But add "\n" between each words
	--
	-- return para.content
	
	-- ------------------------------------------------------------------------
	-- TEST WORKS
	--
	-- return para

	-- ------------------------------------------------------------------------
	-- TEST WORKS
	--
	-- return pandoc.Para{"Text from lua filter."}

	-- ------------------------------------------------------------------------
	-- TEST NOT WORKS
	--
	-- local new_para = pandoc.Para{pandoc.Str "Text from lua filter. \n I am another line."}
	-- print("new_para.content = ", new_para.content)
	-- print("new_para.tag = ", new_para.tag)
	-- return new_para

	-- ------------------------------------------------------------------------
	-- TEST WORKS
	--
	-- local txt = "Text from lua filter"
	-- local new_para = pandoc.Para{}
	-- new_para.content = txt
	-- return new_para

	-- ------------------------------------------------------------------------
	-- TEST WORKS
	--
	-- local txt = "Text from lua filter"
	-- local new_para = pandoc.Para{}
	-- new_para.content = txt
	-- return new_para
  
	-- ------------------------------------------------------------------------
	-- TEST WORKS
	--
	-- local doc = pandoc.Pandoc(pandoc.Para{"Text from lua filter."})
	-- local doc_txt = pandoc.write(doc, "markdown")
	-- return pandoc.Para(doc_txt)
	
	-- ------------------------------------------------------------------------
	-- TEST WORKS
	-- But linebreaks are not kept.
	--
	-- local doc = pandoc.Pandoc(para)
	-- local doc_txt = pandoc.write(doc, "markdown")
	-- local new_para = pandoc.Para(doc_txt)
	-- return new_para
	
	-- ------------------------------------------------------------------------
	-- TEST NOT WORKS
	--
	-- local doc = pandoc.Pandoc(para)
	-- local doc_txt = pandoc.write(doc, "markdown")
	-- return pandoc.RawBlock("markdown", doc_txt)
	
	-- ------------------------------------------------------------------------
	-- TEST WORKS
	-- But linebreaks are not kept.
	--
	-- local doc = pandoc.Pandoc(para)
	-- local doc_txt = pandoc.write(doc, "markdown")
	-- doc_txt = doc_txt:gsub("\\", "\n")
	-- local new_para = pandoc.Para(doc_txt)
	-- return new_para
	
	-- ------------------------------------------------------------------------
	-- TEST WORKS
	--
	-- local new_para = pandoc.Para{}
	-- table.insert(new_para.content, pandoc.RawInline("latex", "\\textcolor{red}{I am a red text}"))
	-- return new_para
	
	-- ------------------------------------------------------------------------
	-- TEST WORKS
	--
	-- local str_color_box = "\\fcolorbox{black}{yellow}{\
	-- \\begin{minipage}{3cm}\
	-- Un\
	--  \
	-- Texte\
	-- \
	-- Sur\
	-- \
	-- Plusieurs\
	-- \
	-- Lignes\
	-- \\end{minipage}}"
	-- local new_para = pandoc.Para{}
	-- table.insert(new_para.content, pandoc.RawInline("latex", str_color_box))
	-- return new_para
	
	-- ------------------------------------------------------------------------
	-- TEST WORKS
	--
	-- local str_color_box = "\\begin{tcolorbox} \
	-- 	This is a \textbf{tcolorbox}. \
	-- 	\\end{tcolorbox}"
	-- local new_para = pandoc.Para{}
	-- table.insert(new_para.content, pandoc.RawInline("latex", str_color_box))
	-- return new_para
	
	-- ------------------------------------------------------------------------
	-- TEST WORKS
	--
	-- local str_color_box = "\\begin{simple_box}{A physical explanation of the \\emph{dynamic matrix}}A text inside the box.\\end{simple_box}"
	-- local new_para = pandoc.Para{}
	-- table.insert(new_para.content, pandoc.RawInline("latex", str_color_box))
	-- return new_para
	
	-- ------------------------------------------------------------------------
	-- TEST WORKS
	--
	-- local str_color_box = "\\myboxcomplete{note}{A Title}{A text inside the box.}"
	-- local new_para = pandoc.Para{}
	-- table.insert(new_para.content, pandoc.RawInline("latex", str_color_box))
	-- return new_para
  
	-- ------------------------------------------------------------------------
	-- TEST WORKS
	--
	-- local doc = pandoc.Pandoc(para)
	-- local doc_txt = pandoc.write(doc, "markdown")
	-- local new_para = pandoc.Para(doc_txt)

	-- for k, v in ipairs(new_para.content) do
	-- 	if v.t == "SoftBreak" then
	-- 		new_para.content[k] = pandoc.LineBreak{}

	-- 		if k > 1 then
	-- 			new_para.content[k-1] = new_para.content[k-1].text:sub(1, -2)
	-- 		end
	-- 	end
	-- end

	-- print("new_para.content = ", new_para.content)
	-- return new_para
	
	-- ------------------------------------------------------------------------
	-- TEST WORKS
	--
	-- local str_1 = "\\myboxcomplete{note}"
	-- local str_2 = "{A Title}"
	-- local str_3 = "{A text inside the box."
	-- local str_4 = "And another line.}"
	-- local str_color_box = "\\myboxcomplete{note}{A Title}{A text inside the box.\n And another line.}"
	-- local new_para = pandoc.Para{}
	-- -- table.insert(new_para.content, pandoc.RawInline("latex", str_color_box))
	-- table.insert(new_para.content, pandoc.RawInline("latex", str_1))
	-- table.insert(new_para.content, pandoc.RawInline("latex", str_2))
	-- table.insert(new_para.content, pandoc.RawInline("latex", str_3))
	-- table.insert(new_para.content, pandoc.LineBreak{})
	-- table.insert(new_para.content, pandoc.RawInline("latex", str_4))

	-- -- Format the Para
	-- for k, v in ipairs(new_para.content) do
	-- 	if v.t == "SoftBreak" then
	-- 		new_para.content[k] = pandoc.LineBreak{}

	-- 		if k > 1 then
	-- 			new_para.content[k-1] = new_para.content[k-1].text:sub(1, -2)
	-- 		end
	-- 	end
	-- end

	-- print("new_para.content = ", new_para.content)
	-- return new_para
	
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

	table.insert(para.content, 1, pandoc.RawInline("latex", "\\begin{simple_box}{Test}\\end{simple_box}"))
	table.insert(para.content, 1, pandoc.RawInline("latex", "\\myboxcomplete{"..admonition_text.."}{"..title.."}{"))
	table.insert(para.content, pandoc.RawInline("latex", "}"))

	-- print("para = ", para)

	return para

end
