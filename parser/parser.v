module parser

import regex

fn create_vars(code string) {
	/* Regular expression which converts a camelCase variable into a snake_case variable. */
	mut var_re, _, _ := regex.regex_base("([a-z])([A-Z])")
	mut fmt := "mut " + var_re.replace_simple(code, "_").replace(";", "").replace("=", " := ")
	println(fmt)
}

pub fn transpile(code string) {
	create_vars(code)
}