module parser

import regex


fn convert_to_snake_case(line string) string{
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
	return first + chars.join("").to_lower()
}

// fn create_func(lines []string) ?string[] {

// }

fn create_var(line string) string {
	/*
		Creates a variable declaration from reqlang to V
		Regular variables are declared with 'mut', constants are not
		All types are inferred by the compiler, no need to specify
	 */
	if line.starts_with("const ") {
		return convert_to_snake_case(line.replace("const ", "")).replace("=", ":=").replace(";", "")
	} else {
		return "mut " + convert_to_snake_case(line).replace("=", ":=").replace(";", "")
	}
}

fn pass_one(code string) string {
	/*
		Pass one of the transpiler
		This section converts variables
	*/

	println("Pass 1, creating variables...")
	mut findvar_re, _, _ := regex.regex_base("([a-zA-Z0-9_]+) = \"([^\"]*)\";")
	mut transpiled := code.split("\n")
	for i, line in transpiled {
		println("Searching line " + (i + 1).str() +"...")
		if findvar_re.find_all_str(line) != [] {
			println("\u001b[32mFound variable assignment\u001b[0m")
			transpiled[i] = create_var(line)
		}
	}
	return transpiled.join("\n")

}

fn pass_two(code string) string {
	/*
		Pass two of the transpiler
		This section converts 'req' functions
	*/

	println("Pass 2, creating 'req' functions...")
	mut findfunc_re, _, _ := regex.regex_base("req ([a-zA-Z0-9_]+) {\n([^}]*)\n}")
	mut funcs := findfunc_re.find_all_str(code)
	// for i, func_ in funcs {
	// 	println("\u001b[32mFound function " + func_ + "\u001b[0m")
	// 	funcs[i] = "func " + convert_to_snake_case(func_) + "(" + func_ + ") { " + func_ + " }"
	// }
	return "Not Implemented"

}


pub fn transpile(code string) string{
	println("Transpiling...")
	mut transpiled := pass_one(code)
	transpiled = pass_two(transpiled)
	return transpiled
}