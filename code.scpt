-- WorkFlowy and OmniOutliner use different indent letters. (two spaces and tab)
-- This is the Problem!


-- 1. copy text

-- At first, in the Workflowy web page, 
-- Choose 'Export lists' > 'Plain text'
-- Copy your lists as plain text

set workFlowyPlainText to the clipboard

--2. Convert all lines to the list

set workFlowyList to textToList(workFlowyPlainText, return) of me

set newLists to {}

repeat with aLine in workFlowyList
	
	if aLine is not "" then --ignore a blank line
		
		--first indent doesn't have no hyphen.
		if aLine contains "-" then -- more than second indents
			set aLine to replaceText(aLine, "-  ", "- ") of me -- in case, first letter of a line is space
			
			set aLine to replaceText(aLine, "  ", tab) of me -- convert two space to tab
			set aLine to replaceText(aLine, "-", tab & "-") of me -- add a indent because second indent is placed on first indent position.
		else --first indent
			set aLine to "- " & aLine
		end if
		
		set end of newLists to aLine
	end if
	
end repeat

set newText to listToText(newLists, return) of me
set the clipboard to newText

--log newText



on textToList(aList, aDelim)
	set aText to ""
	set curDelim to AppleScript's text item delimiters
	set AppleScript's text item delimiters to aDelim
	set aText to aList as text
	set AppleScript's text item delimiters to curDelim
	return aText
end textToList

on listToText(aData, aDelim)
	set curDelim to text item delimiters of AppleScript
	set text item delimiters of AppleScript to aDelim
	set dList to text items of aData
	set text item delimiters of AppleScript to curDelim
	return dList
end listToText

on replaceText(theText, serchStr, replaceStr)
	set tmp to AppleScript's text item delimiters
	set AppleScript's text item delimiters to serchStr
	set theList to every text item of theText
	set AppleScript's text item delimiters to replaceStr
	set theText to theList as string
	set AppleScript's text item delimiters to tmp
	return theText
end replaceText
