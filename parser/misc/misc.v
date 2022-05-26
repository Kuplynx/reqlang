module misc

import regex



pub fn convert_to_snake_case(line string) string{
	/* 
		Converts a reqlang camelCase object name to snake_case

		Explaining this algorithm as I found it hard to understand myself
		1. Find all characters which are upper case and put them in a list
		2. Split the list from the upper case characters
		3. Remove the first element of the list as it is lowercase and put it in a string
		4. Loop over the list and put the first character of each word into the list with an _ in between
		- If index is 0, then use the first index of the list
		- Add the character every other index past the first index
		5. Join the list into a string
		6. Add the first string, which is lowercase, to the list
		7. Return 
	*/

	mut re, _, _ := regex.regex_base("([A-Z])")
	mut upper_case_characters := re.find_all_str(line)
	mut chars := re.split(line)
	first := chars[0]
	chars.delete(0)
	if upper_case_characters.len == 1 {
		chars.insert(0, "_" + upper_case_characters[0])
	} else {
		for i in 0..chars.len {
			if i == 0 {
				chars.insert(0, "_" + upper_case_characters[i])
			} else if i % 2 == 0 {
				chars.insert(i, "_" + upper_case_characters[i/2])
			}
		}
	}
	return first + chars.join("").to_lower().replace(";", "")
}