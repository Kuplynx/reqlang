module http

import regex
import misc

/*
	Takes a HTTP call in the format: 
	METHOD URL
	(optional) HEADER	
	and translates it to a V net.http call.
 */

fn translate_get(code[] string) []string {
	mut firstline_re, _, _ := regex.regex_base("[\(]+([:= _a-zA-Z0-9]*)[\)]+ [\{]+")
	mut func_name := firstline_re.replace(code[0].replace("req", "").replace(" ", ""), "")
	func_name = misc.convert_to_snake_case(func_name).split("(").first()
	url := firstline_re.replace(code[1].replace("req", ""), "").replace(" ", "").replace("GET", "")
	return ["fn $func_name\() ?http.Response {
	return http.get($url)
}"]
}


pub fn translate(code[] string) []string {
	if code[1].contains("GET") {
		return translate_get(code)
	}
	return ["Not Implemented"]
}